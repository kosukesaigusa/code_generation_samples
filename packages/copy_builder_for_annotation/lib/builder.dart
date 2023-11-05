import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:build/build.dart';

/// A [Builder] that selectively copies Dart source files into a new file with a
/// `.copy.dart` extension.
///
/// This builder scans the source files for the presence of a specific
/// annotation named 'Copy'.
/// If the annotation is found within any of the declarations in the file, the
/// entire content of the file is duplicated into a new file with the same name
/// but with an additional `.copy.dart` extension.
///
/// This is particularly useful when you want to flag certain files for special
/// processing, such as during a code generation step in a build pipeline. Only
/// files that contain the specified annotation will be processed, making it an
/// opt-in mechanism for developers.
///
/// Usage of this builder should be configured in the `build.yaml` file of the
/// Dart package.
///
/// Example usage in `build.yaml`:
///
/// ```yaml
/// targets:
///   $default:
///     builders:
///       your_package:copyBuilderForAnnotation:
///         enabled: true
/// ```
///
/// This will activate the `CopyBuilderForAnnotation` for the package and will
/// process files according to the builder's logic.
Builder copyBuilderForAnnotation(BuilderOptions _) =>
    CopyBuilderForAnnotation();

/// A simple [Builder] implementation that creates a copy of source `.dart`
/// files which are annotated with a `Copy` annotation, resulting in a
/// `.copy.dart` file.
///
/// The builder checks each `.dart` file for any top-level declarations that
/// are annotated with 'Copy'. If such an annotation is found, the entire
/// content of the source file is copied to a new file with a `.copy.dart`
/// extension.
///
/// This builder is intentionally simple and serves as an example of how to
/// implement file copying based on Dart source annotations without performing
/// any modifications to the content. It does not provide functionality for
/// transforming or filtering the content of the source file.
class CopyBuilderForAnnotation implements Builder {
  @override
  Map<String, List<String>> get buildExtensions => {
        '.dart': ['.copy.dart'],
      };

  @override
  Future<void> build(BuildStep buildStep) async {
    final inputId = buildStep.inputId;
    final content = await buildStep.readAsString(inputId);
    final outputId = inputId.changeExtension('.copy.dart');
    final parsedStringResult = parseString(content: content);
    if (_hasCopyAnnotation(parsedStringResult)) {
      await buildStep.writeAsString(outputId, content);
    }
  }

  /// Checks if the file contains any top-level declarations annotated with
  /// 'Copy'.
  ///
  /// This method parses the source file and iterates through all the top-level
  /// declarations. It looks for the presence of the 'Copy' annotation on any
  /// of these declarations. If at least one declaration is annotated with
  /// 'Copy', it returns true, indicating that the file should be copied to a
  /// `.copy.dart` file.
  ///
  /// This allows for simple selection of files for duplication based purely on
  /// the presence of an annotation, without regard to the specific type of
  /// declaration that the annotation is applied to.
  bool _hasCopyAnnotation(ParseStringResult parsedStringResult) {
    return parsedStringResult.unit.declarations.any(
      (unitMember) => unitMember.metadata
          .any((annotation) => annotation.name.name == 'Copy'),
    );
  }
}
