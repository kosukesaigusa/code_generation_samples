import '../../config.dart';
import '../../firestore_document_visitor.dart';
import '../../utils/type_converter.dart';
import 'from_document_snapshot_template.dart';
import 'from_json_template.dart';

///
class ReadClassTemplate {
  ///
  const ReadClassTemplate({
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

  // TODO: DocumentReference の生成をどうするか考える
  // TODO: Dart の型と TypeScript の型の対応が必要
  // TODO: TS 用のアノテーションがたぶん必要

  @override
  String toString() {
    return '''
export class ${config.readClassName} {
  constructor ({
    ${config.documentIdFieldName},
    ${config.documentPathFieldName},
    ${fields.entries.map((entry) => '${entry.key},').join('\n')}
  }: {
    ${config.documentIdFieldName}: string
    ${config.documentPathFieldName}: string
    ${fields.entries.map((entry) {
      return toTypeScriptFieldDefinitionString(
        dartTypeNameString: entry.value,
        dartFieldNameString: entry.key,
      );
    }).join('\n')}
  }) {
    this.${config.documentIdFieldName} = ${config.documentIdFieldName}
    this.${config.documentPathFieldName} = ${config.documentPathFieldName}
    ${fields.entries.map((entry) => 'this.${entry.key} = ${entry.key}').join('\n')}
  }

  readonly ${config.documentIdFieldName}: string

  readonly ${config.documentPathFieldName}: string

  ${fields.entries.map((entry) {
      return 'readonly ${toTypeScriptFieldDefinitionString(
        dartTypeNameString: entry.value,
        dartFieldNameString: entry.key,
      )}';
    }).join('\n\n')}

  ${FromJsonTemplate(
      config: config,
      fields: fields,
      defaultValueStrings: visitor.readDefaultValueStrings,
      jsonConverterConfigs: visitor.jsonConverterConfigs,
    )}

  ${FromDocumentSnapshotTemplate(config: config)}
}
''';
  }
}
