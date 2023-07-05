// ignore_for_file: implementation_imports, depend_on_referenced_packages

import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:flutterfire_gen_annotation/flutterfire_gen_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'config.dart';
import 'firestore_document_visitor.dart';
import 'templates/query.dart';
import 'templates/read/read_class_template.dart';
import 'templates/refs_template.dart';

/// A generator for [FirestoreDocument] annotation.
class FlutterFireGen extends GeneratorForAnnotation<FirestoreDocument> {
  /// A [FirestoreDocumentVisitor].
  final visitor = FirestoreDocumentVisitor();

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    element.visitChildren(visitor);

    final baseClassName = visitor.className;
    final fields = visitor.fields;
    final config = _parseFirestoreDocumentAnnotation(
      baseClassName: baseClassName,
      element: element,
    );

    final buffer = StringBuffer()
      ..writeln(
        ReadClassTemplate(config: config, visitor: visitor, fields: fields),
      )
      ..writeln(RefsTemplate(config: config))
      ..writeln(QueryClassTemplate(config: config));

    return buffer.toString();
  }

  // TODO: メソッド名、doc comment を更新する。
  /// Parses [FirestoreDocument] annotation.
  FirestoreDocumentConfig _parseFirestoreDocumentAnnotation({
    required String baseClassName,
    required Element element,
  }) {
    const matcher = TypeChecker.fromRuntime(FirestoreDocument);
    final firestoreDocumentAnnotation = element.metadata.where((meta) {
      final obj = meta.computeConstantValue();
      if (obj == null) {
        return false;
      }
      return matcher.isExactlyType(obj.type!);
    }).firstOrNull;

    if (firestoreDocumentAnnotation == null) {
      throw InvalidGenerationSourceError(
        'No @FirestoreDocument annotation is found. '
        'Failing element: ${element.name}',
        element: element,
      );
    }

    // TODO: ここで path, collectionName, documentName のフィールドが必須であることを確認するロジックにしたい
    // TODO: 切り出したメソッドはテストがしやすい方法を考える

    final source = firestoreDocumentAnnotation.toSource();

    return FirestoreDocumentConfig(
      useFakeFirebaseFirestore:
          _useFakeFirebaseFirestore(element: element, source: source),
      baseClassName: baseClassName,
      path: _path(element: element, source: source),
      documentName: _documentName(element: element, source: source),
    );
  }

  bool _useFakeFirebaseFirestore({
    required Element element,
    required String source,
  }) {
    final match = RegExp(FirestoreDocument.useFakeFirebaseFirestoreRegExpSource)
        .firstMatch(source);
    if (match == null) {
      return false;
    }
    return match.group(1) == 'true';
  }

  String _path({
    required Element element,
    required String source,
  }) {
    final match = RegExp(FirestoreDocument.pathRegExpSource).firstMatch(source);
    if (match == null) {
      throw InvalidGenerationSourceError(
        '@FirestoreDocument annotation does not contain path. '
        'Failing element: ${element.name}',
        element: element,
      );
    }
    return match.group(1)!;
  }

  String _documentName({
    required Element element,
    required String source,
  }) {
    final match = RegExp(FirestoreDocument.documentNameNameRegExpSource)
        .firstMatch(source);
    if (match == null) {
      throw InvalidGenerationSourceError(
        '@FirestoreDocument annotation does not contain documentName. '
        'Failing element: ${element.name}',
        element: element,
      );
    }
    return match.group(1)!;
  }
}

///
class FirestorePathSegment {
  ///
  const FirestorePathSegment({
    required this.collectionName,
    required this.documentName,
  });

  ///
  final String collectionName;

  ///
  final String? documentName;
}

///
List<FirestorePathSegment> parseFirestorePath(String path) {
  final pattern = RegExp(r'(\w+)(\/\{(\w+)\})?');
  final matches = pattern.allMatches(path);

  // TODO: データの持ち方は本当にこれで良いか検討する
  // TODO: CollectionDocumentName 型 or FirestorePath 型に toString は不要か考える
  // TODO: 上記の正規表現にあてはまらない入力のときに適切にエラーをスローする
  final firestorePath = matches.map((match) {
    final collectionName = match.group(1)!;
    final documentName = match.group(3);
    return FirestorePathSegment(
      collectionName: collectionName,
      documentName: documentName,
    );
  }).toList();
  return firestorePath;
}
