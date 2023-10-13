import '../../configs/firestore_document_config.dart';
import '../../firestore_document_visitor.dart';
import '../constructor_template.dart';
import '../field_template.dart';
import 'copy_with_template.dart';
import 'from_document_snapshot_template.dart';
import 'from_json_template.dart';

/// A template for a class to read documents from Firestore.
class ReadClassTemplate {
  /// Creates a [ReadClassTemplate] with the given [config] and [visitor].
  const ReadClassTemplate({
    required this.config,
    required this.visitor,
  });

  /// The configuration for the document.
  final FirestoreDocumentConfig config;

  /// The visitor for the document.
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

    final fieldDefinitions = FieldDefinitionsTemplate(fields: fields);

    final fromJson = FromJsonTemplate(
      config: config,
      fields: fields,
      defaultValueStrings: visitor.readDefaultValueStrings,
      jsonConverterConfigs: visitor.jsonConverterConfigs,
      jsonPostProcessorConfigs: visitor.jsonPostProcessorConfigs,
    );

    final fromDocumentSnapshot = FromDocumentSnapshotTemplate(config: config);

    final copyWith = CopyWithTemplate(config: config, fields: fields);

    return '''
class ${config.readClassName} {
  $constructor

  $fieldDefinitions

  $fromJson

  $fromDocumentSnapshot

  $copyWith
}
''';
  }
}
