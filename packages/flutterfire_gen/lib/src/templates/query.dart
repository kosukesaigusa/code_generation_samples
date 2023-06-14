import '../flutterfire_gen.dart';

/// Returns Query class template.
String queryClassTemplate({required FirestoreDocumentConfig config}) {
  return '''
/// A query manager to execute query against [${config.baseClassName}].
class ${config.baseClassName}Query {
  /// Fetches [${config.readClassName}] documents.
  Future<List<${config.readClassName}>> fetchDocuments({
    GetOptions? options,
    Query<${config.readClassName}>? Function(Query<${config.readClassName}> query)? queryBuilder,
    int Function(${config.readClassName} lhs, ${config.readClassName} rhs)? compare,
  }) async {
    Query<${config.readClassName}> query = read${config.baseClassName}CollectionReference;
    if (queryBuilder != null) {
      query = queryBuilder(query)!;
    }
    final qs = await query.get(options);
    final result = qs.docs.map((qds) => qds.data()).toList();
    if (compare != null) {
      result.sort(compare);
    }
    return result;
  }

  /// Subscribes [${config.baseClassName}] documents.
  Stream<List<${config.readClassName}>> subscribeDocuments({
    Query<${config.readClassName}>? Function(Query<${config.readClassName}> query)? queryBuilder,
    int Function(${config.readClassName} lhs, ${config.readClassName} rhs)? compare,
    bool includeMetadataChanges = false,
    bool excludePendingWrites = false,
  }) {
    Query<${config.readClassName}> query = read${config.baseClassName}CollectionReference;
    if (queryBuilder != null) {
      query = queryBuilder(query)!;
    }
    var streamQs =
        query.snapshots(includeMetadataChanges: includeMetadataChanges);
    if (excludePendingWrites) {
      streamQs = streamQs.where((qs) => !qs.metadata.hasPendingWrites);
    }
    return streamQs.map((qs) {
      final result = qs.docs.map((qds) => qds.data()).toList();
      if (compare != null) {
        result.sort(compare);
      }
      return result;
    });
  }

  /// Fetches [${config.readClassName}] document.
  Future<${config.readClassName}?> fetchDocument({
    required String ${config.documentName}Id,
    GetOptions? options,
  }) async {
    final ds =
        await read${config.baseClassName}DocumentReference(${config.documentName}Id: ${config.documentName}Id).get(options);
    return ds.data();
  }

  /// Subscribes [${config.baseClassName}] document.
  Future<Stream<${config.readClassName}?>> subscribeDocument({
    required String ${config.documentName}Id,
    bool includeMetadataChanges = false,
    bool excludePendingWrites = false,
  }) async {
    var streamDs = read${config.baseClassName}DocumentReference(${config.documentName}Id: ${config.documentName}Id)
        .snapshots(includeMetadataChanges: includeMetadataChanges);
    if (excludePendingWrites) {
      streamDs = streamDs.where((ds) => !ds.metadata.hasPendingWrites);
    }
    return streamDs.map((ds) => ds.data());
  }
}
''';
}
