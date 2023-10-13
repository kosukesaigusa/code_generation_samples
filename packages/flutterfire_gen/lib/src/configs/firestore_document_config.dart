import '../utils/string.dart';

///
class JsonConverterConfig {
  ///
  const JsonConverterConfig({
    required this.jsonConverterString,
    required this.clientTypeString,
    required this.firestoreTypeString,
  });

  ///
  final String jsonConverterString;

  ///
  final String clientTypeString;

  ///
  final String firestoreTypeString;
}

///
class JsonPostProcessorConfig {
  ///
  const JsonPostProcessorConfig({
    required this.jsonPostProcessorString,
    required this.clientTypeString,
    required this.firestoreTypeString,
  });

  ///
  final String jsonPostProcessorString;

  ///
  final String clientTypeString;

  ///
  final String firestoreTypeString;
}

///
class FirestoreDocumentConfig {
  ///
  FirestoreDocumentConfig({
    required this.includeDocumentReferenceField,
    required this.generateCopyWith,
    required this.path,
    required this.baseClassName,
    required this.documentName,
  }) : firestorePathSegments = parseFirestorePath(path);

  ///
  final bool includeDocumentReferenceField;

  ///
  final bool generateCopyWith;

  ///
  final String path;

  ///
  final List<FirestorePathSegment> firestorePathSegments;

  ///
  final String baseClassName;

  ///
  String get collectionName => firestorePathSegments.last.collectionName;

  ///
  final String documentName;

  ///
  String get capitalizedCollectionName => collectionName.capitalize();

  ///
  String get capitalizedDocumentName => documentName.capitalize();

  ///
  String get readClassName => 'Read$baseClassName';

  ///
  String get createClassName => 'Create$baseClassName';

  ///
  String get updateClassName => 'Update$baseClassName';

  ///
  String get deleteClassName => 'Delete$baseClassName';

  ///
  String get createClassInstanceName => 'create$baseClassName';

  ///
  String get updateClassInstanceName => 'update$baseClassName';

  ///
  String get deleteClassInstanceName => 'delete$baseClassName';

  ///
  String get documentIdFieldName => '${documentName}Id';

  ///
  String get documentPathFieldName => 'path';

  ///
  String get documentReferenceFieldName => '${documentName}Reference';

  ///
  String get readCollectionReferenceName =>
      'read${baseClassName}CollectionReference';

  ///
  String get readDocumentReferenceName =>
      'read${baseClassName}DocumentReference';

  ///
  String get createCollectionReferenceName =>
      'create${baseClassName}CollectionReference';

  ///
  String collectionReferenceName(ReferenceClassType referenceClassType) =>
      '${referenceClassType.name}${baseClassName}CollectionReference';

  ///
  String get createDocumentReferenceName =>
      'create${baseClassName}DocumentReference';

  ///
  String get updateCollectionReferenceName =>
      'update${baseClassName}CollectionReference';

  ///
  String get updateDocumentReferenceName =>
      'update${baseClassName}DocumentReference';

  ///
  String get deleteCollectionReferenceName =>
      'delete${baseClassName}CollectionReference';

  ///
  String get deleteDocumentReferenceName =>
      'delete${baseClassName}DocumentReference';
}

///
enum ReferenceClassType {
  ///
  read,

  ///
  create,

  ///
  update,

  ///
  delete,
  ;

  ///
  String toIng() {
    switch (this) {
      case ReferenceClassType.read:
        return 'reading';
      case ReferenceClassType.create:
        return 'creating';
      case ReferenceClassType.update:
        return 'updating';
      case ReferenceClassType.delete:
        return 'deleting';
    }
  }
}

/// A class to represent a segment of a Firestore path.
///
/// Each segment in a Firestore path is composed of a collection name
/// and potentially a document name, with the path segments alternating
/// between collections and documents. For example, in the path
/// 'appUsers/{appUserId}/appUserPosts/{appUserPostId}/appUserPostLikes',
/// 'appUsers', 'appUserPosts', and 'appUserPostLikes' are collection names
/// and '{appUserId}' and '{appUserPostId}' are document names.
class FirestorePathSegment {
  /// Creates a Firestore path segment.
  ///
  /// [collectionName] and [documentName] represent the names of
  /// the collection and document respectively in a segment of a Firestore path.
  /// [collectionName] is required, while [documentName] is optional since
  /// a Firestore path can end with a collection.
  ///
  /// For example, in the path 'appUsers/{appUserId}/appUserPosts',
  /// 'appUsers' is a collection name and '{appUserId}' is a document name,
  /// while 'appUserPosts' is another collection name without a following
  /// document name.
  const FirestorePathSegment({
    required this.collectionName,
    required this.documentName,
  });

  /// The name of the collection in this segment of a Firestore path.
  final String collectionName;

  /// The name of the document in this segment of a Firestore path, if one
  /// exists.
  final String? documentName;
}

/// Parses a Firestore path into a list of Firestore path segments.
///
/// This function accepts a Firestore path as a string, and returns a list of
/// [FirestorePathSegment] objects. Each segment in the Firestore path is
/// composed of a collection name and potentially a document name, with the path
/// segments alternating between collections and documents.
///
/// For example, given the path 'appUsers/{appUserId}/appUserPosts/{appUserPostId}/appUserPostLikes',
/// this function will return a list containing three [FirestorePathSegment]
/// objects:
/// 1. FirestorePathSegment with collectionName 'appUsers' and documentName
/// '{appUserId}'
/// 2. FirestorePathSegment with collectionName 'appUserPosts' and documentName
/// '{appUserPostId}'
/// 3. FirestorePathSegment with collectionName 'appUserPostLikes' and no
/// documentName
///
/// Throws an [ArgumentError] if the provided path does not adhere to the
/// alternating collection/document structure or if the path includes an
/// additional segment that doesn't start with '/' and doesn't have a following
/// collection name.
///
/// @param path The Firestore path string to parse.
/// @returns A list of [FirestorePathSegment] objects representing the parsed
/// path.
List<FirestorePathSegment> parseFirestorePath(String path) {
  final pattern = RegExp(r'(\w+)(\/\{(\w+)\})?');
  final matches = pattern.allMatches(path);

  // TODO: 上記の正規表現にあてはまらない入力のときに適切にエラーをスローする
  // TODO: このくらいのチェックで良いのか悩む...
  // if (matches.length.isEven) {
  //   throw ArgumentError('Invalid Firestore path: $path');
  // }

  // TODO: データの持ち方は本当にこれで良いか検討する
  // TODO: CollectionDocumentName 型 or FirestorePath 型に toString は不要か考える
  final firestorePath = matches.map((match) {
    final collectionName = match.group(1)!;
    final documentName = match.group(3);
    return FirestorePathSegment(
      collectionName: collectionName,
      documentName: documentName,
    );
  }).toList();
  return firestorePath;
}
