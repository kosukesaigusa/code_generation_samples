// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lines_longer_than_80_chars, text_direction_code_point_in_literal

part of 'entity.dart';

// **************************************************************************
// Generator: FlutterFireGen
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

final fakeDb = FakeFirebaseFirestore();

class ReadEntity {
  const ReadEntity({
    required this.text,
    required this.nullableText,
    required this.integer,
    required this.isBool,
    required this.isNullableBool,
    required this.texts,
    required this.nullableTexts,
    required this.geoPoint,
  });

  final String text;
  final String? nullableText;
  final int integer;
  final bool isBool;
  final bool? isNullableBool;
  final List<String> texts;
  final List<String>? nullableTexts;
  final GeoPoint geoPoint;

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'nullableText': nullableText,
      'integer': integer,
      'isBool': isBool,
      'isNullableBool': isNullableBool,
      'texts': texts,
      'nullableTexts': nullableTexts,
      'geoPoint': geoPoint,
    };
  }

  factory ReadEntity.fromJson(Map<String, dynamic> json) {
    return ReadEntity(
        text: json['text'] as String,
        nullableText: json['nullableText'] as String? ?? 'defaultText',
        integer: json['integer'] as int,
        isBool: json['isBool'] as bool,
        isNullableBool: json['isNullableBool'] as bool? ?? false,
        texts:
            (json['texts'] as List<dynamic>).map((e) => e as String).toList(),
        nullableTexts: (json['nullableTexts'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            const <String>[],
        geoPoint: json['geoPoint'] as GeoPoint);
  }

  factory ReadEntity.fromDocumentSnapshot(DocumentSnapshot ds) {
    final data = ds.data()! as Map<String, dynamic>;
    return ReadEntity.fromJson(<String, dynamic>{
      ...data,
      'entityId': ds.id,
    });
  }

  ReadEntity copyWith({
    String? text,
    String? nullableText,
    int? integer,
    bool? isBool,
    bool? isNullableBool,
    List<String>? texts,
    List<String>? nullableTexts,
    GeoPoint? geoPoint,
  }) {
    return ReadEntity(
      text: text ?? this.text,
      nullableText: nullableText ?? this.nullableText,
      integer: integer ?? this.integer,
      isBool: isBool ?? this.isBool,
      isNullableBool: isNullableBool ?? this.isNullableBool,
      texts: texts ?? this.texts,
      nullableTexts: nullableTexts ?? this.nullableTexts,
      geoPoint: geoPoint ?? this.geoPoint,
    );
  }
}

/// A [CollectionReference] to entities collection to read.
final readEntityCollectionReference =
    fakeDb.collection('entities').withConverter(
          fromFirestore: (ds, _) => ReadEntity.fromDocumentSnapshot(ds),
          toFirestore: (obj, _) => obj.toJson(),
        );

/// A [DocumentReference] to entity document to read.
DocumentReference<ReadEntity> readEntityDocumentReference({
  required String entityId,
}) =>
    readEntityCollectionReference.doc(entityId);

/// A query manager to execute query against [Entity].
class EntityQuery {
  /// Fetches [ReadEntity] documents.
  Future<List<ReadEntity>> fetchDocuments({
    GetOptions? options,
    Query<ReadEntity>? Function(Query<ReadEntity> query)? queryBuilder,
    int Function(ReadEntity lhs, ReadEntity rhs)? compare,
  }) async {
    Query<ReadEntity> query = readEntityCollectionReference;
    if (queryBuilder != null) {
      query = queryBuilder(query)!;
    }
    final qs = await query.get(options);
    final result = qs.docs.map((qds) => qds.data()).toList();
    if (compare != null) {
      result.sort(compare);
    }
    return result;
  }

  /// Subscribes [Entity] documents.
  Stream<List<ReadEntity>> subscribeDocuments({
    Query<ReadEntity>? Function(Query<ReadEntity> query)? queryBuilder,
    int Function(ReadEntity lhs, ReadEntity rhs)? compare,
    bool includeMetadataChanges = false,
    bool excludePendingWrites = false,
  }) {
    Query<ReadEntity> query = readEntityCollectionReference;
    if (queryBuilder != null) {
      query = queryBuilder(query)!;
    }
    var streamQs =
        query.snapshots(includeMetadataChanges: includeMetadataChanges);
    if (excludePendingWrites) {
      streamQs = streamQs.where((qs) => !qs.metadata.hasPendingWrites);
    }
    return streamQs.map((qs) {
      final result = qs.docs.map((qds) => qds.data()).toList();
      if (compare != null) {
        result.sort(compare);
      }
      return result;
    });
  }

  /// Fetches [ReadEntity] document.
  Future<ReadEntity?> fetchDocument({
    required String entityId,
    GetOptions? options,
  }) async {
    final ds =
        await readEntityDocumentReference(entityId: entityId).get(options);
    return ds.data();
  }

  /// Subscribes [Entity] document.
  Future<Stream<ReadEntity?>> subscribeDocument({
    required String entityId,
    bool includeMetadataChanges = false,
    bool excludePendingWrites = false,
  }) async {
    var streamDs = readEntityDocumentReference(entityId: entityId)
        .snapshots(includeMetadataChanges: includeMetadataChanges);
    if (excludePendingWrites) {
      streamDs = streamDs.where((ds) => !ds.metadata.hasPendingWrites);
    }
    return streamDs.map((ds) => ds.data());
  }
}
