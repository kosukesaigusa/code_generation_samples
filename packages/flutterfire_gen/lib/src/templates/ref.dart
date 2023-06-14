import '../flutterfire_gen.dart';

///
void writeReadRefs({
  required StringBuffer buffer,
  required FirestoreDocumentConfig config,
}) {
  buffer
    ..writeln(
      '/// A [CollectionReference] to ${config.collectionName} collection to read.',
    )
    ..writeln('final '
        'read${config.baseClassName}CollectionReference = ')
    ..writeln(
      'FirebaseFirestore.instance'
      ".collection('${config.collectionName}').withConverter(",
    )
    ..writeln(
      'fromFirestore: (ds, _) => ReadEntity.fromDocumentSnapshot(ds),',
    )
    ..writeln('toFirestore: (obj, _) => obj.toJson(),')
    ..writeln(');')
    ..writeln()
    ..writeln('/// A [DocumentReference] to '
        '${config.documentName} document to read.')
    ..writeln(
      'DocumentReference<${config.readClassName}> '
      'read${config.baseClassName}DocumentReference'
      '({required String ${config.documentName}Id,}) =>',
    )
    ..writeln(
      'read${config.baseClassName}CollectionReference'
      '.doc(${config.documentName}Id);',
    );
}
