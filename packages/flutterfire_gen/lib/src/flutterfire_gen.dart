// ignore_for_file: implementation_imports, depend_on_referenced_packages

import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:flutterfire_gen_annotation/flutterfire_gen_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'firestore_document_visitor.dart';
import 'templates/query.dart';
import 'templates/read/read_class_template.dart';
import 'templates/refs.dart';
import 'utils/string.dart';

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
      ..writeln('''
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark
''')
      ..writeln(
        ReadClassTemplate(config: config, visitor: visitor, fields: fields),
      )
      ..writeln(refsTemplate(config: config))
      ..writeln(queryClassTemplate(config: config))
      ..toString();

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
      final obj = meta.computeConstantValue()!;
      return matcher.isExactlyType(obj.type!);
    }).firstOrNull;

    if (firestoreDocumentAnnotation == null) {
      throw InvalidGenerationSourceError(
        'No @FirestoreDocument annotation is found. '
        'Failing element: ${element.name}',
        element: element,
      );
    }

    final source = firestoreDocumentAnnotation.toSource();

    return FirestoreDocumentConfig(
      useFakeFirebaseFirestore:
          _useFakeFirebaseFirestore(element: element, source: source),
      baseClassName: baseClassName,
      collectionName: _collectionName(element: element, source: source),
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

  String _collectionName({
    required Element element,
    required String source,
  }) {
    final match =
        RegExp(FirestoreDocument.collectionNameRegExpSource).firstMatch(source);
    if (match == null) {
      throw InvalidGenerationSourceError(
        '@FirestoreDocument annotation does not contain collectionName. '
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
class FirestoreDocumentConfig {
  ///
  FirestoreDocumentConfig({
    required this.useFakeFirebaseFirestore,
    required this.baseClassName,
    required this.collectionName,
    required this.documentName,
  });

  ///
  final bool useFakeFirebaseFirestore;

  ///
  final String baseClassName;

  ///
  final String collectionName;

  ///
  final String documentName;

  ///
  String get capitalizedCollectionName => collectionName.capitalize();

  ///
  String get capitalizedDocumentName => documentName.capitalize();

  ///
  String get readClassName => 'Read$baseClassName';

  ///
  String get writeClassName => 'Write$baseClassName';

  ///
  String get readCollectionReferenceName =>
      'read${baseClassName}CollectionReference';

  ///
  String get readDocumentReferenceName =>
      'read${baseClassName}DocumentReference';
}
