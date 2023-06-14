import '../flutterfire_gen.dart';

/// Returns Query class template.
String queryClassTemplate({required FirestoreDocumentConfig config}) {
  return '''
/// A query manager to execute query against ${config.collectionName} collection.
class ${config.baseClassName}Query {
  /// Fetches ${config.readClassName} documents from ${config.collectionName} collection
  Future<List<${config.readClassName}>> fetch${config.baseClassName}List({
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
}
''';
}
