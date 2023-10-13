import '../../config.dart';
import '../../firestore_document_visitor.dart';
import 'copy_with_template.dart';
import 'from_document_snapshot_template.dart';
import 'from_json_template.dart';

///
class ReadClassTemplate {
  ///
  const ReadClassTemplate({
    required this.config,
    required this.visitor,
  });

  ///
  final FirestoreDocumentConfig config;

  ///
  final FirestoreDocumentVisitor visitor;

  @override
  String toString() {
    final fields = visitor.fields;
    return '''
class ${config.readClassName} {
  const ${config.readClassName}({
    required this.${config.documentIdFieldName},
    required this.${config.documentPathFieldName},
    ${config.includeDocumentReferenceField ? 'required this.${config.documentReferenceFieldName},' : ''}
    ${fields.entries.map((entry) => 'required this.${entry.key},').join('\n')}
  });

  final String ${config.documentIdFieldName};

  final String ${config.documentPathFieldName};

  ${config.includeDocumentReferenceField ? 'final DocumentReference<${config.readClassName}> ${config.documentReferenceFieldName};' : ''}

  ${fields.entries.map((entry) => 'final ${entry.value} ${entry.key};').join('\n\n')}

  ${FromJsonTemplate(
      config: config,
      fields: fields,
      defaultValueStrings: visitor.readDefaultValueStrings,
      jsonConverterConfigs: visitor.jsonConverterConfigs,
      jsonPostProcessorConfigs: visitor.jsonPostProcessorConfigs,
    )}

  ${FromDocumentSnapshotTemplate(config: config)}

  ${config.generateCopyWith ? '${CopyWithTemplate(config: config, fields: fields)}' : ''}
}
''';
  }
}
