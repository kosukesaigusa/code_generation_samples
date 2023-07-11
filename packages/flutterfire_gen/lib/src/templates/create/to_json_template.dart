// ignore_for_file: lines_longer_than_80_chars

import 'package:meta/meta.dart';

import '../../config.dart';

///
class ToJsonTemplate {
  ///
  const ToJsonTemplate({
    required this.fields,
    required this.defaultValueStrings,
    required this.jsonConverterConfigs,
    required this.fieldValueAllowedFields,
  });

  ///
  final Map<String, dynamic> fields;

  ///
  final Map<String, String> defaultValueStrings;

  ///
  final Map<String, JsonConverterConfig> jsonConverterConfigs;

  ///
  final Set<String> fieldValueAllowedFields;

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
      final typeNameString = entry.value as String;
      final defaultValueString = defaultValueStrings[fieldNameString];
      final isFieldValueAllowed = fieldValueAllowedFields.contains(entry.key);
      final jsonConverterConfig = jsonConverterConfigs[fieldNameString];
      return toJsonEachField(
        fieldNameString: fieldNameString,
        typeNameString: typeNameString,
        defaultValueString: defaultValueString,
        jsonConverterConfig: jsonConverterConfig,
        isFieldValueAllowed: isFieldValueAllowed,
      );
    }).join('\n');
  }

  ///
  @visibleForTesting
  String toJsonEachField({
    required String fieldNameString,
    required String typeNameString,
    String? defaultValueString,
    JsonConverterConfig? jsonConverterConfig,
    bool isFieldValueAllowed = false,
  }) {
    final hasDefaultValue = (defaultValueString ?? '').isNotEmpty;
    final nullableTypeMatch = RegExp(r'(\w+)\?').firstMatch(typeNameString);
    final isNullableType = nullableTypeMatch != null;
    if (jsonConverterConfig != null) {
      if (hasDefaultValue && isNullableType) {
        return "'$fieldNameString': $fieldNameString == null "
            '? $defaultValueString '
            ': ${jsonConverterConfig.jsonConverterString}.toJson($fieldNameString!),';
      }
      return "'$fieldNameString': ${jsonConverterConfig.jsonConverterString}.toJson($fieldNameString),";
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
    }
    return "'$fieldNameString': $fieldNameString,";
  }
}
