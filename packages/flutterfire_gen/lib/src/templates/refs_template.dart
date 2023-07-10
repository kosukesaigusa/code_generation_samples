// ignore_for_file: comment_references

import '../config.dart';

/// Returns [CollectionReference] and [DocumentReference] template.
class RefsTemplate {
  /// Creates a [ReadRefsTemplate].
  const RefsTemplate({required this.config});

  ///
  final FirestoreDocumentConfig config;

  @override
  String toString() {
    // TODO: ReferenceClassType.values.map で read, create, update の各クラスに対して実行する
    return '''
${_collectionReferenceTemplate(ReferenceClassType.read)}
${_documentReferenceTemplate(ReferenceClassType.read)}
${_collectionReferenceTemplate(ReferenceClassType.create)}
${_documentReferenceTemplate(ReferenceClassType.create)}
''';
  }

  String _collectionReferenceTemplate(ReferenceClassType referenceClassType) {
    final buffer = StringBuffer()
      ..writeln(
        // TODO: 文言を read, create, update で変える必要がある
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
    buffer.write(_withConverterString(referenceClassType));
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
CollectionReference<${_className(referenceClassType)}> ${_collectionReferenceName(referenceClassType)} ({
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
    if (referenceClassType == ReferenceClassType.read) {
      return '''
.withConverter<${_className(referenceClassType)}>(
  fromFirestore: (ds, _) => ${_className(referenceClassType)}.fromDocumentSnapshot(ds),
  toFirestore: (obj, _) => throw UnimplementedError(),
);
''';
    }
    return '''
.withConverter<${_className(referenceClassType)}>(
  fromFirestore: (ds, _) => throw UnimplementedError(),
  toFirestore: (obj, _) => obj.toJson(),
);
''';
  }

  String _documentReference(ReferenceClassType referenceClassType) {
    if (config.firestorePathSegments.isEmpty) {
      // TODO: 適切にエラーをハンドリングする
      throw Error();
    }
    if (config.firestorePathSegments.length == 1) {
      return '''
DocumentReference<${_className(referenceClassType)}> ${_documentReferenceName(referenceClassType)}({
  required String ${config.documentName}Id,
}) =>
    ${_collectionReferenceName(referenceClassType)}.doc(${config.documentName}Id);
''';
    }
    return '''
DocumentReference<${_className(referenceClassType)}> ${_documentReferenceName(referenceClassType)}({
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
    }
  }
}

///
enum ReferenceClassType {
  ///
  read,

  ///
  create,

  ///
  update,
  ;
}
