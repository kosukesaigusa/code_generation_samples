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
    required this.fields,
  });

  ///
  final FirestoreDocumentConfig config;

  ///
  final FirestoreDocumentVisitor visitor;

  ///
  final Map<String, dynamic> fields;

  @override
  String toString() {
    return '''
${config.useFakeFirebaseFirestore ? 'final fakeDb = FakeFirebaseFirestore();' : ''}

class ${config.readClassName} {
  const ${config.readClassName}._({
    required this.${config.documentIdFieldName},
    required this.${config.documentReferenceFieldName},
    ${fields.entries.map((entry) => 'required this.${entry.key},').join('\n')}
  });

  final String ${config.documentIdFieldName};
  final DocumentReference<${config.readClassName}> ${config.documentReferenceFieldName};
  ${fields.entries.map((entry) => 'final ${entry.value} ${entry.key};').join('\n')}

  ${FromJsonTemplate(
      config: config,
      fields: fields,
      defaultValueStrings: visitor.defaultValueStrings,
      jsonConverterConfigs: visitor.jsonConverterConfigs,
    )}

  ${FromDocumentSnapshotTemplate(config: config)}

  ${CopyWithTemplate(config: config, fields: fields)}
}
''';
  }
}
