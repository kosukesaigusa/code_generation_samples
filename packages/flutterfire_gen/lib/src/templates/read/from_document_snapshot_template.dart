import '../../config.dart';

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
      '${config.documentReferenceFieldName}': ${config.readDocumentReferenceName}(entityId: ds.id),
    });
  }
''';
  }
}
