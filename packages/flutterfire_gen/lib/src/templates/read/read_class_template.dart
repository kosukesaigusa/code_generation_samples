import '../../configs/code_generation_config.dart';
import '../constructor_template.dart';
import '../field_template.dart';
import 'copy_with_template.dart';
import 'from_document_snapshot_template.dart';
import 'from_json_template.dart';

/// A template for a class to read documents from Firestore.
class ReadClassTemplate {
  /// Creates a [ReadClassTemplate] with the given [config].
  const ReadClassTemplate(this.config);

  /// The configuration for the document.
  final CodeGenerationConfig config;

  @override
  String toString() {
    final constructor = ConstructorTemplate(
      className: config.readClassName,
      requiredFieldNames:
          config.allFields.entries.map((entry) => entry.key).toList(),
      optionalFieldNames: [],
    );

    final fieldDefinitions = FieldDefinitionsTemplate(fields: config.allFields);

    final fromJson = FromJsonTemplate(
      className: config.readClassName,
      fields: config.allFields,
      defaultValueStrings: config.readDefaultValueStrings,
      jsonConverterConfigs: config.jsonConverterConfigs,
      jsonPostProcessorConfigs: config.jsonPostProcessorConfigs,
    );

    final fromDocumentSnapshot = FromDocumentSnapshotTemplate(config: config);

    final copyWith = CopyWithTemplate(
      className: config.readClassName,
      fields: config.allFields,
    );

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
