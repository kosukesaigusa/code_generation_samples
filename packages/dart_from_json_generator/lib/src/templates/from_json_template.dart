import '../configs/code_generation_config.dart';

/// A template for a class to read documents from Firestore.
class FromJsonTemplate {
  /// Creates a [FromJsonTemplate] with the given [config].
  const FromJsonTemplate(this.config);

  /// The configuration for the document.
  final CodeGenerationConfig config;

  @override
  String toString() {
    return '';
  }
}
