import '../../config.dart';

// TODO: DocumentReference の処遇は後で考える

///
class FromDocumentSnapshotTemplate {
  ///
  const FromDocumentSnapshotTemplate({required this.config});

  ///
  final FirestoreDocumentConfig config;

  @override
  String toString() {
    return '''
static fromDocumentSnapshot(
    ds: FirebaseFirestore.DocumentSnapshot
  ): ${config.readClassName} {
      const data = ds.data()!
      const cleanedData: Record<string, unknown> = {}
      for (const [key, value] of Object.entries(data)) {
          cleanedData[key] = value === null ? undefined : value
      }
      return ${config.readClassName}.fromJson({
          ...cleanedData,
          ${config.documentIdFieldName}: ds.id,
          path: ds.ref.path
      })
  }
''';
  }
}
