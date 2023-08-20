// ignore_for_file: lines_longer_than_80_chars

import 'package:meta/meta.dart';

import '../../config.dart';
import '../../utils/type_converter.dart';

///
class ToJsonTemplate {
  ///
  const ToJsonTemplate({
    required this.config,
    required this.fields,
    required this.defaultValueStrings,
    required this.fieldValueAllowedFields,
    required this.alwaysUseFieldValueServerTimestampWhenCreatingFields,
    required this.jsonConverterConfigs,
  });

  ///
  final FirestoreDocumentConfig config;

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
toJson(): Record<string, unknown> {
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
      final isAlwaysUseFieldValueServerTimestampWhenCreating =
          alwaysUseFieldValueServerTimestampWhenCreatingFields
              .contains(entry.key);
      final jsonConverterConfig = jsonConverterConfigs[fieldNameString];
      return toJsonEachField(
        fieldNameString: fieldNameString,
        typeNameString: typeNameString,
        defaultValueString: defaultValueString,
        isFieldValueAllowed: isFieldValueAllowed,
        isAlwaysUseFieldValueServerTimestampWhenCreating:
            isAlwaysUseFieldValueServerTimestampWhenCreating,
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
      final toJsonString = '${config.createClassName}.'
          '${jsonConverterConfig.toJsonFunctionName}(this.$fieldNameString)';

      if (hasDefaultValue && isNullableType) {
        // TODO: ここは未対応。
        if (isFieldValueAllowed) {
          throw UnimplementedError();
        } else {
          return '$fieldNameString: this.$fieldNameString === undefined '
              '? ${toTypeScriptDefaultValueString(
            dartTypeNameString: jsonConverterConfig.firestoreTypeString,
            dartDefaultValueString: defaultValueString!,
          )} '
              ': $toJsonString,';
        }
      }
      if (isFieldValueAllowed) {
        return '''
tokenAndDevices:
  this.$fieldNameString instanceof FieldValue
      ? this.$fieldNameString
      : $toJsonString,
''';
      } else {
        return 'tokenAndDevices: $toJsonString,';
      }
    }

    // NOTE: FieldValue 対応はない
    // TODO: ↑ 本当はある可能性があるかも？ FieldValue.serverTimestamp() など？
    if (isNullableType && hasDefaultValue) {
      return '$fieldNameString: this.$fieldNameString ?? $defaultValueString,';
    } else {
      return '$fieldNameString: this.$fieldNameString,';
    }
  }
}
