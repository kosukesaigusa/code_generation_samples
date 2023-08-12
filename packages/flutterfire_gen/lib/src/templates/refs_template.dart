// ignore_for_file: comment_references, lines_longer_than_80_chars

import '../config.dart';

/// Returns [CollectionReference] and [DocumentReference] template.
class RefsTemplate {
  /// Creates a [RefsTemplate].
  const RefsTemplate({required this.config});

  ///
  final FirestoreDocumentConfig config;

  @override
  String toString() {
    final buffer = StringBuffer();
    for (final referenceClassType in ReferenceClassType.values) {
      buffer
        ..writeln(_collectionReferenceTemplate(referenceClassType))
        ..writeln()
        ..writeln(_documentReferenceTemplate(referenceClassType));
    }
    return buffer.toString();
  }

  String _collectionReferenceTemplate(ReferenceClassType referenceClassType) {
    final buffer = StringBuffer()
      ..writeln(
        '/// Provides a reference to the ${config.collectionName} collection for ${referenceClassType.toIng()}.',
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
    buffer.write(_withConverterString(referenceClassType));
    buffer.write(';');
    return buffer.toString();
  }

  String _documentReferenceTemplate(ReferenceClassType referenceClassType) {
    final buffer = StringBuffer()
      ..writeln(
        '/// Provides a reference to a ${config.documentName} document for ${referenceClassType.toIng()}.',
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
  toFirestore: (_, __) => throw UnimplementedError(),
)
''';
      case ReferenceClassType.create:
      case ReferenceClassType.update:
        return '''
.withConverter<${_className(referenceClassType)}>(
  fromFirestore: (_, __) => throw UnimplementedError(),
  toFirestore: (obj, _) => obj.toJson(),
)
''';
      case ReferenceClassType.delete:
        return '''
.withConverter<${_className(referenceClassType)}>(
  fromFirestore: (_, __) => throw UnimplementedError(),
  toFirestore: (_, __) => throw UnimplementedError(),
)
''';
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

  String _collectionReferenceTypeAnnotation(
    ReferenceClassType referenceClassType,
  ) =>
      'CollectionReference<${_className(referenceClassType)}>';

  String _documentReferenceTypeAnnotation(
    ReferenceClassType referenceClassType,
  ) =>
      'DocumentReference<${_className(referenceClassType)}>';
}
