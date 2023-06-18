///
class FromDocumentSnapshotTemplate {
  ///
  const FromDocumentSnapshotTemplate({
    required this.readClassName,
    required this.documentName,
  });

  ///
  final String readClassName;

  ///
  final String documentName;

  @override
  String toString() {
    return '''
factory $readClassName.fromDocumentSnapshot(DocumentSnapshot ds) {
    final data = ds.data()! as Map<String, dynamic>;
    return $readClassName.fromJson(<String, dynamic>{
      ...data,
      '${documentName}Id': ds.id,
    });
  }
''';
  }
}
