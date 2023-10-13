import '../../configs/firestore_document_config.dart';
import '../../utils/string.dart';

/// A template for a copyWith method for a document class.
class CopyWithTemplate {
  /// Creates a [CopyWithTemplate] with the given [config] and [fields].
  const CopyWithTemplate({
    required this.config,
    required this.fields,
  });

  /// The configuration for the document.
  final FirestoreDocumentConfig config;

  /// The fields of the document.
  final Map<String, String> fields;

  /// Returns the copyWith method for the document class.
  /// return empty string if `config.generateCopyWith` is false.
  @override
  String toString() {
    if (!config.generateCopyWith) {
      return '';
    }
    return '''
${config.readClassName} copyWith({
    ${fields.entries.map((entry) {
      final fieldNameString = entry.key;
      final typeNameString = entry.value;
      return '${typeNameString.ensureNullable()} $fieldNameString,';
    }).join('\n')}
  }) {
    return ${config.readClassName}(
      ${fields.entries.map((entry) => '${entry.key}: ${entry.key} ?? this.${entry.key},').join('\n')}
    );
  }
''';
  }
}
