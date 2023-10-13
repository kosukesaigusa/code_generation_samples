/// A template for a class's fields.
class FieldDefinitionsTemplate {
  /// Creates a [FieldDefinitionsTemplate] with the given [fields].
  FieldDefinitionsTemplate({required this.fields});

  /// Fields of the class.
  final Map<String, String> fields;

  @override
  String toString() {
    return fields.entries
        .map((entry) => 'final ${entry.value} ${entry.key};')
        .join('\n\n');
  }
}
