import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:flutterfire_gen_annotation/flutterfire_gen_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';

import 'config.dart';

/// A [SimpleElementVisitor] to visit [FirestoreDocument] annotated class.
class FirestoreDocumentVisitor extends SimpleElementVisitor<void> {
  /// A name of visited [FirestoreDocument] annotated class.
  String className = '';

  /// Fields of visited [FirestoreDocument] annotated class.
  final Map<String, dynamic> fields = {};

  /// Default value strings of each field.
  final Map<String, String> defaultValueStrings = {};

  /// [JsonConverter] strings of each field.
  final Map<String, JsonConverterConfig> jsonConverterConfigs = {};

  @override
  void visitConstructorElement(ConstructorElement element) {
    final returnType = element.returnType.toString();
    className = returnType;
    _parseParameters(element.parameters);
  }

  @override
  void visitFieldElement(FieldElement element) {
    fields[element.name] = element.type.toString();
    _parseAnnotations(element);
  }

  /// Parses default values of constructor parameters.
  void _parseParameters(List<ParameterElement> parameters) {
    for (final parameter in parameters) {
      if (parameter.isOptional) {
        final fieldName = parameter.name;
        final defaultValueCode = parameter.defaultValueCode;
        if (defaultValueCode != null) {
          defaultValueStrings[fieldName] = defaultValueCode;
        }
      }
    }
  }

  /// Parses annotations and json converters.
  void _parseAnnotations(FieldElement element) {
    const defaultTypeChecker = TypeChecker.fromRuntime(Default);
    const jsonConverterTypeChecker = TypeChecker.fromRuntime(JsonConverter);

    final metadata = element.metadata;
    for (final meta in metadata) {
      final fieldName = element.name;
      final source = meta.toSource();
      final object = meta.computeConstantValue()!;
      final objectType = object.type!;
      if (defaultTypeChecker.isExactlyType(objectType)) {
        parseDefaultAnnotation(
          fieldName: fieldName,
          source: source,
          objectType: objectType,
        );
      } else if (jsonConverterTypeChecker.isAssignableFromType(objectType)) {
        final interfaceTypes = (objectType.element! as ClassElement)
            .allSupertypes
            .where((t) => jsonConverterTypeChecker.isExactlyType(t));
        final typeArguments = interfaceTypes.first.typeArguments;
        if (typeArguments.length == 2) {
          final clientType = typeArguments[0];
          final firestoreType = typeArguments[1];
          parseJsonConverterAnnotation(
            fieldName: fieldName,
            source: source,
            clientType: clientType,
            firestoreType: firestoreType,
          );
        }
      }
    }
  }

  /// Parses [Default] annotation.
  @visibleForTesting
  void parseDefaultAnnotation({
    required String fieldName,
    required String source,
    // TODO: objectType は受け取らなくても良い方法があれば試してみる
    required DartType objectType,
  }) {
    final res = source.substring('@Default('.length, source.length - 1);
    final needsConstModifier = !objectType.isDartCoreString &&
        !res.trimLeft().startsWith('const') &&
        (res.contains('(') || res.contains('[') || res.contains('{'));
    if (needsConstModifier) {
      defaultValueStrings[fieldName] = 'const $res';
    } else {
      defaultValueStrings[fieldName] = res;
    }
  }

  /// Parses [JsonConverter] annotation.
  @visibleForTesting
  void parseJsonConverterAnnotation({
    required String fieldName,
    required String source,
    required DartType clientType,
    required DartType firestoreType,
  }) {
    final pattern = RegExp('@(.*)');
    final match = pattern.firstMatch(source);
    if (match != null) {
      jsonConverterConfigs[fieldName] = JsonConverterConfig(
        jsonConverterString: match.group(1)!,
        clientTypeString: clientType.getDisplayString(withNullability: true),
        firestoreTypeString:
            firestoreType.getDisplayString(withNullability: true),
      );
    }
  }
}
