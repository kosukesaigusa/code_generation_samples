import '../flutterfire_gen.dart';

// ignore: comment_references
/// Returns [CollectionReference] and [DocumentReference] template.
String refsTemplate({required FirestoreDocumentConfig config}) {
  return """
/// A [CollectionReference] to ${config.collectionName} collection to read.
final read${config.baseClassName}CollectionReference =
    ${config.useFakeFirebaseFirestore ? "fakeDb.collection('${config.collectionName}').withConverter(" : "FirebaseFirestore.instance.collection('${config.collectionName}').withConverter("} 
          fromFirestore: (ds, _) => ${config.readClassName}.fromDocumentSnapshot(ds),
          toFirestore: (obj, _) => obj.toJson(),
        );

/// A [DocumentReference] to ${config.documentName} document to read.
DocumentReference<${config.readClassName}> read${config.baseClassName}DocumentReference({
  required String ${config.documentName}Id,
}) =>
    read${config.baseClassName}CollectionReference.doc(${config.documentName}Id);
""";
}
