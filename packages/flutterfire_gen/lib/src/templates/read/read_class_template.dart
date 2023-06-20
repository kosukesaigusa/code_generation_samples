import '../../firestore_document_visitor.dart';
import '../../flutterfire_gen.dart';
import 'copy_with_template.dart';
import 'from_document_snapshot_template.dart';
import 'from_json_template.dart';
import 'to_json_template.dart';

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
  const ${config.readClassName}({
    ${fields.entries.map((entry) => 'required this.${entry.key},').join('\n')}
  });

  ${fields.entries.map((entry) => 'final ${entry.value} ${entry.key};').join('\n')}

  ${ToJsonTemplate(fields: fields)}

  ${FromJsonTemplate(
      readClassName: config.readClassName,
      fields: fields,
      defaultValueStrings: visitor.defaultValueStrings,
      jsonConverterConfigs: visitor.jsonConverterConfigs,
    )}

  ${FromDocumentSnapshotTemplate(
      readClassName: config.readClassName,
      documentName: config.documentName,
    )}

  ${CopyWithTemplate(readClassName: config.readClassName, fields: fields)}
}
''';
  }
}
