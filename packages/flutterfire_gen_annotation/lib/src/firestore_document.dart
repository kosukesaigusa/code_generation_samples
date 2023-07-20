import 'package:meta/meta.dart';

/// An annotation to define Cloud Firestore document.
class FirestoreDocument {
  /// Creates a [FirestoreDocument].
  const FirestoreDocument({
    @visibleForTesting this.useFakeFirebaseFirestore = false,
    required this.path,
    required this.documentName,
  });

  /// Set true if you want to use FakeFirebaseFirestore for testing.
  final bool useFakeFirebaseFirestore;

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

  /// A [RegExp] source string to parse [useFakeFirebaseFirestore] from
  /// annotation.
  static const useFakeFirebaseFirestoreRegExpSource =
      r'useFakeFirebaseFirestore:\s*(true|false)';

  /// A [RegExp] source string to parse [path] from annotation.
  static const pathRegExpSource = r"path:\s*'([^']*)'";

  /// A [RegExp] source string to parse [documentName] from annotation.
  static const documentNameRegExpSource = r"documentName:\s*'([^']*)'";
}
