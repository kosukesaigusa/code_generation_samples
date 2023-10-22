// ignore_for_file: lines_longer_than_80_chars

import 'package:meta/meta.dart';

import '../../configs/json_converter_config.dart';
import '../../configs/json_post_processor_config.dart';

/// A template for `toJson` method when creating documents in Firestore.
class ToJsonTemplate {
  /// Creates a [ToJsonTemplate].
  const ToJsonTemplate({
    required this.fields,
    required this.defaultValueStrings,
    required this.fieldValueAllowedFields,
    required this.alwaysUseFieldValueServerTimestampWhenCreatingFields,
    required this.jsonConverterConfigs,
    required this.jsonPostProcessorConfigs,
  });

  /// The fields for the document.
  final Map<String, String> fields;

  /// The default value strings for the document.
  final Map<String, String> defaultValueStrings;

  /// The fields that are allowed to be `FieldValue`.
  final Set<String> fieldValueAllowedFields;

  /// The fields that are always `FieldValue.serverTimestamp()`.
  final Set<String> alwaysUseFieldValueServerTimestampWhenCreatingFields;

  /// The JSON converter configs for the document.
  final Map<String, JsonConverterConfig> jsonConverterConfigs;

  /// The JSON post processor configs for the document.
  final Map<String, JsonPostProcessorConfig> jsonPostProcessorConfigs;

  @override
  String toString() {
    return '''
Map<String, dynamic> toJson() {
  final json = <String, dynamic>{
    ${_parseFields()}
  };
  final jsonPostProcessors = <({String key, dynamic value})>[
    ${_parseJsonPostProcessors()}
  ];
  return {
    ...json,
    ...Map.fromEntries(jsonPostProcessors
        .map((record) => MapEntry(record.key, record.value))),
  };
}
''';
  }

  ///
  String _parseJsonPostProcessors() {
    final buffer = StringBuffer();
    for (final entry in fields.entries) {
      final fieldNameString = entry.key;
      final jsonPostProcessorConfig = jsonPostProcessorConfigs[fieldNameString];
      if (jsonPostProcessorConfig == null) {
        continue;
      }
      buffer.writeln(
        '${jsonPostProcessorConfig.jsonPostProcessorString}.toJson(json),',
      );
    }
    return buffer.toString();
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
