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
    return '''
${_collectionReferenceTemplate()}
${_documentReferenceTemplate()}
''';
  }

  // TODO: これ全体をクラス化する
  String _collectionReferenceTemplate() {
    final buffer = StringBuffer()
      ..writeln(
        '/// A [CollectionReference] to ${config.collectionName} collection to read.',
      )
      ..write(_collectionReference())
      ..write(_firestoreInstance());
    for (final segment in config.firestorePathSegments) {
      final collectionName = segment.collectionName;
      final documentName = segment.documentName;
      buffer.write(".collection('$collectionName')");
      if (documentName != null) {
        buffer.write('.doc($documentName)');
      }
    }
    buffer.write(_withConverterString());
    return buffer.toString();
  }

  // TODO: これ全体をクラス化する
  String _documentReferenceTemplate() {
    final buffer = StringBuffer()
      ..writeln(
        '/// A [DocumentReference] to ${config.documentName} document to read.',
      )
      ..writeln(_documentReference());

    return buffer.toString();
  }

  String _collectionReference() {
    if (config.firestorePathSegments.isEmpty) {
      // TODO: 適切にエラーをハンドリングする
      throw Error();
    }
    if (config.firestorePathSegments.length == 1) {
      return 'final read${config.baseClassName}CollectionReference = ';
    }
    return '''
CollectionReference<${config.readClassName}> read${config.baseClassName}CollectionReference ({
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

  String _withConverterString() => '''
.withConverter(
  fromFirestore: (ds, _) => ${config.readClassName}.fromDocumentSnapshot(ds),
  toFirestore: (obj, _) => throw UnimplementedError(),
);
''';

  String _documentReference() {
    if (config.firestorePathSegments.isEmpty) {
      // TODO: 適切にエラーをハンドリングする
      throw Error();
    }
    if (config.firestorePathSegments.length == 1) {
      return '''
DocumentReference<${config.readClassName}> read${config.baseClassName}DocumentReference({
  required String ${config.documentName}Id,
}) =>
    read${config.baseClassName}CollectionReference.doc(${config.documentName}Id);
''';
    }
    return '''
DocumentReference<${config.readClassName}> read${config.baseClassName}DocumentReference({
  ${_documentIdParameters()}
  required String ${config.documentName}Id,
}) =>
    read${config.baseClassName}CollectionReference(
      ${config.firestorePathSegments.map((segment) => segment.documentName).whereType<String>().map((documentId) => "$documentId: $documentId").join(',\n')}
    ).doc(${config.documentName}Id);
''';
  }

  String _documentIdParameters() =>
      "${config.firestorePathSegments.map((segment) => segment.documentName).whereType<String>().map((documentId) => 'required String $documentId').join(',\n')},";
}
