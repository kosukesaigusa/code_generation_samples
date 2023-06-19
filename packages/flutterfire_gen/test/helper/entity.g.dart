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
    required this.nullableIsBool,
    required this.map,
    required this.nullableMap,
    required this.nestedMap,
    required this.nullableNestedMa,
    required this.listMap,
    required this.nullableListMap,
    required this.mapList,
    required this.nullableMapList,
    required this.nullableGeoPoint,
    required this.stringMap,
    required this.nullableStringMap,
    required this.nullableNestedMap,
  });

  final String text;
  final String? nullableText;
  final int integer;
  final bool isBool;
  final bool? isNullableBool;
  final List<String> texts;
  final List<String>? nullableTexts;
  final GeoPoint geoPoint;
  final bool? nullableIsBool;
  final Map<String, dynamic> map;
  final Map<String, dynamic>? nullableMap;
  final Map<String, Map<String, int>> nestedMap;
  final Map<String, Map<String, int>>? nullableNestedMa;
  final Map<String, List<int>> listMap;
  final Map<String, List<int>>? nullableListMap;
  final List<Map<String, int>> mapList;
  final List<Map<String, int>>? nullableMapList;
  final GeoPoint? nullableGeoPoint;
  final Map<String, String> stringMap;
  final Map<String, String>? nullableStringMap;
  final Map<String, Map<String, int>>? nullableNestedMap;

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
      'nullableIsBool': nullableIsBool,
      'map': map,
      'nullableMap': nullableMap,
      'nestedMap': nestedMap,
      'nullableNestedMa': nullableNestedMa,
      'listMap': listMap,
      'nullableListMap': nullableListMap,
      'mapList': mapList,
      'nullableMapList': nullableMapList,
      'nullableGeoPoint': nullableGeoPoint,
      'stringMap': stringMap,
      'nullableStringMap': nullableStringMap,
      'nullableNestedMap': nullableNestedMap,
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
        geoPoint: json['geoPoint'] as GeoPoint,
        nullableIsBool: json['nullableIsBool'] as bool?,
        map: json['map'] as Map<String, dynamic>,
        nullableMap: json['nullableMap'] as Map<String, dynamic>? ??
            const <String, dynamic>{},
        nestedMap: (json['nestedMap'] as Map<String, dynamic>).map((k, v) => MapEntry(
            k,
            (v as Map<String, dynamic>).map((k, v) => MapEntry(k, v as int)))),
        nullableNestedMa:
            (json['nullableNestedMa'] as Map<String, dynamic>?)?.map((k, v) => MapEntry(k, (v as Map<String, dynamic>).map((k, v) => MapEntry(k, v as int)))) ??
                const <String, Map<String, int>>{},
        listMap: (json['listMap'] as Map<String, dynamic>).map((k, v) =>
            MapEntry(k, (v as List<dynamic>).map((e) => e as int).toList())),
        nullableListMap: (json['nullableListMap'] as Map<String, dynamic>?)
                ?.map((k, v) => MapEntry(k, (v as List<dynamic>).map((e) => e as int).toList())) ??
            const <String, List<int>>{},
        mapList: (json['mapList'] as List<dynamic>).map((e) => (e as Map<String, dynamic>).map((k, v) => MapEntry(k, v as int))).toList(),
        nullableMapList: (json['nullableMapList'] as List<dynamic>?)?.map((e) => (e as Map<String, dynamic>).map((k, v) => MapEntry(k, v as int))).toList() ?? const <Map<String, int>>[],
        nullableGeoPoint: json['nullableGeoPoint'] as GeoPoint? ?? const GeoPoint(0, 0),
        stringMap: (json['stringMap'] as Map<String, dynamic>).map((k, v) => MapEntry(k, v as String)),
        nullableStringMap: (json['nullableStringMap'] as Map<String, dynamic>?)?.map((k, v) => MapEntry(k, v as String)) ?? const <String, String>{},
        nullableNestedMap: (json['nullableNestedMap'] as Map<String, dynamic>?)?.map((k, v) => MapEntry(k, (v as Map<String, dynamic>).map((k, v) => MapEntry(k, v as int)))) ?? const <String, Map<String, int>>{});
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
    bool? nullableIsBool,
    Map<String, dynamic>? map,
    Map<String, dynamic>? nullableMap,
    Map<String, Map<String, int>>? nestedMap,
    Map<String, Map<String, int>>? nullableNestedMa,
    Map<String, List<int>>? listMap,
    Map<String, List<int>>? nullableListMap,
    List<Map<String, int>>? mapList,
    List<Map<String, int>>? nullableMapList,
    GeoPoint? nullableGeoPoint,
    Map<String, String>? stringMap,
    Map<String, String>? nullableStringMap,
    Map<String, Map<String, int>>? nullableNestedMap,
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
      nullableIsBool: nullableIsBool ?? this.nullableIsBool,
      map: map ?? this.map,
      nullableMap: nullableMap ?? this.nullableMap,
      nestedMap: nestedMap ?? this.nestedMap,
      nullableNestedMa: nullableNestedMa ?? this.nullableNestedMa,
      listMap: listMap ?? this.listMap,
      nullableListMap: nullableListMap ?? this.nullableListMap,
      mapList: mapList ?? this.mapList,
      nullableMapList: nullableMapList ?? this.nullableMapList,
      nullableGeoPoint: nullableGeoPoint ?? this.nullableGeoPoint,
      stringMap: stringMap ?? this.stringMap,
      nullableStringMap: nullableStringMap ?? this.nullableStringMap,
      nullableNestedMap: nullableNestedMap ?? this.nullableNestedMap,
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
