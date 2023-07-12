import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:dart_style/dart_style.dart';
import 'package:flutterfire_gen_annotation/flutterfire_gen_annotation.dart';
import 'package:path/path.dart';
import 'package:source_gen/source_gen.dart';

import 'src/flutterfire_gen.dart';

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
    final assetId = buildStep.inputId;
    final outputId = assetId.changeExtension('.flutterfire_gen.dart');
    final library = await buildStep.inputLibrary;
    if (!_firestoreDocumentAnnotationFound(library)) {
      return;
    }
    final generatedCode =
        await FlutterFireGen().generate(LibraryReader(library), buildStep);

    await buildStep.writeAsString(
      outputId,
      // TODO: 整形はこれで良いのか確かめる
      DartFormatter().format('''
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '${basename(buildStep.inputId.path)}';

$generatedCode
'''),
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