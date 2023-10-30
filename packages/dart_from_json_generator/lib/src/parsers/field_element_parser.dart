import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:dart_from_json_generator_annotation/dart_from_json_generator_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:source_gen/source_gen.dart';

import '../configs/field_config.dart';
import '../configs/json_converter_config.dart';

/// Parses a given [FieldElement] to produce a [FieldConfig] instance.
/// This function examines the metadata annotations of the [FieldElement]
/// to extract default values and any JsonConverter configurations.
///
/// Returns a [FieldConfig] that contains parsed configurations.
FieldConfig parseFieldElement(FieldElement element) {
  String? defaultValueString;
  JsonConverterConfig? jsonConverterConfig;

  final elementAnnotations = element.metadata;
  for (final elementAnnotation in elementAnnotations) {
    final fieldName = element.name;
    final source = elementAnnotation.toSource();
    final object = elementAnnotation.computeConstantValue()!;
    final objectType = object.type!;

    defaultValueString ??= _parseDefaultAnnotation(
      fieldName: fieldName,
      source: source,
      objectType: objectType,
    );
    jsonConverterConfig ??= _parseJsonConverterAnnotation(
      fieldName: fieldName,
      source: source,
      objectType: objectType,
    );
  }

  return FieldConfig(
    name: element.name,
    dartType: element.type,
    defaultValueString: defaultValueString,
    jsonConverterConfig: jsonConverterConfig,
  );
}

/// Parses the [Default] annotation to extract default value for a field.
///
/// - [fieldName]: The name of the field being parsed.
/// - [source]: The source code for the annotation.
/// - [objectType]: The Dart type of the annotation object.
///
/// Returns a string representing the default value for the field.
/// If the [Default] annotation is not present, returns null.
String? _parseDefaultAnnotation({
  required String fieldName,
  required String source,
  required DartType objectType,
}) {
  const defaultTypeChecker = TypeChecker.fromRuntime(Default);
  if (!defaultTypeChecker.isAssignableFromType(objectType)) {
    return null;
  }
  final defaultTypeString = objectType.getDisplayString(withNullability: false);
  final res =
      source.substring('@$defaultTypeString('.length, source.length - 1);
  final needsConstModifier = !objectType.isDartCoreString &&
      !res.trimLeft().startsWith('const') &&
      (res.contains('(') || res.contains('[') || res.contains('{'));
  if (needsConstModifier) {
    return 'const $res';
  } else {
    return res;
  }
}

/// Parses the [JsonConverter] annotation to extract converter configurations.
///
/// - [fieldName]: The name of the field being parsed.
/// - [source]: The source code for the annotation.
/// - [objectType]: The Dart type of the annotation object.
///
/// Returns a [JsonConverterConfig] that contains parsed configurations.
/// If the [JsonConverter] annotation is not present, returns null.
JsonConverterConfig? _parseJsonConverterAnnotation({
  required String fieldName,
  required String source,
  required DartType objectType,
}) {
  const jsonConverterTypeChecker = TypeChecker.fromRuntime(JsonConverter);
  if (!jsonConverterTypeChecker.isAssignableFromType(objectType)) {
    return null;
  }
  final interfaceTypes = (objectType.element! as ClassElement)
      .allSupertypes
      .where((t) => jsonConverterTypeChecker.isExactlyType(t));
  final typeArguments = interfaceTypes.first.typeArguments;
  if (typeArguments.length == 2) {
    final clientType = typeArguments[0];
    final firestoreType = typeArguments[1];
    final pattern = RegExp('@(.*)');
    final match = pattern.firstMatch(source);
    if (match != null) {
      return JsonConverterConfig(
        jsonConverterString: match.group(1)!,
        clientTypeString: clientType.getDisplayString(withNullability: true),
        firestoreTypeString:
            firestoreType.getDisplayString(withNullability: true),
      );
    }
    return null;
  }
  return null;
}
