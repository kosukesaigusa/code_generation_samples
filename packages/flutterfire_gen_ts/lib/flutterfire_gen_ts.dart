import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:flutterfire_gen_annotation/flutterfire_gen_annotation.dart';
import 'package:flutterfire_gen_ts_annotation/flutterfire_gen_ts_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'src/generator_for_firestore_document.dart';
import 'src/generator_for_translate_to_type_script.dart';

/// Returns a [_FlutterfireGenBuilder] instance.
Builder flutterfireGenBuilder(BuilderOptions _) => _FlutterfireGenBuilder();

/// A [Builder] class of [GeneratorForFirestoreDocument] code generator.
class _FlutterfireGenBuilder implements Builder {
  @override
  Map<String, List<String>> get buildExtensions => const {
        '.dart': ['.flutterfireGen.ts'],
      };

  @override
  Future<void> build(BuildStep buildStep) async {
    final assetId = buildStep.inputId;
    final outputId = assetId.changeExtension('.flutterfireGen.ts');
    final flutterfireGenLibrary = await buildStep.inputLibrary;
    if (!_firestoreDocumentAnnotationFound(flutterfireGenLibrary)) {
      print('🔴 No @FirestoreDocument annotation is found.');
      return;
    }

    final firestoreGeneratedCode = await GeneratorForFirestoreDocument()
        .generate(LibraryReader(flutterfireGenLibrary), buildStep);

    final translateToTypeScriptCodeBuffer = StringBuffer();
    if (_translateToTypeScriptAnnotationFound(flutterfireGenLibrary)) {
      final translateToTypeScriptCode =
          await GeneratorForTranslateToTypeScript()
              .generate(LibraryReader(flutterfireGenLibrary), buildStep);
      translateToTypeScriptCodeBuffer.write(translateToTypeScriptCode);
    }

    // TODO: generatedCode に含まれる文字列に応じて、import するモジュールを変更すると良さそう
    await buildStep.writeAsString(
      outputId,
      '''
import * as admin from 'firebase-admin'
import {
    DocumentReference,
    FieldValue,
    GeoPoint,
    QueryDocumentSnapshot,
    QuerySnapshot,
    WriteResult
} from 'firebase-admin/firestore'

$translateToTypeScriptCodeBuffer

$firestoreGeneratedCode
''',
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

  bool _translateToTypeScriptAnnotationFound(LibraryElement library) {
    const matcher = TypeChecker.fromRuntime(TranslateToTypeScript);
    final compilationUnit = library.definingCompilationUnit;
    return [
      ...compilationUnit.classes,
      ...compilationUnit.enums,
    ].any(
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
