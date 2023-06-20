import 'utils/string.dart';

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
class FirestoreDocumentConfig {
  ///
  FirestoreDocumentConfig({
    required this.useFakeFirebaseFirestore,
    required this.baseClassName,
    required this.collectionName,
    required this.documentName,
  });

  ///
  final bool useFakeFirebaseFirestore;

  ///
  final String baseClassName;

  ///
  final String collectionName;

  ///
  final String documentName;

  ///
  String get capitalizedCollectionName => collectionName.capitalize();

  ///
  String get capitalizedDocumentName => documentName.capitalize();

  ///
  String get readClassName => 'Read$baseClassName';

  ///
  String get writeClassName => 'Write$baseClassName';

  ///
  String get readCollectionReferenceName =>
      'read${baseClassName}CollectionReference';

  ///
  String get readDocumentReferenceName =>
      'read${baseClassName}DocumentReference';
}
