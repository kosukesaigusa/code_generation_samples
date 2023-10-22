import '../../utils/string.dart';

/// A template for a copyWith method for a document class.
class CopyWithTemplate {
  /// Creates a [CopyWithTemplate] with the given [className] and [fields].
  const CopyWithTemplate({
    required this.className,
    required this.fields,
  });

  /// The name of the document class.
  final String className;

  /// The fields of the document.
  final Map<String, String> fields;

  /// Returns the copyWith method for the document class.
  /// return empty string if `config.generateCopyWith` is false.
  @override
  String toString() {
    return '''
$className copyWith({
    ${fields.entries.map((entry) {
      final fieldNameString = entry.key;
      final typeNameString = entry.value;
      return '${typeNameString.ensureNullable()} $fieldNameString,';
    }).join('\n')}
  }) {
    return $className(
      ${fields.entries.map((entry) => '${entry.key}: ${entry.key} ?? this.${entry.key},').join('\n')}
    );
  }
''';
  }
}
