import 'field_config.dart';

/// The code generation configuration.
class CodeGenerationConfig {
  /// Creates a new instance of [CodeGenerationConfig].
  CodeGenerationConfig({
    required this.className,
    required this.fieldConfigs,
    required this.convertSnakeCaseToCamelCase,
  });

  /// The class name of the generation target class.
  final String className;

  /// All fields configurations of the generation target class.
  final List<FieldConfig> fieldConfigs;

  /// Whether to convert snake case to camel case.
  final bool convertSnakeCaseToCamelCase;
}
