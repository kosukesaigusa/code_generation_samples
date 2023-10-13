import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:flutterfire_gen_annotation/flutterfire_gen_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'src/flutterfire_gen.dart';
import 'src/templates/generated_code_template.dart';

/// Returns a [_FlutterfireGenBuilder] instance.
Builder flutterfireGenBuilder(BuilderOptions _) => _FlutterfireGenBuilder();

/// A [Builder] class of [FlutterFireGen] code generator.
class _FlutterfireGenBuilder implements Builder {
  @override
  Map<String, List<String>> get buildExtensions => const {
        '.dart': ['.flutterfire_gen.dart'],
      };

  @override
  Future<void> build(BuildStep buildStep) async {
    final inputAssetId = buildStep.inputId;
    final outputAssetId = inputAssetId.changeExtension('.flutterfire_gen.dart');
    final library = await buildStep.inputLibrary;

    if (!_firestoreDocumentAnnotationFound(library)) {
      return;
    }

    final generatedCode =
        await FlutterFireGen().generate(LibraryReader(library), buildStep);

    await buildStep.writeAsString(
      outputAssetId,
      GeneratedCodeTemplate(
        generatedCode: generatedCode,
        inputAssetId: inputAssetId,
      ).toString(),
    );
  }

  /// Returns whether [FirestoreDocument] annotation is found in the give
  /// [LibraryElement].
  bool _firestoreDocumentAnnotationFound(LibraryElement library) {
    const matcher = TypeChecker.fromRuntime(FirestoreDocument);
    final compilationUnit = library.definingCompilationUnit;
    return compilationUnit.classes.any(
      (cls) => cls.metadata.any((meta) {
        final obj = meta.computeConstantValue();
        if (obj == null) {
          return false;
        }
        return matcher.isExactlyType(obj.type!);
      }),
    );
  }
}
