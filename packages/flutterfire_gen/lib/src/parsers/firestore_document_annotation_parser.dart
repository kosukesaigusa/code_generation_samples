import 'package:analyzer/dart/element/element.dart';
import 'package:flutterfire_gen_annotation/flutterfire_gen_annotation.dart';
import 'package:source_gen/source_gen.dart';

import '../configs/firestore_document_config.dart';

/// A parser for [FirestoreDocument] annotation.
class FirestoreDocumentAnnotationParser {
  /// Creates a new instance of [FirestoreDocumentAnnotationParser].
  FirestoreDocumentAnnotationParser({
    required this.baseClassName,
    required this.element,
  });

  /// Parses [FirestoreDocument] annotation.
  final String baseClassName;

  /// An [Element] of [FirestoreDocument] annotated class.
  final Element element;

  /// Parses [FirestoreDocument] annotation, and returns
  /// [FirestoreDocumentConfig].
  FirestoreDocumentConfig parse() {
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
        'Element name: ${element.name}',
        element: element,
      );
    }

    final source = firestoreDocumentAnnotation.toSource();

    return FirestoreDocumentConfig(
      includeDocumentReferenceField:
          _includeDocumentReferenceField(element: element, source: source),
      generateCopyWith: _generateCopyWith(element: element, source: source),
      baseClassName: baseClassName,
      path: _path(element: element, source: source),
      documentName: _documentName(element: element, source: source),
    );
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
        'Element name: ${element.name}',
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
        'Element name: ${element.name}',
        element: element,
      );
    }
    return match.group(1)!;
  }
}
