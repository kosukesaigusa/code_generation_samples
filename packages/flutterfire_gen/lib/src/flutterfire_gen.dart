// ignore_for_file: implementation_imports, depend_on_referenced_packages

import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:flutterfire_gen_annotation/flutterfire_gen_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'firestore_document_visitor.dart';
import 'templates/query.dart';
import 'templates/read.dart';
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
    final firestoreDocument = _parseFirestoreDocumentAnnotation(element);
    final collectionName = firestoreDocument.collectionName;
    final documentName = firestoreDocument.documentName;

    final config = FirestoreDocumentConfig(
      baseClassName: baseClassName,
      collectionName: collectionName,
      documentName: documentName,
    );

    final buffer = StringBuffer()
      ..writeln(
        readClassTemplate(config: config, visitor: visitor, fields: fields),
      )
      ..writeln(refsTemplate(config: config))
      ..writeln(queryClassTemplate(config: config))
      ..toString();

    return buffer.toString();
  }

  /// Parses [FirestoreDocument] annotation.
  FirestoreDocument _parseFirestoreDocumentAnnotation(
    Element element,
  ) {
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
    final regExp = RegExp(FirestoreDocument.regExpSource);
    final match = regExp.firstMatch(source);
    if (match == null) {
      throw InvalidGenerationSourceError(
        'No @FirestoreDocument annotation format is invalid. '
        'Failing element: ${element.name}',
        element: element,
      );
    }
    return FirestoreDocument(
      collectionName: match.group(1)!,
      documentName: match.group(2)!,
    );
  }
}

///
class FirestoreDocumentConfig {
  ///
  FirestoreDocumentConfig({
    required this.baseClassName,
    required this.collectionName,
    required this.documentName,
  });

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
