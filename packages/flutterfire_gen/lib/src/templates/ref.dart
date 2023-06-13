import '../firestore_document_visitor.dart';
import '../utils/string.dart';

///
void writeReadRefs({
  required StringBuffer buffer,
  required String readClassName,
  required String collectionName,
  required String documentName,
  required FirestoreDocumentVisitor visitor,
  required Map<String, dynamic> fields,
}) {
  buffer.writeln(
    '/// A [CollectionReference] to $collectionName collection to read.',
  );
  buffer.writeln('final read${collectionName.capitalize()}Ref = ');
  buffer.writeln(
    "FirebaseFirestore.instance.collection('$collectionName').withConverter(",
  );
  buffer.writeln(
    'fromFirestore: (ds, _) => ReadEntity.fromDocumentSnapshot(ds),',
  );
  buffer.writeln('toFirestore: (obj, _) => obj.toJson(),');
  buffer.writeln(');');
  buffer.writeln();
  buffer
      .writeln('/// A [DocumentReference] to $documentName document to read.');
  buffer.writeln(
    'DocumentReference<$readClassName> '
    'read${documentName.capitalize()}Ref'
    '({required String ${documentName}Id}) =>',
  );
  buffer
      .writeln('read${collectionName.capitalize()}Ref.doc(${documentName}Id);');
}
