// ignore_for_file: lines_longer_than_80_chars

import '../../config.dart';
import '../../firestore_document_visitor.dart';
import '../../utils/type_converter.dart';
import 'to_json_template.dart';

///
class CreateClassTemplate {
  ///
  const CreateClassTemplate({
    required this.config,
    required this.visitor,
    required this.fields,
  });

  ///
  final FirestoreDocumentConfig config;

  ///
  final FirestoreDocumentVisitor visitor;

  ///
  final Map<String, String> fields;

  // TODO: デフォルト値, undefined 許容の扱いをどうするか考える
  @override
  String toString() {
    return '''
export class ${config.createClassName} {
  ${_parseConstructor()}

  ${_parseEffectiveFields()}

  ${_jsonConverterConfigs.map((e) {
      return '''
private static ${e.toJsonFunction}
''';
    }).join('\n')}

  ${ToJsonTemplate(
      config: config,
      fields: fields,
      defaultValueStrings: visitor.createDefaultValueStrings,
      fieldValueAllowedFields: visitor.fieldValueAllowedFields,
      alwaysUseFieldValueServerTimestampWhenCreatingFields:
          visitor.alwaysUseFieldValueServerTimestampWhenCreatingFields,
      jsonConverterConfigs: visitor.jsonConverterConfigs,
    )}
}
''';
  }

  String _parseConstructor() {
    if (_effectiveEntries.isEmpty) {
      return 'constructor() {}';
    }
    return '''
constructor({
    ${_effectiveEntries.map((entry) => '${entry.key},').join('\n')}
  }: {
    ${_effectiveEntries.map((entry) {
      return toTypeScriptFieldDefinitionString(
        dartTypeNameString: entry.value,
        dartFieldNameString: entry.key,
        isFieldValueAllowed:
            visitor.fieldValueAllowedFields.contains(entry.key),
      );
    }).join('\n')}
  }) {
    ${_parseEffectiveEntries()}
  }
''';
  }

  String _parseEffectiveFields() {
    return _effectiveEntries.map((entry) {
      final fieldNameString = entry.key;
      final typeNameString = entry.value;
      final isFieldValueAllowed =
          visitor.fieldValueAllowedFields.contains(entry.key);

      return 'readonly ${toTypeScriptFieldDefinitionString(
        dartTypeNameString: typeNameString,
        dartFieldNameString: fieldNameString,
        isFieldValueAllowed: isFieldValueAllowed,
      )}';
    }).join('\n\n');
  }

  String _parseEffectiveEntries() {
    return _effectiveEntries.map((entry) {
      final fieldNameString = entry.key;
      return 'this.$fieldNameString = $fieldNameString';
    }).join('\n');
  }

  ///
  Iterable<MapEntry<String, String>> get _effectiveEntries =>
      fields.entries.where(
        (entry) => !visitor.alwaysUseFieldValueServerTimestampWhenCreatingFields
            .contains(
          entry.key,
        ),
      );

  List<JsonConverterConfig> get _jsonConverterConfigs => fields.entries
      .map((entry) => visitor.jsonConverterConfigs[entry.key])
      .where((jsonConverterConfig) => jsonConverterConfig != null)
      .whereType<JsonConverterConfig>()
      .toList();
}
