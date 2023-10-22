import '../../configs/code_generation_config.dart';

/// Returns Delete class template.
class DeleteClassTemplate {
  /// Creates a [DeleteClassTemplate].
  const DeleteClassTemplate(this.config);

  /// Configurations for code generation.
  final CodeGenerationConfig config;

  @override
  String toString() {
    return 'class ${config.deleteClassName} {}';
  }
}
