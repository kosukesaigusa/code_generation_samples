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
  final Map<String, String> fields = {};

  /// Default value strings of each field when reading Cloud Firestore
  /// documents.
  final Map<String, String> readDefaultValueStrings = {};

  /// Default value strings of each field when creating Cloud Firestore
  /// documents.
  final Map<String, String> createDefaultValueStrings = {};

  /// Default value strings of each field when updating Cloud Firestore
  /// documents.
  final Map<String, String> updateDefaultValueStrings = {};

  /// A set of strings of FieldValue allowed fields.
  final Set<String> fieldValueAllowedFields = {};

  /// A set of strings of fields always use `FieldValue.serverTimestamp()` when
  /// creating.
  final Set<String> alwaysUseFieldValueServerTimestampWhenCreatingFields = {};

  /// A set of strings of fields always use `FieldValue.serverTimestamp()` when
  /// updating.
  final Set<String> alwaysUseFieldValueServerTimestampWhenUpdatingFields = {};

  /// [JsonConverter] strings of each field.
  final Map<String, JsonConverterConfig> jsonConverterConfigs = {};

  @override
  void visitConstructorElement(ConstructorElement element) {
    final returnType = element.returnType.toString();
    className = returnType;
    _parseConstructorParameters(element.parameters);
  }

  @override
  void visitFieldElement(FieldElement element) {
    fields[element.name] = element.type.toString();
    _parseAnnotations(element);
  }

  /// Parses default values of constructor parameters.
  void _parseConstructorParameters(List<ParameterElement> parameters) {
    for (final parameter in parameters) {
      if (parameter.isOptional) {
        final fieldName = parameter.name;
        final defaultValueCode = parameter.defaultValueCode;
        if (defaultValueCode != null) {
          print(
            '❗The default value $defaultValueCode for $className.$fieldName is '
            'set in the constructor of $className, but it has no meaning. '
            'Use @ReadDefault, @CreateDefault, or @UpdateDefault instead.',
          );
        }
      }
    }
  }

  /// Parses annotations and json converters.
  void _parseAnnotations(FieldElement element) {
    const defaultTypeChecker = TypeChecker.fromRuntime(Default);
    const jsonConverterTypeChecker = TypeChecker.fromRuntime(JsonConverter);
    const allowFieldValueTypeChecker = TypeChecker.fromRuntime(AllowFieldValue);
    const alwaysUseFieldValueServerTimestampWhenCreatingTypeChecker =
        TypeChecker.fromRuntime(AlwaysUseFieldValueServerTimestampWhenCreating);
    const alwaysUseFieldValueServerTimestampWhenUpdatingTypeChecker =
        TypeChecker.fromRuntime(AlwaysUseFieldValueServerTimestampWhenUpdating);

    final metadata = element.metadata;
    for (final meta in metadata) {
      final fieldName = element.name;
      final source = meta.toSource();
      final object = meta.computeConstantValue()!;
      final objectType = object.type!;
      if (defaultTypeChecker.isAssignableFromType(objectType)) {
        parseDefaultAnnotation(
          fieldName: fieldName,
          source: source,
          objectType: objectType,
        );
      }
      if (jsonConverterTypeChecker.isAssignableFromType(objectType)) {
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
      if (allowFieldValueTypeChecker.isExactlyType(objectType)) {
        fieldValueAllowedFields.add(fieldName);
      }
      if (alwaysUseFieldValueServerTimestampWhenCreatingTypeChecker
          .isExactlyType(objectType)) {
        alwaysUseFieldValueServerTimestampWhenCreatingFields.add(fieldName);
      }
      if (alwaysUseFieldValueServerTimestampWhenUpdatingTypeChecker
          .isExactlyType(objectType)) {
        alwaysUseFieldValueServerTimestampWhenUpdatingFields.add(fieldName);
      }
    }
  }

  /// Parses [Default] annotation.
  @visibleForTesting
  void parseDefaultAnnotation({
    required String fieldName,
    required String source,
    required DartType objectType,
  }) {
    final defaultTypeString =
        objectType.getDisplayString(withNullability: false);
    final res =
        source.substring('@$defaultTypeString('.length, source.length - 1);
    final needsConstModifier = !objectType.isDartCoreString &&
        !res.trimLeft().startsWith('const') &&
        (res.contains('(') || res.contains('[') || res.contains('{'));
    if (needsConstModifier) {
      if (defaultTypeString == ReadDefault.typeString) {
        readDefaultValueStrings[fieldName] = 'const $res';
      } else if (defaultTypeString == CreateDefault.typeString) {
        createDefaultValueStrings[fieldName] = 'const $res';
      } else if (defaultTypeString == UpdateDefault.typeString) {
        updateDefaultValueStrings[fieldName] = 'const $res';
      }
    } else {
      if (defaultTypeString == ReadDefault.typeString) {
        readDefaultValueStrings[fieldName] = res;
      } else if (defaultTypeString == CreateDefault.typeString) {
        createDefaultValueStrings[fieldName] = res;
      } else if (defaultTypeString == UpdateDefault.typeString) {
        updateDefaultValueStrings[fieldName] = res;
      }
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
