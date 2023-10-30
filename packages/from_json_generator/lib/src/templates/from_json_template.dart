import '../configs/code_generation_config.dart';
import '../parsers/from_json_field_parser.dart';

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
    for (final fieldConfig in config.fieldConfigs) {
      final result = FromJsonFieldParser(
        name: fieldConfig.name,
        dartType: fieldConfig.dartType,
        defaultValueString: fieldConfig.defaultValueString,
        jsonConverterConfig: fieldConfig.jsonConverterConfig,
      );
      stringBuffer.writeln(result);
    }
    return stringBuffer.toString();
  }
}
