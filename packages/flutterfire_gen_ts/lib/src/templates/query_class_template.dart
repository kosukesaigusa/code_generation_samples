// ignore_for_file: lines_longer_than_80_chars

import '../config.dart';

/// Returns Query class template.
class QueryClassTemplate {
  /// Creates a [QueryClassTemplate].
  const QueryClassTemplate({required this.config});

  ///
  final FirestoreDocumentConfig config;

  @override
  String toString() {
    return '''
/**
 * Manages queries against the ${config.collectionName} collection.
 */
export class ${config.baseClassName}Query {
  /**
   * Fetches ${config.documentName} documents.
   * @param queryBuilder - Function to modify the query.
   * @param compare - Function to sort the results.
   */
  async fetchDocuments({
      queryBuilder,
      compare
  }: {
      queryBuilder?: (
          query: FirebaseFirestore.Query<${config.readClassName}>
      ) => FirebaseFirestore.Query<${config.readClassName}>
      compare?: (lhs: ${config.readClassName}, rhs: ${config.readClassName}) => number
  } = {}): Promise<${config.readClassName}[]> {
      let query: FirebaseFirestore.Query<${config.readClassName}> =
          ${config.readCollectionReferenceName}
      if (queryBuilder != undefined) {
          query = queryBuilder(query)
      }
      const qs: QuerySnapshot<${config.readClassName}> = await query.get()
      let result = qs.docs.map((qds: QueryDocumentSnapshot<${config.readClassName}>) =>
          qds.data()
      )
      if (compare != undefined) {
          result = result.sort(compare)
      }
      return result
  }

  /**
   * Fetches a specific ${config.documentName} document.
   * @param ${config.documentIdFieldName} - The ID of the ${config.documentName} document to fetch.
   */
  async fetchDocument(${config.documentIdFieldName}: string): Promise<${config.readClassName} | undefined> {
      const ds = await ${config.readDocumentReferenceName}({ ${config.documentIdFieldName} }).get()
      return ds.data()
  }

  /**
   * Adds a ${config.documentName} document.
   * @param create${config.baseClassName} - The ${config.documentName} details to add.
   */
  async add(create${config.baseClassName}: ${config.createClassName}): Promise<DocumentReference<${config.createClassName}>> {
      return create${config.baseClassName}CollectionReference.add(create${config.baseClassName})
  }

  /**
   * Sets a ${config.documentName} document.
   * @param ${config.documentIdFieldName} - The ID of the ${config.documentName} document to set.
   * @param create${config.baseClassName} - The ${config.documentName} details to set.
   * @param options - Options for the set operation.
   */
  async set({
      ${config.documentIdFieldName},
      create${config.baseClassName},
      options
  }: {
      ${config.documentIdFieldName}: string
      create${config.baseClassName}: ${config.createClassName}
      options?: FirebaseFirestore.SetOptions
  }): Promise<WriteResult> {
      if (options == undefined) {
          return ${config.createDocumentReferenceName}({ ${config.documentIdFieldName} }).set(create${config.baseClassName})
      } else {
          return ${config.createDocumentReferenceName}({ ${config.documentIdFieldName} }).set(
              create${config.baseClassName},
              options
          )
      }
  }

  /**
   * Updates a specific ${config.documentName} document.
   * @param ${config.documentIdFieldName} - The ID of the ${config.documentName} document to update.
   * @param update${config.baseClassName} - The details for updating the ${config.documentName}.
   */
  async update(${config.documentIdFieldName}: string, update${config.baseClassName}: ${config.updateClassName}): Promise<WriteResult> {
      return ${config.updateDocumentReferenceName}({ ${config.documentIdFieldName} }).update(
          update${config.baseClassName}.toJson()
      )
  }

  /**
   * Deletes a specific ${config.documentName} document.
   * @param ${config.documentIdFieldName} - The ID of the ${config.documentName} document to delete.
   */
  async delete(${config.documentIdFieldName}: string): Promise<WriteResult> {
      return ${config.deleteDocumentReferenceName}({ ${config.documentIdFieldName} }).delete()
  }
}
''';
  }
}
