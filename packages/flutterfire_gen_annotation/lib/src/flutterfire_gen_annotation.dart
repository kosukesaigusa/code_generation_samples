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
  static const documentNameNameRegExpSource = r"documentName:\s*'([^']*)'";
}

///
sealed class Default {
  ///
  const Default();
}

/// An annotation to give default value if the field is null when calling
/// fromJson to toJson.
final class FromJsonDefault extends Default {
  /// Create a [FromJsonDefault].
  const FromJsonDefault(this.value);

  /// A default value.
  final dynamic value;
}

// TODO: fromJsonDefault, toJsonDefault くらいの命名・分類でも良さそう
/// An annotation to give default value if the field is null when calling
/// toJson.
final class ToJsonDefault extends Default {
  /// Create a [ToJsonDefault].
  const ToJsonDefault(this.value);

  /// A default value.
  final dynamic value;
}

/// An annotation to accept Cloud Firestore FieldValue input when creating or
/// updating document.
class AllowFieldValue {
  ///
  const AllowFieldValue();
}
