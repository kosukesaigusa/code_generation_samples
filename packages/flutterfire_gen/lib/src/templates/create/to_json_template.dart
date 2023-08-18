// ignore_for_file: lines_longer_than_80_chars

import 'package:meta/meta.dart';

import '../../config.dart';

///
class ToJsonTemplate {
  ///
  const ToJsonTemplate({
    required this.fields,
    required this.defaultValueStrings,
    required this.fieldValueAllowedFields,
    required this.alwaysUseFieldValueServerTimestampWhenCreatingFields,
    required this.jsonConverterConfigs,
  });

  ///
  final Map<String, String> fields;

  ///
  final Map<String, String> defaultValueStrings;

  ///
  final Set<String> fieldValueAllowedFields;

  ///
  final Set<String> alwaysUseFieldValueServerTimestampWhenCreatingFields;

  ///
  final Map<String, JsonConverterConfig> jsonConverterConfigs;

  @override
  String toString() {
    return '''
Map<String, dynamic> toJson() {
  return {
    ${_parseFields()}
  };
}
''';
  }

  String _parseFields() {
    return fields.entries.map((entry) {
      final fieldNameString = entry.key;
      final typeNameString = entry.value;
      final defaultValueString = defaultValueStrings[fieldNameString];
      final isFieldValueAllowed = fieldValueAllowedFields.contains(entry.key);
      final jsonConverterConfig = jsonConverterConfigs[fieldNameString];
      return toJsonEachField(
        fieldNameString: fieldNameString,
        typeNameString: typeNameString,
        defaultValueString: defaultValueString,
        isFieldValueAllowed: isFieldValueAllowed,
        isAlwaysUseFieldValueServerTimestampWhenCreating:
            alwaysUseFieldValueServerTimestampWhenCreatingFields
                .contains(entry.key),
        jsonConverterConfig: jsonConverterConfig,
      );
    }).join('\n');
  }

  ///
  @visibleForTesting
  String toJsonEachField({
    required String fieldNameString,
    required String typeNameString,
    String? defaultValueString,
    bool isFieldValueAllowed = false,
    bool isAlwaysUseFieldValueServerTimestampWhenCreating = false,
    JsonConverterConfig? jsonConverterConfig,
  }) {
    final hasDefaultValue = (defaultValueString ?? '').isNotEmpty;
    final nullableTypeMatch = RegExp(r'(\w+)\?').firstMatch(typeNameString);
    final isNullableType = nullableTypeMatch != null;
    if (isAlwaysUseFieldValueServerTimestampWhenCreating) {
      return "'$fieldNameString': FieldValue.serverTimestamp(),";
    }
    if (jsonConverterConfig != null) {
      if (hasDefaultValue && isNullableType) {
        if (isFieldValueAllowed) {
          return "'$fieldNameString': $fieldNameString == null "
              '? $defaultValueString '
              ': ${jsonConverterConfig.jsonConverterString}.toJson($fieldNameString!.actualValue),';
        } else {
          return "'$fieldNameString': $fieldNameString == null "
              '? $defaultValueString '
              ': ${jsonConverterConfig.jsonConverterString}.toJson($fieldNameString!),';
        }
      }
      if (isFieldValueAllowed) {
        return "'$fieldNameString': ${jsonConverterConfig.jsonConverterString}.toJson($fieldNameString.actualValue),";
      } else {
        return "'$fieldNameString': ${jsonConverterConfig.jsonConverterString}.toJson($fieldNameString),";
      }
    }
    if (isFieldValueAllowed) {
      if (isNullableType) {
        if (hasDefaultValue) {
          return "'$fieldNameString': $fieldNameString?.value ?? $defaultValueString,";
        }
        return "'$fieldNameString': $fieldNameString?.value,";
      }
      return "'$fieldNameString': $fieldNameString.value,";
    }
    if (isNullableType && hasDefaultValue) {
      return "'$fieldNameString': $fieldNameString ?? $defaultValueString,";
    } else {
      return "'$fieldNameString': $fieldNameString,";
    }
  }
}
