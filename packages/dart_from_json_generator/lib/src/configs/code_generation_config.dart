import 'json_converter_config.dart';

/// The code generation configuration.
class CodeGenerationConfig {
  /// Creates a new instance of [CodeGenerationConfig].
  CodeGenerationConfig({
    required this.className,
    required this.fields,
    required this.jsonConverterConfigs,
    required this.convertSnakeCaseToCamelCase,
  });

  /// The class name of the FirestoreDocument annotated class.
  final String className;

  /// All fields FirestoreDocument annotated class has.
  final Map<String, String> fields;

  /// JsonConverter configurations of each field.
  final Map<String, JsonConverterConfig> jsonConverterConfigs;

  /// Whether to convert snake case to camel case.
  final bool convertSnakeCaseToCamelCase;
}
