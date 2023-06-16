import 'package:meta/meta.dart';

/// An annotation to define Cloud Firestore document.
class FirestoreDocument {
  /// Creates a [FirestoreDocument].
  const FirestoreDocument({
    @visibleForTesting this.useFakeFirebaseFirestore = false,
    required this.collectionName,
    required this.documentName,
  });

  /// Set true if you want to use FakeFirebaseFirestore for testing.
  final bool useFakeFirebaseFirestore;

  /// A [RegExp] source string to parse [useFakeFirebaseFirestore] from
  /// annotation.
  static const useFakeFirebaseFirestoreRegExpSource =
      r'useFakeFirebaseFirestore:\s*(true|false)';

  /// A [RegExp] source string to parse [collectionName] from annotation.
  static const collectionNameRegExpSource = r"collectionName:\s*'([^']*)'";

  /// A [RegExp] source string to parse [documentName] from annotation.
  static const documentNameNameRegExpSource = r"documentName:\s*'([^']*)'";

  /// A collection name of the document is stored (e.g. users).
  final String collectionName;

  /// A document name which is used for document ID field (e.g. user).
  final String documentName;
}

/// An annotation to give default value if the field is null when calling
/// fromJson.
class Default {
  /// Create a [Default].
  const Default(this.value);

  /// A default value.
  final dynamic value;
}
