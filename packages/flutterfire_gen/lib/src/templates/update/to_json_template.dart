import 'package:meta/meta.dart';

import '../../configs/json_converter_config.dart';
import '../../configs/json_post_processor_config.dart';

/// A template for `toJson` method when updating documents in Firestore.
class ToJsonTemplate {
  /// Creates a [ToJsonTemplate].
  const ToJsonTemplate({
    required this.fields,
    required this.defaultValueStrings,
    required this.fieldValueAllowedFields,
    required this.alwaysUseFieldValueServerTimestampWhenUpdatingFields,
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
  final Set<String> alwaysUseFieldValueServerTimestampWhenUpdatingFields;

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

  String _parseJsonPostProcessors() {
    final buffer = StringBuffer();
    for (final entry in fields.entries) {
      final fieldNameString = entry.key;
      final jsonPostProcessorConfig = jsonPostProcessorConfigs[fieldNameString];
      if (jsonPostProcessorConfig == null) {
        continue;
      }
      buffer.writeln(
        "if (json.containsKey('$fieldNameString')) "
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
      final isAlwaysUseFieldValueServerTimestampWhenUpdating =
          alwaysUseFieldValueServerTimestampWhenUpdatingFields
              .contains(entry.key);
      final jsonConverterConfig = jsonConverterConfigs[fieldNameString];
      return toJsonEachField(
        fieldNameString: fieldNameString,
        typeNameString: typeNameString,
        defaultValueString: defaultValueString,
        isFieldValueAllowed: isFieldValueAllowed,
        isAlwaysUseFieldValueServerTimestampWhenUpdating:
            isAlwaysUseFieldValueServerTimestampWhenUpdating,
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
    bool isAlwaysUseFieldValueServerTimestampWhenUpdating = false,
    JsonConverterConfig? jsonConverterConfig,
  }) {
    final hasDefaultValue = (defaultValueString ?? '').isNotEmpty;
    if (isAlwaysUseFieldValueServerTimestampWhenUpdating) {
      return "'$fieldNameString': FieldValue.serverTimestamp(),";
    }
    if (jsonConverterConfig != null) {
      if (hasDefaultValue) {
        if (isFieldValueAllowed) {
          return "'$fieldNameString': $fieldNameString == null "
              '? $defaultValueString '
              ': ${jsonConverterConfig.jsonConverterString}'
              '.toJson($fieldNameString!.actualValue),';
        } else {
          return "'$fieldNameString': $fieldNameString == null "
              '? $defaultValueString '
              ': ${jsonConverterConfig.jsonConverterString}'
              '.toJson($fieldNameString!),';
        }
      }
      if (isFieldValueAllowed) {
        return "if ($fieldNameString != null) '$fieldNameString': "
            '${jsonConverterConfig.jsonConverterString}'
            '.toJson($fieldNameString!.actualValue),';
      } else {
        return "if ($fieldNameString != null) '$fieldNameString': "
            '${jsonConverterConfig.jsonConverterString}'
            '.toJson($fieldNameString!),';
      }
    }
    if (isFieldValueAllowed) {
      if (hasDefaultValue) {
        return "'$fieldNameString': "
            '$fieldNameString?.value ?? $defaultValueString,';
      }
      return 'if ($fieldNameString != null) '
          "'$fieldNameString': $fieldNameString!.value,";
    }
    if (hasDefaultValue) {
      return "'$fieldNameString': $fieldNameString ?? $defaultValueString,";
    }
    return 'if ($fieldNameString != null) '
        "'$fieldNameString': $fieldNameString,";
  }
}
