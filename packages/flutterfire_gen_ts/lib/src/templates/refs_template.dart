// ignore_for_file: comment_references, lines_longer_than_80_chars

import '../config.dart';

/// Returns [CollectionReference] and [DocumentReference] template.
class RefsTemplate {
  /// Creates a [RefsTemplate].
  const RefsTemplate({required this.config});

  ///
  final FirestoreDocumentConfig config;

  @override
  String toString() {
    final buffer = StringBuffer();
    for (final referenceClassType in ReferenceClassType.values) {
      buffer
        ..writeln(_collectionReferenceTemplate(referenceClassType))
        ..writeln()
        ..writeln(_documentReferenceTemplate(referenceClassType));
    }
    return buffer.toString();
  }

  String _collectionReferenceTemplate(ReferenceClassType referenceClassType) {
    // TODO: ネストしている場合に対応する
    final buffer = StringBuffer()
      ..write('''
/**
 * Provides a reference to the ${config.collectionName} collection for ${referenceClassType.toIng()}.
 */
''')
      ..writeln(_collectionReference(referenceClassType));
    if (config.firestorePathSegments.length == 1) {
      buffer.writeln('db');
    } else {
      buffer.writeln('=> { return db');
    }
    for (final segment in config.firestorePathSegments) {
      final collectionName = segment.collectionName;
      final documentName = segment.documentName;
      buffer.write(".collection('$collectionName')");
      if (documentName != null) {
        buffer.write('.doc($documentName)');
      }
    }
    buffer.write(_withConverterString(referenceClassType));
    if (config.firestorePathSegments.length == 1) {
    } else {
      buffer.write('}');
    }
    return buffer.toString();
  }

  String _documentReferenceTemplate(ReferenceClassType referenceClassType) {
    // TODO: ネストしている場合に対応する
    final buffer = StringBuffer()
      ..write('''
/**
 * Provides a reference to a ${config.documentName} document for ${referenceClassType.toIng()}.
 * @param ${config.documentIdFieldName} - The ID of the ${config.documentName} document to read.
 */
''')
      ..writeln(_documentReference(referenceClassType));
    return buffer.toString();
  }

  String _collectionReference(ReferenceClassType referenceClassType) {
    if (config.firestorePathSegments.isEmpty) {
      // TODO: 適切にエラーをハンドリングする
      throw Error();
    }
    if (config.firestorePathSegments.length == 1) {
      return 'export const ${_collectionReferenceName(referenceClassType)} = ';
    }
    return '''
export const ${_collectionReferenceName(referenceClassType)} = (
  ${_documentIdParameters()}
): ${_collectionReferenceTypeAnnotation(referenceClassType)}
''';
  }

  String _documentReference(ReferenceClassType referenceClassType) {
    if (config.firestorePathSegments.isEmpty) {
      // TODO: 適切にエラーをハンドリングする
      throw Error();
    }
    if (config.firestorePathSegments.length == 1) {
      return '''
export const ${_documentReferenceName(referenceClassType)} = ({
  ${config.documentName}Id
}: {
  ${config.documentName}Id: string
}): FirebaseFirestore.DocumentReference<${_className(referenceClassType)}> =>
    ${_collectionReferenceName(referenceClassType)}.doc(${config.documentName}Id);
''';
    }
    return '''
export const ${_documentReferenceName(referenceClassType)} = ({
  ${config.firestorePathSegments.map((segment) => segment.documentName).whereType<String>().map((documentId) => documentId).join('\n')},
  ${config.documentName}Id,
}: {
  ${config.firestorePathSegments.map((segment) => segment.documentName).whereType<String>().map((documentId) => '$documentId: string').join('\n')},
  ${config.documentName}Id: string
}): FirebaseFirestore.DocumentReference<${_className(referenceClassType)}> =>
    ${_collectionReferenceName(referenceClassType)}({
      ${config.firestorePathSegments.map((segment) => segment.documentName).whereType<String>().map((documentId) => documentId).join(',\n')}
    }).doc(${config.documentName}Id);
''';
  }

  String _documentIdParameters() {
    final documentIds = config.firestorePathSegments
        .map((segment) => segment.documentName)
        .whereType<String>()
        .toList();
    return '''
{
  ${documentIds.map((documentId) => documentId).join(',\n')}
}: {
  ${documentIds.map((documentId) => '$documentId: string').join(',\n')}
}''';
  }

  String _withConverterString(ReferenceClassType referenceClassType) {
    switch (referenceClassType) {
      case ReferenceClassType.read:
        return '''
.withConverter<${_className(referenceClassType)}>({
  fromFirestore: (ds: FirebaseFirestore.DocumentSnapshot): ${_className(referenceClassType)} => {
    return ${_className(referenceClassType)}.fromDocumentSnapshot(ds)
  },
  toFirestore: () => {
      throw new Error(`toFirestore is not implemented for ${_className(referenceClassType)}`)
  }
})
''';
      case ReferenceClassType.create:
      case ReferenceClassType.update:
        return '''
.withConverter<${_className(referenceClassType)}>({
  fromFirestore: () => {
    throw new Error(`fromFirestore is not implemented for ${_className(referenceClassType)}`)
  },
  toFirestore: (obj: ${_className(referenceClassType)}): FirebaseFirestore.DocumentData => {
      return obj.toJson()
  }
})
''';
      case ReferenceClassType.delete:
        return '''
.withConverter<${_className(referenceClassType)}>({
  fromFirestore: () => {
    throw new Error(`fromFirestore is not implemented for ${_className(referenceClassType)}`)
  },
  toFirestore: (): FirebaseFirestore.DocumentData => {
    throw new Error(`toFirestore is not implemented for ${_className(referenceClassType)}`)
  }
})
''';
    }
  }

  ///
  String _className(ReferenceClassType referenceClassType) {
    switch (referenceClassType) {
      case ReferenceClassType.read:
        return config.readClassName;
      case ReferenceClassType.create:
        return config.createClassName;
      case ReferenceClassType.update:
        return config.updateClassName;
      case ReferenceClassType.delete:
        return config.deleteClassName;
    }
  }

  ///
  String _collectionReferenceName(ReferenceClassType referenceClassType) {
    switch (referenceClassType) {
      case ReferenceClassType.read:
        return config.readCollectionReferenceName;
      case ReferenceClassType.create:
        return config.createCollectionReferenceName;
      case ReferenceClassType.update:
        return config.updateCollectionReferenceName;
      case ReferenceClassType.delete:
        return config.deleteCollectionReferenceName;
    }
  }

  ///
  String _documentReferenceName(ReferenceClassType referenceClassType) {
    switch (referenceClassType) {
      case ReferenceClassType.read:
        return config.readDocumentReferenceName;
      case ReferenceClassType.create:
        return config.createDocumentReferenceName;
      case ReferenceClassType.update:
        return config.updateDocumentReferenceName;
      case ReferenceClassType.delete:
        return config.deleteDocumentReferenceName;
    }
  }

  String _collectionReferenceTypeAnnotation(
    ReferenceClassType referenceClassType,
  ) =>
      'FirebaseFirestore.CollectionReference<${_className(referenceClassType)}>';
}
