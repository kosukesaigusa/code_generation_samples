import '../../configs/code_generation_config.dart';
import '../../utils/string.dart';
import 'to_json_template.dart';

/// Returns Create class template.
class UpdateClassTemplate {
  /// Creates a [UpdateClassTemplate].
  const UpdateClassTemplate(this.config);

  /// Configurations for code generation.
  final CodeGenerationConfig config;

  @override
  String toString() {
    return '''
class ${config.updateClassName} {
  ${_parseConstructor()}

  ${_parseFields()}

  ${ToJsonTemplate(
      fields: config.selfDefinedFields,
      defaultValueStrings: config.updateDefaultValueStrings,
      fieldValueAllowedFields: config.fieldValueAllowedFields,
      alwaysUseFieldValueServerTimestampWhenUpdatingFields:
          config.alwaysUseFieldValueServerTimestampWhenUpdatingFields,
      jsonConverterConfigs: config.jsonConverterConfigs,
      jsonPostProcessorConfigs: config.jsonPostProcessorConfigs,
    )}
}
''';
  }

  String _parseConstructor() {
    final fields = _parseConstructorFields();
    if (fields.isEmpty) {
      return 'const ${config.updateClassName}();';
    } else {
      return '''
const ${config.updateClassName}({
  ${_parseConstructorFields()}
  });
''';
    }
  }

  // TODO: 可読性、テスト対象を定める意味でリファクタできそう
  String _parseConstructorFields() {
    return effectiveEntries.map((entry) {
      final fieldNameString = entry.key;
      final typeNameString = entry.value;

      final defaultValueStrings = config.updateDefaultValueStrings;
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
    if (hasDefaultValue) {
      if (isFieldValueAllowed) {
        return 'this.$fieldNameString = '
            'const ActualValue($defaultValueString),';
      }
      return 'this.$fieldNameString = $defaultValueString,';
    }
    return 'this.$fieldNameString,';
  }

  String _parseFields() {
    return effectiveEntries.map((entry) {
      final fieldNameString = entry.key;
      final typeNameString = entry.value;
      final isFieldValueAllowed =
          config.fieldValueAllowedFields.contains(entry.key);

      if (isFieldValueAllowed) {
        // TODO: typeNameString が nullable になる可能性はある？
        return 'final FirestoreData<$typeNameString>? $fieldNameString;';
      } else {
        return 'final ${typeNameString.ensureNullable()} $fieldNameString;';
      }
    }).join('\n');
  }

  ///
  Iterable<MapEntry<String, String>> get effectiveEntries =>
      config.selfDefinedFields.entries.where(
        (entry) => !config.alwaysUseFieldValueServerTimestampWhenUpdatingFields
            .contains(
          entry.key,
        ),
      );
}
