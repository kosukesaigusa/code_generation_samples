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
    required this.isSomething,
    required this.nullableBool,
    required this.texts,
    required this.nullableTexts,
    required this.twoDList,
    required this.threeDList,
    required this.nullableTwoDList,
    required this.geoPoint,
  });

  final String name;
  final String? nullableText;
  final int age;
  final bool isSomething;
  final bool? nullableBool;
  final List<String> texts;
  final List<String>? nullableTexts;
  final List<List<String>> twoDList;
  final List<List<List<String>>> threeDList;
  final List<List<String>>? nullableTwoDList;
  final GeoPoint geoPoint;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'nullableText': nullableText,
      'age': age,
      'isSomething': isSomething,
      'nullableBool': nullableBool,
      'texts': texts,
      'nullableTexts': nullableTexts,
      'twoDList': twoDList,
      'threeDList': threeDList,
      'nullableTwoDList': nullableTwoDList,
      'geoPoint': geoPoint,
    };
  }

  factory ReadEntity.fromJson(Map<String, dynamic> json) {
    return ReadEntity(
      name: json['name'] as String,
      nullableText: json['nullableText'] as String? ?? 'defaultText',
      age: json['age'] as int,
      isSomething: json['isSomething'] as bool,
      nullableBool: json['nullableBool'] as bool? ?? false,
      texts: (json['texts'] as List<dynamic>)
          .map((e) => json['texts'] as String)
          .toList(),
      nullableTexts: json['nullableTexts'] as List<String>? ?? const <String>[],
      twoDList: (json['twoDList'] as List<dynamic>)
          .map((e) => (json['twoDList'] as List<dynamic>)
              .map((e) => json['twoDList'] as String)
              .toList())
          .toList(),
      threeDList: (json['threeDList'] as List<dynamic>)
          .map((e) => (json['threeDList'] as List<dynamic>)
              .map((e) => (json['threeDList'] as List<dynamic>)
                  .map((e) => json['threeDList'] as String)
                  .toList())
              .toList())
          .toList(),
      nullableTwoDList:
          json['nullableTwoDList'] as List<List<String>>? ?? const <String>[],
      geoPoint: json['geoPoint'] as GeoPoint,
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
    bool? isSomething,
    bool? nullableBool,
    List<String>? texts,
    List<String>? nullableTexts,
    List<List<String>>? twoDList,
    List<List<List<String>>>? threeDList,
    List<List<String>>? nullableTwoDList,
    GeoPoint? geoPoint,
  }) {
    return ReadEntity(
      name: name ?? this.name,
      nullableText: nullableText ?? this.nullableText,
      age: age ?? this.age,
      isSomething: isSomething ?? this.isSomething,
      nullableBool: nullableBool ?? this.nullableBool,
      texts: texts ?? this.texts,
      nullableTexts: nullableTexts ?? this.nullableTexts,
      twoDList: twoDList ?? this.twoDList,
      threeDList: threeDList ?? this.threeDList,
      nullableTwoDList: nullableTwoDList ?? this.nullableTwoDList,
      geoPoint: geoPoint ?? this.geoPoint,
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
