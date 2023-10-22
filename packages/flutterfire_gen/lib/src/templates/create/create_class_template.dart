import '../../configs/code_generation_config.dart';
import 'to_json_template.dart';

/// A template for a class to create documents in Firestore.
class CreateClassTemplate {
  /// Creates a [CreateClassTemplate].
  const CreateClassTemplate(this.config);

  /// Configurations for code generation.
  final CodeGenerationConfig config;

  @override
  String toString() {
    return '''
class ${config.createClassName} {
  ${_parseConstructor()}

  ${_parseFields()}

  ${ToJsonTemplate(
      fields: config.selfDefinedFields,
      defaultValueStrings: config.createDefaultValueStrings,
      fieldValueAllowedFields: config.fieldValueAllowedFields,
      alwaysUseFieldValueServerTimestampWhenCreatingFields:
          config.alwaysUseFieldValueServerTimestampWhenCreatingFields,
      jsonConverterConfigs: config.jsonConverterConfigs,
      jsonPostProcessorConfigs: config.jsonPostProcessorConfigs,
    )}
}
''';
  }

  String _parseConstructor() {
    final fields = _parseConstructorFields();
    if (fields.isEmpty) {
      return 'const ${config.createClassName}();';
    }
    return '''
const ${config.createClassName}({
  ${_parseConstructorFields()}
});
''';
  }

  // TODO: 可読性、テスト対象を定める意味でリファクタできそう
  String _parseConstructorFields() {
    return effectiveEntries.map((entry) {
      final fieldNameString = entry.key;
      final typeNameString = entry.value;

      final defaultValueStrings = config.createDefaultValueStrings;
      final isFieldValueAllowed =
          config.fieldValueAllowedFields.contains(entry.key);

      final defaultValueString = defaultValueStrings[fieldNameString];
      return _constructorEachField(
        fieldNameString: fieldNameString,
        typeNameString: typeNameString,
        defaultValueString: defaultValueString,
        isFieldValueAllowed: isFieldValueAllowed,
      );
    }).join('\n');
  }

  String _constructorEachField({
    required String fieldNameString,
    required String typeNameString,
    required String? defaultValueString,
    required bool isFieldValueAllowed,
  }) {
    final hasDefaultValue = (defaultValueString ?? '').isNotEmpty;
    final isNullable = typeNameString.endsWith('?');
    if (hasDefaultValue || isNullable) {
      if (hasDefaultValue) {
        if (isFieldValueAllowed) {
          return 'this.$fieldNameString = '
              'const ActualValue($defaultValueString),';
        } else {
          return 'this.$fieldNameString = $defaultValueString,';
        }
      } else {
        return 'this.$fieldNameString,';
      }
    } else {
      return 'required this.$fieldNameString,';
    }
  }

  String _parseFields() {
    return effectiveEntries.map((entry) {
      final fieldNameString = entry.key;
      final typeNameString = entry.value;
      final nullableTypeMatch = RegExp(r'(\w+)\?').firstMatch(typeNameString);
      final isFieldValueAllowed =
          config.fieldValueAllowedFields.contains(entry.key);

      if (isFieldValueAllowed) {
        if (nullableTypeMatch != null) {
          final type = nullableTypeMatch.group(1)!;
          return 'final FirestoreData<$type>? $fieldNameString;';
        } else {
          return 'final FirestoreData<$typeNameString> $fieldNameString;';
        }
      } else {
        return 'final $typeNameString $fieldNameString;';
      }
    }).join('\n');
  }

  ///
  Iterable<MapEntry<String, String>> get effectiveEntries =>
      config.selfDefinedFields.entries.where(
        (entry) => !config.alwaysUseFieldValueServerTimestampWhenCreatingFields
            .contains(entry.key),
      );
}
