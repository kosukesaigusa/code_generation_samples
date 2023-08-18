import '../../config.dart';
import '../../firestore_document_visitor.dart';
import '../../utils/string.dart';
import '../../utils/type_converter.dart';
import 'to_json_template.dart';

///
class UpdateClassTemplate {
  /// Creates a [UpdateClassTemplate].
  const UpdateClassTemplate({
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

  @override
  String toString() {
    return '''
export class ${config.updateClassName} {
  ${_parseConstructor()}

  ${_parseEffectiveFields()}

  ${ToJsonTemplate(
      fields: fields,
      defaultValueStrings: visitor.updateDefaultValueStrings,
      fieldValueAllowedFields: visitor.fieldValueAllowedFields,
      alwaysUseFieldValueServerTimestampWhenUpdatingFields:
          visitor.alwaysUseFieldValueServerTimestampWhenUpdatingFields,
      jsonConverterConfigs: visitor.jsonConverterConfigs,
    )}
}
''';
  }

  String _parseConstructor() {
    if (effectiveEntries.isEmpty) {
      return 'constructor() {}';
    }
    return '''
constructor({
    ${effectiveEntries.map((entry) => '${entry.key},').join('\n')}
  }: {
    ${effectiveEntries.map((entry) {
      return toTypeScriptFieldDefinitionString(
        dartTypeNameString: entry.value.ensureUndefinedable(),
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
    return effectiveEntries.map((entry) {
      final fieldNameString = entry.key;
      final typeNameString = entry.value;
      final isFieldValueAllowed =
          visitor.fieldValueAllowedFields.contains(entry.key);

      return 'readonly ${toTypeScriptFieldDefinitionString(
        dartTypeNameString: typeNameString.ensureUndefinedable(),
        dartFieldNameString: fieldNameString,
        isFieldValueAllowed: isFieldValueAllowed,
      )}';
    }).join('\n\n');
  }

  String _parseEffectiveEntries() {
    return effectiveEntries.map((entry) {
      final fieldNameString = entry.key;
      return 'this.$fieldNameString = $fieldNameString';
    }).join('\n');
  }

  ///
  Iterable<MapEntry<String, String>> get effectiveEntries =>
      fields.entries.where(
        (entry) => !visitor.alwaysUseFieldValueServerTimestampWhenUpdatingFields
            .contains(
          entry.key,
        ),
      );
}
