import '../../configs/firestore_document_config.dart';
import '../../firestore_document_visitor.dart';
import '../constructor_template.dart';
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
    final fields = <String, String>{
      ...visitor.fields,
      config.documentIdFieldName: 'String',
      if (config.includePathField) config.documentPathFieldName: 'String',
      if (config.includeDocumentReferenceField)
        config.documentReferenceFieldName:
            'DocumentReference<${config.readClassName}>',
    };

    final constructor = ConstructorTemplate(
      className: config.readClassName,
      requiredFieldNames: fields.entries.map((entry) => entry.key).toList(),
      optionalFieldNames: [],
    );

    return '''
class ${config.readClassName} {
  $constructor

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
