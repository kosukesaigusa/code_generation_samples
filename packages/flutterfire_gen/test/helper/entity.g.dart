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
    required this.nullableInteger,
    required this.doubleNumber,
    required this.nullableDoubleNumber,
    required this.isBool,
    required this.nullableIsBool,
    required this.texts,
    required this.nullableTexts,
    required this.map,
    required this.nullableMap,
    required this.stringMap,
    required this.nullableStringMap,
    required this.nestedMap,
    required this.nullableNestedMap,
    required this.listMap,
    required this.nullableListMap,
    required this.mapList,
    required this.nullableMapList,
    required this.geoPoint,
    required this.nullableGeoPoint,
    required this.dateTime,
    required this.nullableDateTime,
    required this.timestamp,
    required this.nullableTimestamp,
    required this.documentReference,
    required this.nullableDocumentReference,
    required this.createdAt,
    required this.updatedAt,
    required this.nullableIntegerWithJsonConverter,
  });

  final String text;
  final String? nullableText;
  final int integer;
  final int? nullableInteger;
  final double doubleNumber;
  final double? nullableDoubleNumber;
  final bool isBool;
  final bool? nullableIsBool;
  final List<String> texts;
  final List<String>? nullableTexts;
  final Map<String, dynamic> map;
  final Map<String, dynamic>? nullableMap;
  final Map<String, String> stringMap;
  final Map<String, String>? nullableStringMap;
  final Map<String, Map<String, int>> nestedMap;
  final Map<String, Map<String, int>>? nullableNestedMap;
  final Map<String, List<int>> listMap;
  final Map<String, List<int>>? nullableListMap;
  final List<Map<String, int>> mapList;
  final List<Map<String, int>>? nullableMapList;
  final GeoPoint geoPoint;
  final GeoPoint? nullableGeoPoint;
  final DateTime dateTime;
  final DateTime? nullableDateTime;
  final Timestamp timestamp;
  final Timestamp? nullableTimestamp;
  final DocumentReference<Object?> documentReference;
  final DocumentReference<Object?>? nullableDocumentReference;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? nullableIntegerWithJsonConverter;

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'nullableText': nullableText,
      'integer': integer,
      'nullableInteger': nullableInteger,
      'doubleNumber': doubleNumber,
      'nullableDoubleNumber': nullableDoubleNumber,
      'isBool': isBool,
      'nullableIsBool': nullableIsBool,
      'texts': texts,
      'nullableTexts': nullableTexts,
      'map': map,
      'nullableMap': nullableMap,
      'stringMap': stringMap,
      'nullableStringMap': nullableStringMap,
      'nestedMap': nestedMap,
      'nullableNestedMap': nullableNestedMap,
      'listMap': listMap,
      'nullableListMap': nullableListMap,
      'mapList': mapList,
      'nullableMapList': nullableMapList,
      'geoPoint': geoPoint,
      'nullableGeoPoint': nullableGeoPoint,
      'dateTime': dateTime,
      'nullableDateTime': nullableDateTime,
      'timestamp': timestamp,
      'nullableTimestamp': nullableTimestamp,
      'documentReference': documentReference,
      'nullableDocumentReference': nullableDocumentReference,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'nullableIntegerWithJsonConverter': nullableIntegerWithJsonConverter,
    };
  }

  factory ReadEntity.fromJson(Map<String, dynamic> json) {
    return ReadEntity(
        text: json['text'] as String,
        nullableText: json['nullableText'] as String? ?? 'defaultText',
        integer: json['integer'] as int,
        nullableInteger: json['nullableInteger'] as int? ?? 0,
        doubleNumber: json['doubleNumber'] as double,
        nullableDoubleNumber: json['nullableDoubleNumber'] as double? ?? 0.0,
        isBool: json['isBool'] as bool,
        nullableIsBool: json['nullableIsBool'] as bool?,
        texts:
            (json['texts'] as List<dynamic>).map((e) => e as String).toList(),
        nullableTexts: (json['nullableTexts'] as List<dynamic>?)?.map((e) => e as String).toList() ??
            const <String>[],
        map: json['map'] as Map<String, dynamic>,
        nullableMap: json['nullableMap'] as Map<String, dynamic>? ??
            const <String, dynamic>{},
        stringMap: (json['stringMap'] as Map<String, dynamic>)
            .map((k, v) => MapEntry(k, v as String)),
        nullableStringMap: (json['nullableStringMap'] as Map<String, dynamic>?)
                ?.map((k, v) => MapEntry(k, v as String)) ??
            const <String, String>{},
        nestedMap: (json['nestedMap'] as Map<String, dynamic>).map((k, v) => MapEntry(
            k,
            (v as Map<String, dynamic>).map((k, v) => MapEntry(k, v as int)))),
        nullableNestedMap: (json['nullableNestedMap'] as Map<String, dynamic>?)
                ?.map((k, v) => MapEntry(k, (v as Map<String, dynamic>).map((k, v) => MapEntry(k, v as int)))) ??
            const <String, Map<String, int>>{},
        listMap: (json['listMap'] as Map<String, dynamic>).map((k, v) => MapEntry(k, (v as List<dynamic>).map((e) => e as int).toList())),
        nullableListMap: (json['nullableListMap'] as Map<String, dynamic>?)?.map((k, v) => MapEntry(k, (v as List<dynamic>).map((e) => e as int).toList())) ?? const <String, List<int>>{},
        mapList: (json['mapList'] as List<dynamic>).map((e) => (e as Map<String, dynamic>).map((k, v) => MapEntry(k, v as int))).toList(),
        nullableMapList: (json['nullableMapList'] as List<dynamic>?)?.map((e) => (e as Map<String, dynamic>).map((k, v) => MapEntry(k, v as int))).toList() ?? const <Map<String, int>>[],
        geoPoint: json['geoPoint'] as GeoPoint,
        nullableGeoPoint: json['nullableGeoPoint'] as GeoPoint? ?? const GeoPoint(0, 0),
        dateTime: (json['dateTime'] as Timestamp).toDate(),
        nullableDateTime: (json['nullableDateTime'] as Timestamp?)?.toDate(),
        timestamp: json['timestamp'] as Timestamp,
        nullableTimestamp: json['nullableTimestamp'] as Timestamp?,
        documentReference: json['documentReference'] as DocumentReference<Object?>,
        nullableDocumentReference: json['nullableDocumentReference'] as DocumentReference<Object?>?,
        createdAt: _TimestampConverter().fromJson(json['createdAt'] as Object),
        updatedAt: useServerTimestampSealedTimestampConverter.fromJson(json['updatedAt'] as Object),
        nullableIntegerWithJsonConverter: _NullableIntegerJsonConverter().fromJson(json['nullableIntegerWithJsonConverter'] as int?));
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
    int? nullableInteger,
    double? doubleNumber,
    double? nullableDoubleNumber,
    bool? isBool,
    bool? nullableIsBool,
    List<String>? texts,
    List<String>? nullableTexts,
    Map<String, dynamic>? map,
    Map<String, dynamic>? nullableMap,
    Map<String, String>? stringMap,
    Map<String, String>? nullableStringMap,
    Map<String, Map<String, int>>? nestedMap,
    Map<String, Map<String, int>>? nullableNestedMap,
    Map<String, List<int>>? listMap,
    Map<String, List<int>>? nullableListMap,
    List<Map<String, int>>? mapList,
    List<Map<String, int>>? nullableMapList,
    GeoPoint? geoPoint,
    GeoPoint? nullableGeoPoint,
    DateTime? dateTime,
    DateTime? nullableDateTime,
    Timestamp? timestamp,
    Timestamp? nullableTimestamp,
    DocumentReference<Object?>? documentReference,
    DocumentReference<Object?>? nullableDocumentReference,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? nullableIntegerWithJsonConverter,
  }) {
    return ReadEntity(
      text: text ?? this.text,
      nullableText: nullableText ?? this.nullableText,
      integer: integer ?? this.integer,
      nullableInteger: nullableInteger ?? this.nullableInteger,
      doubleNumber: doubleNumber ?? this.doubleNumber,
      nullableDoubleNumber: nullableDoubleNumber ?? this.nullableDoubleNumber,
      isBool: isBool ?? this.isBool,
      nullableIsBool: nullableIsBool ?? this.nullableIsBool,
      texts: texts ?? this.texts,
      nullableTexts: nullableTexts ?? this.nullableTexts,
      map: map ?? this.map,
      nullableMap: nullableMap ?? this.nullableMap,
      stringMap: stringMap ?? this.stringMap,
      nullableStringMap: nullableStringMap ?? this.nullableStringMap,
      nestedMap: nestedMap ?? this.nestedMap,
      nullableNestedMap: nullableNestedMap ?? this.nullableNestedMap,
      listMap: listMap ?? this.listMap,
      nullableListMap: nullableListMap ?? this.nullableListMap,
      mapList: mapList ?? this.mapList,
      nullableMapList: nullableMapList ?? this.nullableMapList,
      geoPoint: geoPoint ?? this.geoPoint,
      nullableGeoPoint: nullableGeoPoint ?? this.nullableGeoPoint,
      dateTime: dateTime ?? this.dateTime,
      nullableDateTime: nullableDateTime ?? this.nullableDateTime,
      timestamp: timestamp ?? this.timestamp,
      nullableTimestamp: nullableTimestamp ?? this.nullableTimestamp,
      documentReference: documentReference ?? this.documentReference,
      nullableDocumentReference:
          nullableDocumentReference ?? this.nullableDocumentReference,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      nullableIntegerWithJsonConverter: nullableIntegerWithJsonConverter ??
          this.nullableIntegerWithJsonConverter,
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
