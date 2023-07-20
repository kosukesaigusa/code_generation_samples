// ignore_for_file: implementation_imports

import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:flutterfire_gen_annotation/flutterfire_gen_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'config.dart';
import 'firestore_document_visitor.dart';
import 'templates/create/create_class_template.dart';
import 'templates/fake_firebase_firestore_template.dart';
import 'templates/query_class_template.dart';
import 'templates/read/read_class_template.dart';
import 'templates/refs_template.dart';
import 'templates/update/update_class_template.dart';

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
      ..writeln(FakeFirebaseFirestoreTemplate(config: config))
      ..writeln(
        ReadClassTemplate(config: config, visitor: visitor, fields: fields),
      )
      ..writeln(
        CreateClassTemplate(config: config, visitor: visitor, fields: fields),
      )
      ..writeln(
        UpdateClassTemplate(config: config, visitor: visitor, fields: fields),
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
      includeDocumentReferenceField:
          _includeDocumentReferenceField(element: element, source: source),
      generateCopyWith: _generateCopyWith(element: element, source: source),
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

  bool _includeDocumentReferenceField({
    required Element element,
    required String source,
  }) {
    final match =
        RegExp(FirestoreDocument.includeDocumentReferenceFieldRegExpSource)
            .firstMatch(source);
    if (match == null) {
      return false;
    }
    return match.group(1) == 'true';
  }

  bool _generateCopyWith({
    required Element element,
    required String source,
  }) {
    final match = RegExp(FirestoreDocument.generateCopyWithRegExpSource)
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
    final match =
        RegExp(FirestoreDocument.documentNameRegExpSource).firstMatch(source);
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

/// A class to represent a segment of a Firestore path.
///
/// Each segment in a Firestore path is composed of a collection name
/// and potentially a document name, with the path segments alternating
/// between collections and documents. For example, in the path
/// 'appUsers/{appUserId}/appUserPosts/{appUserPostId}/appUserPostLikes',
/// 'appUsers', 'appUserPosts', and 'appUserPostLikes' are collection names
/// and '{appUserId}' and '{appUserPostId}' are document names.
class FirestorePathSegment {
  /// Creates a Firestore path segment.
  ///
  /// [collectionName] and [documentName] represent the names of
  /// the collection and document respectively in a segment of a Firestore path.
  /// [collectionName] is required, while [documentName] is optional since
  /// a Firestore path can end with a collection.
  ///
  /// For example, in the path 'appUsers/{appUserId}/appUserPosts',
  /// 'appUsers' is a collection name and '{appUserId}' is a document name,
  /// while 'appUserPosts' is another collection name without a following
  /// document name.
  const FirestorePathSegment({
    required this.collectionName,
    required this.documentName,
  });

  /// The name of the collection in this segment of a Firestore path.
  final String collectionName;

  /// The name of the document in this segment of a Firestore path, if one
  /// exists.
  final String? documentName;
}

/// Parses a Firestore path into a list of Firestore path segments.
///
/// This function accepts a Firestore path as a string, and returns a list of
/// [FirestorePathSegment] objects. Each segment in the Firestore path is
/// composed of a collection name and potentially a document name, with the path
/// segments alternating between collections and documents.
///
/// For example, given the path 'appUsers/{appUserId}/appUserPosts/{appUserPostId}/appUserPostLikes',
/// this function will return a list containing three [FirestorePathSegment]
/// objects:
/// 1. FirestorePathSegment with collectionName 'appUsers' and documentName
/// '{appUserId}'
/// 2. FirestorePathSegment with collectionName 'appUserPosts' and documentName
/// '{appUserPostId}'
/// 3. FirestorePathSegment with collectionName 'appUserPostLikes' and no
/// documentName
///
/// Throws an [ArgumentError] if the provided path does not adhere to the
/// alternating collection/document structure or if the path includes an
/// additional segment that doesn't start with '/' and doesn't have a following
/// collection name.
///
/// @param path The Firestore path string to parse.
/// @returns A list of [FirestorePathSegment] objects representing the parsed
/// path.
List<FirestorePathSegment> parseFirestorePath(String path) {
  final pattern = RegExp(r'(\w+)(\/\{(\w+)\})?');
  final matches = pattern.allMatches(path);

  // TODO: 上記の正規表現にあてはまらない入力のときに適切にエラーをスローする
  // TODO: このくらいのチェックで良いのか悩む...
  // if (matches.length.isEven) {
  //   throw ArgumentError('Invalid Firestore path: $path');
  // }

  // TODO: データの持ち方は本当にこれで良いか検討する
  // TODO: CollectionDocumentName 型 or FirestorePath 型に toString は不要か考える
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
