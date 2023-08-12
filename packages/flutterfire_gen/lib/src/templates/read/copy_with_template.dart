import '../../config.dart';
import '../../utils/string.dart';

///
class CopyWithTemplate {
  ///
  const CopyWithTemplate({
    required this.config,
    required this.fields,
  });

  ///
  final FirestoreDocumentConfig config;

  ///
  final Map<String, String> fields;

  @override
  String toString() {
    return '''
${config.readClassName} copyWith({
    String? ${config.documentIdFieldName},
    String? ${config.documentPathFieldName},
    ${config.includeDocumentReferenceField ? 'DocumentReference<${config.readClassName}>? ${config.documentReferenceFieldName},' : ''}
    ${fields.entries.map((entry) {
      final fieldNameString = entry.key;
      final typeNameString = entry.value as String;
      return '${typeNameString.ensureNullable()} $fieldNameString,';
    }).join('\n')}
  }) {
    return ${config.readClassName}(
      ${config.documentIdFieldName}: ${config.documentIdFieldName} ?? this.${config.documentIdFieldName},
      ${config.documentPathFieldName}: ${config.documentPathFieldName} ?? this.${config.documentPathFieldName},
      ${config.includeDocumentReferenceField ? '${config.documentReferenceFieldName}: ${config.documentReferenceFieldName} ?? this.${config.documentReferenceFieldName},' : ''}
      ${fields.entries.map((entry) => '${entry.key}: ${entry.key} ?? this.${entry.key},').join('\n')}
    );
  }
''';
  }
}
