// ignore_for_file: comment_references, lines_longer_than_80_chars

import '../config.dart';

/// Returns [CollectionReference] and [DocumentReference] template.
class RefsTemplate {
  /// Creates a [ReadRefsTemplate].
  const RefsTemplate({required this.config});

  ///
  final FirestoreDocumentConfig config;

  @override
  String toString() {
    final buffer = StringBuffer();
    for (final referenceClassType in ReferenceClassType.values) {
      buffer.writeln(_collectionReferenceTemplate(referenceClassType));
      buffer.writeln(_documentReferenceTemplate(referenceClassType));
    }
    return buffer.toString();
  }

  String _collectionReferenceTemplate(ReferenceClassType referenceClassType) {
    final buffer = StringBuffer()
      ..writeln(
        '/// A [CollectionReference] to ${config.collectionName} collection to ${referenceClassType.name}.',
      )
      ..write(_collectionReference(referenceClassType))
      ..write(_firestoreInstance());
    for (final segment in config.firestorePathSegments) {
      final collectionName = segment.collectionName;
      final documentName = segment.documentName;
      buffer.write(".collection('$collectionName')");
      if (documentName != null) {
        buffer.write('.doc($documentName)');
      }
    }
    if (_needsTyping(referenceClassType)) {
      buffer.write(_withConverterString(referenceClassType));
    }
    buffer.write(';');
    return buffer.toString();
  }

  String _documentReferenceTemplate(ReferenceClassType referenceClassType) {
    final buffer = StringBuffer()
      ..writeln(
        '/// A [DocumentReference] to ${config.documentName} document to ${referenceClassType.name}.',
      )
      ..writeln(_documentReference(referenceClassType));
    return buffer.toString();
  }

  String _collectionReference(ReferenceClassType referenceClassType) {
    if (config.firestorePathSegments.isEmpty) {
      // TODO: 適切にエラーをハンドリングする
      throw Error();
    }
    if (config.firestorePathSegments.length == 1) {
      return 'final ${_collectionReferenceName(referenceClassType)} = ';
    }
    return '''
${_collectionReferenceTypeAnnotation(referenceClassType)} ${_collectionReferenceName(referenceClassType)} ({
  ${_documentIdParameters()}
}) =>
''';
  }

  String _firestoreInstance() {
    if (config.useFakeFirebaseFirestore) {
      return 'fakeDb';
    }
    return 'FirebaseFirestore.instance';
  }

  String _withConverterString(ReferenceClassType referenceClassType) {
    switch (referenceClassType) {
      case ReferenceClassType.read:
        return '''
.withConverter<${_className(referenceClassType)}>(
  fromFirestore: (ds, _) => ${_className(referenceClassType)}.fromDocumentSnapshot(ds),
  toFirestore: (obj, _) => throw UnimplementedError(),
)
''';
      case ReferenceClassType.create:
      case ReferenceClassType.update:
        return '''
.withConverter<${_className(referenceClassType)}>(
  fromFirestore: (ds, _) => throw UnimplementedError(),
  toFirestore: (obj, _) => obj.toJson(),
)
''';
      case ReferenceClassType.delete:
        throw ArgumentError();
    }
  }

  String _documentReference(ReferenceClassType referenceClassType) {
    if (config.firestorePathSegments.isEmpty) {
      // TODO: 適切にエラーをハンドリングする
      throw Error();
    }
    if (config.firestorePathSegments.length == 1) {
      return '''
${_documentReferenceTypeAnnotation(referenceClassType)} ${_documentReferenceName(referenceClassType)}({
  required String ${config.documentName}Id,
}) =>
    ${_collectionReferenceName(referenceClassType)}.doc(${config.documentName}Id);
''';
    }
    return '''
${_documentReferenceTypeAnnotation(referenceClassType)} ${_documentReferenceName(referenceClassType)}({
  ${_documentIdParameters()}
  required String ${config.documentName}Id,
}) =>
    ${_collectionReferenceName(referenceClassType)}(
      ${config.firestorePathSegments.map((segment) => segment.documentName).whereType<String>().map((documentId) => "$documentId: $documentId").join(',\n')}
    ).doc(${config.documentName}Id);
''';
  }

  String _documentIdParameters() =>
      "${config.firestorePathSegments.map((segment) => segment.documentName).whereType<String>().map((documentId) => 'required String $documentId').join(',\n')},";

  ///
  String _className(ReferenceClassType referenceClassType) {
    switch (referenceClassType) {
      case ReferenceClassType.read:
        return config.readClassName;
      case ReferenceClassType.create:
        return config.createClassName;
      case ReferenceClassType.update:
        return config.updateClassName;
      case ReferenceClassType.delete:
        return config.deleteClassName;
    }
  }

  ///
  String _collectionReferenceName(ReferenceClassType referenceClassType) {
    switch (referenceClassType) {
      case ReferenceClassType.read:
        return config.readCollectionReferenceName;
      case ReferenceClassType.create:
        return config.createCollectionReferenceName;
      case ReferenceClassType.update:
        return config.updateCollectionReferenceName;
      case ReferenceClassType.delete:
        return config.deleteCollectionReferenceName;
    }
  }

  ///
  String _documentReferenceName(ReferenceClassType referenceClassType) {
    switch (referenceClassType) {
      case ReferenceClassType.read:
        return config.readDocumentReferenceName;
      case ReferenceClassType.create:
        return config.createDocumentReferenceName;
      case ReferenceClassType.update:
        return config.updateDocumentReferenceName;
      case ReferenceClassType.delete:
        return config.deleteDocumentReferenceName;
    }
  }

  /// [CollectionReference] や [DocumentReference] に型をつけるかどうか。
  /// [ReferenceClassType] によって異なる。
  bool _needsTyping(ReferenceClassType referenceClassType) =>
      referenceClassType != ReferenceClassType.delete;

  String _collectionReferenceTypeAnnotation(
    ReferenceClassType referenceClassType,
  ) {
    if (_needsTyping(referenceClassType)) {
      return 'CollectionReference<${_className(referenceClassType)}>';
    } else {
      return 'CollectionReference<Object?>';
    }
  }

  String _documentReferenceTypeAnnotation(
    ReferenceClassType referenceClassType,
  ) {
    if (_needsTyping(referenceClassType)) {
      return 'DocumentReference<${_className(referenceClassType)}>';
    } else {
      return 'DocumentReference<Object?>';
    }
  }
}
