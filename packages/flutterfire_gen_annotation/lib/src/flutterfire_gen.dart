/// An annotation to define Cloud Firestore document.
class FirestoreDocument {
  /// Creates a [FirestoreDocument].
  const FirestoreDocument({
    required this.collectionName,
    required this.documentName,
  });

  /// Collection name of the document is stored (e.g. users).
  final String collectionName;

  /// Document name which is used for document ID field (e.g. user).
  final String documentName;
}

/// An annotation to give default value if the field is null when calling
/// fromJson.
class Default {
  /// Create a [Default].
  const Default(this.value);

  final dynamic value;
}
