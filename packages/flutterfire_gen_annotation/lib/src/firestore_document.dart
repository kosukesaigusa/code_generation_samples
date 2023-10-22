/// An annotation to define Cloud Firestore document.
class FirestoreDocument {
  /// Creates a [FirestoreDocument].
  const FirestoreDocument({
    required this.path,
    required this.documentName,
    this.includePathField,
    this.includeDocumentReferenceField,
    this.generateCopyWith,
  });

  /// A path to firestore document.
  ///
  /// e.g.
  ///
  /// - users
  /// - users/{userId}/userPosts
  /// - users/{userId}/userPosts/{userPostId}/userPostLikes
  final String path;

  /// A document name which is used for document ID field.
  ///
  /// e.g.
  ///
  /// - user
  /// - userPost
  /// - userPostLike
  final String documentName;

  /// Whether to include `path` field in ReadEntity class.
  final bool? includePathField;

  /// Whether to include `DocumentReference` field in ReadEntity class.
  final bool? includeDocumentReferenceField;

  /// Whether to generate `copyWith` method in ReadEntity class.
  final bool? generateCopyWith;
}
