import 'flutterfire_gen.dart';
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
    required this.includeDocumentReferenceField,
    required this.generateCopyWith,
    required this.path,
    required this.baseClassName,
    required this.documentName,
  }) : firestorePathSegments = parseFirestorePath(path);

  ///
  final bool useFakeFirebaseFirestore;

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
}
