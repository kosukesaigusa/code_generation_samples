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
      ${_parentDocumentIdArguments()}
      queryBuilder,
      compare
  }: {
      ${_parentDocumentIdArgumentTypes()}
      queryBuilder?: (
          query: FirebaseFirestore.Query<${config.readClassName}>
      ) => FirebaseFirestore.Query<${config.readClassName}>
      compare?: (lhs: ${config.readClassName}, rhs: ${config.readClassName}) => number
  }): Promise<${config.readClassName}[]> {
      let query: FirebaseFirestore.Query<${config.readClassName}> =
          ${_collectionReference(ReferenceClassType.read)}
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
  async fetchDocument({
    ${_parentDocumentIdArguments()}
    ${config.documentIdFieldName}
  }: {
    ${_parentDocumentIdArgumentTypes()}
    ${config.documentIdFieldName}: string
  }): Promise<${config.readClassName} | undefined> {
    const ds = await ${config.readDocumentReferenceName}({
      ${_parentDocumentIdParameters()}
      ${config.documentIdFieldName}
    }).get()
    return ds.data()
  }

  /**
   * Adds a ${config.documentName} document.
   * @param ${config.createClassInstanceName} - The ${config.documentName} details to add.
   */
  async add({
    ${_parentDocumentIdArguments()}
    ${config.createClassInstanceName}
  }: {
    ${_parentDocumentIdArgumentTypes()}
    ${config.createClassInstanceName}: ${config.createClassName}
  }): Promise<DocumentReference<${config.createClassName}>> {
    return ${_collectionReference(ReferenceClassType.create)}.add(${config.createClassInstanceName})
  }

  /**
   * Sets a ${config.documentName} document.
   * @param ${config.documentIdFieldName} - The ID of the ${config.documentName} document to set.
   * @param ${config.createClassInstanceName} - The ${config.documentName} details to set.
   * @param options - Options for the set operation.
   */
  async set({
      ${_parentDocumentIdArguments()}
      ${config.documentIdFieldName},
      ${config.createClassInstanceName},
      options
  }: {
      ${_parentDocumentIdArgumentTypes()}
      ${config.documentIdFieldName}: string
      ${config.createClassInstanceName}: ${config.createClassName}
      options?: FirebaseFirestore.SetOptions
  }): Promise<WriteResult> {
      if (options == undefined) {
          return ${config.createDocumentReferenceName}({
            ${_parentDocumentIdArguments()}
            ${config.documentIdFieldName}
          }).set(${config.createClassInstanceName})
      } else {
          return ${config.createDocumentReferenceName}({ 
            ${_parentDocumentIdArguments()}
            ${config.documentIdFieldName} 
            }).set(${config.createClassInstanceName}, options)
      }
  }

  /**
   * Updates a specific ${config.documentName} document.
   * @param ${config.documentIdFieldName} - The ID of the ${config.documentName} document to update.
   * @param ${config.updateClassInstanceName} - The details for updating the ${config.documentName}.
   */
  async update({
    ${_parentDocumentIdArguments()}
    ${config.documentIdFieldName},
    ${config.updateClassInstanceName}
  }: {
    ${_parentDocumentIdArgumentTypes()}
    ${config.documentIdFieldName}: string
    ${config.updateClassInstanceName}: ${config.updateClassName}
  }): Promise<WriteResult> {
      return ${config.updateDocumentReferenceName}({ 
        ${_parentDocumentIdArguments()}
        ${config.documentIdFieldName} 
      }).update(${config.updateClassInstanceName}.toJson())
  }

  /**
   * Deletes a specific ${config.documentName} document.
   * @param ${config.documentIdFieldName} - The ID of the ${config.documentName} document to delete.
   */
  async delete({
    ${_parentDocumentIdArguments()}
    ${config.documentIdFieldName}
  }: {
    ${_parentDocumentIdArgumentTypes()}
    ${config.documentIdFieldName}: string
  }): Promise<WriteResult> {
      return ${config.deleteDocumentReferenceName}({ 
        ${_parentDocumentIdArguments()}
        ${config.documentIdFieldName} 
      }).delete()
  }
}
''';
  }

  String _parentDocumentIdArguments() {
    final documentIds = config.firestorePathSegments
        .map((segment) => segment.documentName)
        .whereType<String>();
    return documentIds.isNotEmpty
        ? documentIds.map((documentId) => '$documentId,').join('\n')
        : '';
  }

  String _parentDocumentIdArgumentTypes() {
    final documentIds = config.firestorePathSegments
        .map((segment) => segment.documentName)
        .whereType<String>();
    return documentIds.isNotEmpty
        ? "${documentIds.map((documentId) => '$documentId: string').join('\n')},"
        : '';
  }

  String _parentDocumentIdParameters() {
    final documentIds = config.firestorePathSegments
        .map((segment) => segment.documentName)
        .whereType<String>();
    return documentIds.isNotEmpty
        ? documentIds.map((documentId) => '$documentId,').join('\n')
        : '';
  }

  String _collectionReference(ReferenceClassType referenceClassType) {
    if (config.firestorePathSegments.length > 1) {
      return '${config.collectionReferenceName(referenceClassType)}({${config.firestorePathSegments.map((segment) => segment.documentName).whereType<String>().map((documentId) => documentId).join(',')}})';
    } else {
      return config.collectionReferenceName(referenceClassType);
    }
  }
}
