import '../configs/code_generation_config.dart';

/// A template for a class to read documents from Firestore.
class FromJsonTemplate {
  /// Creates a [FromJsonTemplate] with the given [config].
  const FromJsonTemplate(this.config);

  /// The configuration for the document.
  final CodeGenerationConfig config;

  @override
  String toString() {
    return '''
${config.className} _\$${config.className}FromJson(Map<String, dynamic> json) => ${config.className}(
  ${_parseFields()}
);
''';
  }

  String _parseFields() {
    final stringBuffer = StringBuffer();
    for (final entry in config.fields.entries) {
      stringBuffer
          .writeln("${entry.key}: json['${entry.value}'] as ${entry.value},");
    }
    return stringBuffer.toString();
  }
}
