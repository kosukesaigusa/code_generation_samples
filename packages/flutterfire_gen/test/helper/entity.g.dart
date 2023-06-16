// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lines_longer_than_80_chars, text_direction_code_point_in_literal

part of 'entity.dart';

// **************************************************************************
// Generator: FlutterFireGen
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

class ReadEntity {
  const ReadEntity({
    required this.name,
    required this.nullableText,
    required this.age,
    required this.isAdult,
    required this.map,
    required this.texts,
    required this.nullableTexts,
    required this.geoPoint,
    required this.foo,
  });

  final String name;
  final String? nullableText;
  final int age;
  final bool isAdult;
  final Map<String, dynamic> map;
  final List<String> texts;
  final List<String>? nullableTexts;
  final GeoPoint geoPoint;
  final Foo foo;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'nullableText': nullableText,
      'age': age,
      'isAdult': isAdult,
      'map': map,
      'texts': texts,
      'nullableTexts': nullableTexts,
      'geoPoint': geoPoint,
      'foo': foo,
    };
  }

  factory ReadEntity.fromJson(Map<String, dynamic> json) {
    return ReadEntity(
      name: json['name'] as String,
      nullableText: json['nullableText'] as String?,
      age: json['age'] as int,
      isAdult: json['isAdult'] as bool,
      map: json['map'] as Map<String, dynamic>,
      texts: (json['texts'] as List<dynamic>).map((e) => e as String).toList(),
      nullableTexts: (json['nullableTexts'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      geoPoint: json['geoPoint'] as GeoPoint,
      foo: json['foo'] as Foo,
    );
  }

  factory ReadEntity.fromDocumentSnapshot(DocumentSnapshot ds) {
    final data = ds.data()! as Map<String, dynamic>;
    return ReadEntity.fromJson(<String, dynamic>{
      ...data,
      'entityId': ds.id,
    });
  }

  ReadEntity copyWith({
    String? name,
    String? nullableText,
    int? age,
    bool? isAdult,
    Map<String, dynamic>? map,
    List<String>? texts,
    List<String>? nullableTexts,
    GeoPoint? geoPoint,
    Foo? foo,
  }) {
    return ReadEntity(
      name: name ?? this.name,
      nullableText: nullableText ?? this.nullableText,
      age: age ?? this.age,
      isAdult: isAdult ?? this.isAdult,
      map: map ?? this.map,
      texts: texts ?? this.texts,
      nullableTexts: nullableTexts ?? this.nullableTexts,
      geoPoint: geoPoint ?? this.geoPoint,
      foo: foo ?? this.foo,
    );
  }
}

/// A [CollectionReference] to entities collection to read.
final readEntityCollectionReference =
    FakeFirebaseFirestore().collection('entities').withConverter(
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
