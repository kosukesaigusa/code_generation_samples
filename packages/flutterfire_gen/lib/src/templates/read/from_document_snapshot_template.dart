import '../../configs/firestore_document_config.dart';

///
class FromDocumentSnapshotTemplate {
  ///
  const FromDocumentSnapshotTemplate({required this.config});

  ///
  final FirestoreDocumentConfig config;

  @override
  String toString() {
    return '''
factory ${config.readClassName}.fromDocumentSnapshot(DocumentSnapshot ds) {
    final data = ds.data()! as Map<String, dynamic>;
    return ${config.readClassName}._fromJson(<String, dynamic>{
      ...data,
      '${config.documentIdFieldName}': ds.id,
      '${config.documentPathFieldName}': ds.reference.path,
      ${_documentReferenceField()}
    });
  }
''';
  }

  String _documentReferenceField() {
    if (config.includeDocumentReferenceField) {
      return '''
'${config.documentReferenceFieldName}': ds.reference.parent.doc(ds.id).withConverter(
        fromFirestore: (ds, _) => ${config.readClassName}.fromDocumentSnapshot(ds),
        toFirestore: (obj, _) => throw UnimplementedError(),
      ),
''';
    }
    return '';
  }
}
