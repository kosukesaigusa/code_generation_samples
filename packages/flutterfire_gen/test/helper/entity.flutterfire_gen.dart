// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'entity.dart';

class ReadEntity {
  const ReadEntity({
    required this.text,
    required this.textWithDefault,
    required this.nullableText,
    required this.integer,
    required this.integerWithDefault,
    required this.nullableInteger,
    required this.doubleNumber,
    required this.doubleNumberWithDefault,
    required this.nullableDoubleNumber,
    required this.isBool,
    required this.isBoolWithDefault,
    required this.nullableIsBool,
    required this.texts,
    required this.textsWithDefault,
    required this.nullableTexts,
    required this.map,
    required this.mapWithDefault,
    required this.nullableMap,
    required this.stringMap,
    required this.stringMapWithDefault,
    required this.nullableStringMap,
    required this.nestedMap,
    required this.nestedMapWithDefault,
    required this.nullableNestedMap,
    required this.listMap,
    required this.listMapWithDefault,
    required this.nullableListMap,
    required this.mapList,
    required this.mapListWithDefault,
    required this.nullableMapList,
    required this.geoPoint,
    required this.geoPointWithDefault,
    required this.nullableGeoPoint,
    required this.dateTime,
    required this.nullableDateTime,
    required this.timestamp,
    required this.nullableTimestamp,
    required this.documentReference,
    required this.nullableDocumentReference,
    required this.foo,
    required this.fooWithDefault,
    required this.nullableFoo,
    required this.nullableFooWithDefaultAnnotation,
    required this.fieldValueAllowedInt,
    required this.fieldValueAllowedNullableInt,
    required this.fieldValueAllowedNullableIntWithDefaultAnnotation,
    required this.entityId,
  });

  final String text;

  final String textWithDefault;

  final String? nullableText;

  final int integer;

  final int integerWithDefault;

  final int? nullableInteger;

  final double doubleNumber;

  final double doubleNumberWithDefault;

  final double? nullableDoubleNumber;

  final bool isBool;

  final bool isBoolWithDefault;

  final bool? nullableIsBool;

  final List<String> texts;

  final List<String> textsWithDefault;

  final List<String>? nullableTexts;

  final Map<String, dynamic> map;

  final Map<String, dynamic> mapWithDefault;

  final Map<String, dynamic>? nullableMap;

  final Map<String, String> stringMap;

  final Map<String, String> stringMapWithDefault;

  final Map<String, String>? nullableStringMap;

  final Map<String, Map<String, int>> nestedMap;

  final Map<String, Map<String, int>> nestedMapWithDefault;

  final Map<String, Map<String, int>>? nullableNestedMap;

  final Map<String, List<int>> listMap;

  final Map<String, List<int>> listMapWithDefault;

  final Map<String, List<int>>? nullableListMap;

  final List<Map<String, int>> mapList;

  final List<Map<String, int>> mapListWithDefault;

  final List<Map<String, int>>? nullableMapList;

  final GeoPoint geoPoint;

  final GeoPoint geoPointWithDefault;

  final GeoPoint? nullableGeoPoint;

  final DateTime dateTime;

  final DateTime? nullableDateTime;

  final Timestamp timestamp;

  final Timestamp? nullableTimestamp;

  final DocumentReference<Object?> documentReference;

  final DocumentReference<Object?>? nullableDocumentReference;

  final Foo foo;

  final Foo fooWithDefault;

  final Foo? nullableFoo;

  final Foo? nullableFooWithDefaultAnnotation;

  final int fieldValueAllowedInt;

  final int? fieldValueAllowedNullableInt;

  final int? fieldValueAllowedNullableIntWithDefaultAnnotation;

  final String entityId;

  factory ReadEntity._fromJson(Map<String, dynamic> json) {
    final extendedJson = <String, dynamic>{
      ...json,
    };
    return ReadEntity(
      text: extendedJson['text'] as String,
      textWithDefault:
          extendedJson['textWithDefault'] as String? ?? 'requiredWithDefault',
      nullableText: extendedJson['nullableText'] as String? ?? 'defaultText',
      integer: extendedJson['integer'] as int,
      integerWithDefault: extendedJson['integerWithDefault'] as int? ?? 0,
      nullableInteger: extendedJson['nullableInteger'] as int? ?? 0,
      doubleNumber: extendedJson['doubleNumber'] as double,
      doubleNumberWithDefault:
          extendedJson['doubleNumberWithDefault'] as double? ?? 3.14,
      nullableDoubleNumber:
          extendedJson['nullableDoubleNumber'] as double? ?? 3.14,
      isBool: extendedJson['isBool'] as bool,
      isBoolWithDefault: extendedJson['isBoolWithDefault'] as bool? ?? false,
      nullableIsBool: extendedJson['nullableIsBool'] as bool? ?? false,
      texts: (extendedJson['texts'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      textsWithDefault: (extendedJson['textsWithDefault'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>['requiredWithDefault'],
      nullableTexts: (extendedJson['nullableTexts'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      map: extendedJson['map'] as Map<String, dynamic>,
      mapWithDefault: extendedJson['mapWithDefault'] as Map<String, dynamic>? ??
          const <String, dynamic>{},
      nullableMap: extendedJson['nullableMap'] as Map<String, dynamic>? ??
          const <String, dynamic>{},
      stringMap: (extendedJson['stringMap'] as Map<String, dynamic>)
          .map((k, v) => MapEntry(k, v as String)),
      stringMapWithDefault:
          (extendedJson['stringMapWithDefault'] as Map<String, dynamic>?)
                  ?.map((k, v) => MapEntry(k, v as String)) ??
              const <String, String>{},
      nullableStringMap:
          (extendedJson['nullableStringMap'] as Map<String, dynamic>?)
                  ?.map((k, v) => MapEntry(k, v as String)) ??
              const <String, String>{},
      nestedMap: (extendedJson['nestedMap'] as Map<String, dynamic>).map(
          (k, v) => MapEntry(
              k,
              (v as Map<String, dynamic>)
                  .map((k, v) => MapEntry(k, v as int)))),
      nestedMapWithDefault:
          (extendedJson['nestedMapWithDefault'] as Map<String, dynamic>?)?.map(
                  (k, v) => MapEntry(
                      k,
                      (v as Map<String, dynamic>)
                          .map((k, v) => MapEntry(k, v as int)))) ??
              const <String, Map<String, int>>{
                'requiredWithDefault': <String, int>{}
              },
      nullableNestedMap:
          (extendedJson['nullableNestedMap'] as Map<String, dynamic>?)?.map(
                  (k, v) => MapEntry(
                      k,
                      (v as Map<String, dynamic>)
                          .map((k, v) => MapEntry(k, v as int)))) ??
              const <String, Map<String, int>>{},
      listMap: (extendedJson['listMap'] as Map<String, dynamic>).map((k, v) =>
          MapEntry(k, (v as List<dynamic>).map((e) => e as int).toList())),
      listMapWithDefault:
          (extendedJson['listMapWithDefault'] as Map<String, dynamic>?)?.map(
                  (k, v) => MapEntry(
                      k, (v as List<dynamic>).map((e) => e as int).toList())) ??
              const <String, List<int>>{'requiredWithDefault': <int>[]},
      nullableListMap:
          (extendedJson['nullableListMap'] as Map<String, dynamic>?)?.map(
                  (k, v) => MapEntry(
                      k, (v as List<dynamic>).map((e) => e as int).toList())) ??
              const <String, List<int>>{},
      mapList: (extendedJson['mapList'] as List<dynamic>)
          .map((e) =>
              (e as Map<String, dynamic>).map((k, v) => MapEntry(k, v as int)))
          .toList(),
      mapListWithDefault: (extendedJson['mapListWithDefault'] as List<dynamic>?)
              ?.map((e) => (e as Map<String, dynamic>)
                  .map((k, v) => MapEntry(k, v as int)))
              .toList() ??
          const <Map<String, int>>[
            <String, int>{'requiredWithDefault': 0}
          ],
      nullableMapList: (extendedJson['nullableMapList'] as List<dynamic>?)
              ?.map((e) => (e as Map<String, dynamic>)
                  .map((k, v) => MapEntry(k, v as int)))
              .toList() ??
          const <Map<String, int>>[],
      geoPoint: extendedJson['geoPoint'] as GeoPoint,
      geoPointWithDefault: extendedJson['geoPointWithDefault'] as GeoPoint? ??
          const GeoPoint(0, 0),
      nullableGeoPoint:
          extendedJson['nullableGeoPoint'] as GeoPoint? ?? const GeoPoint(0, 0),
      dateTime: (extendedJson['dateTime'] as Timestamp).toDate(),
      nullableDateTime:
          (extendedJson['nullableDateTime'] as Timestamp?)?.toDate(),
      timestamp: extendedJson['timestamp'] as Timestamp,
      nullableTimestamp: extendedJson['nullableTimestamp'] as Timestamp?,
      documentReference:
          extendedJson['documentReference'] as DocumentReference<Object?>,
      nullableDocumentReference: extendedJson['nullableDocumentReference']
          as DocumentReference<Object?>?,
      foo: _FooJsonConverter()
          .fromJson(extendedJson['foo'] as Map<String, dynamic>),
      fooWithDefault: extendedJson['fooWithDefault'] == null
          ? const Foo('requiredWithDefault')
          : _FooJsonConverter()
              .fromJson(extendedJson['fooWithDefault'] as Map<String, dynamic>),
      nullableFoo: _nullableFooJsonConverter
          .fromJson(extendedJson['nullableFoo'] as Map<String, dynamic>),
      nullableFooWithDefaultAnnotation: _FooJsonConverter().fromJson(
          extendedJson['nullableFooWithDefaultAnnotation']
              as Map<String, dynamic>),
      fieldValueAllowedInt: extendedJson['fieldValueAllowedInt'] as int,
      fieldValueAllowedNullableInt:
          extendedJson['fieldValueAllowedNullableInt'] as int?,
      fieldValueAllowedNullableIntWithDefaultAnnotation:
          extendedJson['fieldValueAllowedNullableIntWithDefaultAnnotation']
              as int?,
      entityId: extendedJson['entityId'] as String,
    );
  }

  factory ReadEntity.fromDocumentSnapshot(DocumentSnapshot ds) {
    final data = ds.data()! as Map<String, dynamic>;
    return ReadEntity._fromJson(<String, dynamic>{
      ...data,
      'entityId': ds.id,
      'path': ds.reference.path,
    });
  }
}

class CreateEntity {
  const CreateEntity({
    required this.text,
    this.textWithDefault = 'createDefault',
    this.nullableText = 'createDefault',
    required this.integer,
    required this.integerWithDefault,
    this.nullableInteger,
    required this.doubleNumber,
    required this.doubleNumberWithDefault,
    this.nullableDoubleNumber,
    required this.isBool,
    required this.isBoolWithDefault,
    this.nullableIsBool,
    required this.texts,
    required this.textsWithDefault,
    this.nullableTexts,
    required this.map,
    required this.mapWithDefault,
    this.nullableMap,
    required this.stringMap,
    required this.stringMapWithDefault,
    this.nullableStringMap,
    required this.nestedMap,
    required this.nestedMapWithDefault,
    this.nullableNestedMap,
    required this.listMap,
    required this.listMapWithDefault,
    this.nullableListMap,
    required this.mapList,
    required this.mapListWithDefault,
    this.nullableMapList,
    required this.geoPoint,
    required this.geoPointWithDefault,
    this.nullableGeoPoint,
    required this.dateTime,
    this.nullableDateTime,
    required this.timestamp,
    this.nullableTimestamp,
    required this.documentReference,
    this.nullableDocumentReference,
    required this.foo,
    required this.fooWithDefault,
    this.nullableFoo,
    this.nullableFooWithDefaultAnnotation = const Foo('defaultBar'),
    required this.fieldValueAllowedInt,
    this.fieldValueAllowedNullableInt,
    this.fieldValueAllowedNullableIntWithDefaultAnnotation =
        const ActualValue(0),
  });

  final String text;
  final String textWithDefault;
  final String? nullableText;
  final int integer;
  final int integerWithDefault;
  final int? nullableInteger;
  final double doubleNumber;
  final double doubleNumberWithDefault;
  final double? nullableDoubleNumber;
  final bool isBool;
  final bool isBoolWithDefault;
  final bool? nullableIsBool;
  final List<String> texts;
  final List<String> textsWithDefault;
  final List<String>? nullableTexts;
  final Map<String, dynamic> map;
  final Map<String, dynamic> mapWithDefault;
  final Map<String, dynamic>? nullableMap;
  final Map<String, String> stringMap;
  final Map<String, String> stringMapWithDefault;
  final Map<String, String>? nullableStringMap;
  final Map<String, Map<String, int>> nestedMap;
  final Map<String, Map<String, int>> nestedMapWithDefault;
  final Map<String, Map<String, int>>? nullableNestedMap;
  final Map<String, List<int>> listMap;
  final Map<String, List<int>> listMapWithDefault;
  final Map<String, List<int>>? nullableListMap;
  final List<Map<String, int>> mapList;
  final List<Map<String, int>> mapListWithDefault;
  final List<Map<String, int>>? nullableMapList;
  final GeoPoint geoPoint;
  final GeoPoint geoPointWithDefault;
  final GeoPoint? nullableGeoPoint;
  final DateTime dateTime;
  final DateTime? nullableDateTime;
  final Timestamp timestamp;
  final Timestamp? nullableTimestamp;
  final DocumentReference<Object?> documentReference;
  final DocumentReference<Object?>? nullableDocumentReference;
  final Foo foo;
  final Foo fooWithDefault;
  final Foo? nullableFoo;
  final Foo? nullableFooWithDefaultAnnotation;
  final FirestoreData<int> fieldValueAllowedInt;
  final FirestoreData<int>? fieldValueAllowedNullableInt;
  final FirestoreData<int>? fieldValueAllowedNullableIntWithDefaultAnnotation;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'text': text,
      'textWithDefault': textWithDefault,
      'nullableText': nullableText ?? 'createDefault',
      'integer': integer,
      'integerWithDefault': integerWithDefault,
      'nullableInteger': nullableInteger,
      'doubleNumber': doubleNumber,
      'doubleNumberWithDefault': doubleNumberWithDefault,
      'nullableDoubleNumber': nullableDoubleNumber,
      'isBool': isBool,
      'isBoolWithDefault': isBoolWithDefault,
      'nullableIsBool': nullableIsBool,
      'texts': texts,
      'textsWithDefault': textsWithDefault,
      'nullableTexts': nullableTexts,
      'map': map,
      'mapWithDefault': mapWithDefault,
      'nullableMap': nullableMap,
      'stringMap': stringMap,
      'stringMapWithDefault': stringMapWithDefault,
      'nullableStringMap': nullableStringMap,
      'nestedMap': nestedMap,
      'nestedMapWithDefault': nestedMapWithDefault,
      'nullableNestedMap': nullableNestedMap,
      'listMap': listMap,
      'listMapWithDefault': listMapWithDefault,
      'nullableListMap': nullableListMap,
      'mapList': mapList,
      'mapListWithDefault': mapListWithDefault,
      'nullableMapList': nullableMapList,
      'geoPoint': geoPoint,
      'geoPointWithDefault': geoPointWithDefault,
      'nullableGeoPoint': nullableGeoPoint,
      'dateTime': dateTime,
      'nullableDateTime': nullableDateTime,
      'timestamp': timestamp,
      'nullableTimestamp': nullableTimestamp,
      'documentReference': documentReference,
      'nullableDocumentReference': nullableDocumentReference,
      'foo': _FooJsonConverter().toJson(foo),
      'fooWithDefault': _FooJsonConverter().toJson(fooWithDefault),
      'nullableFoo': _nullableFooJsonConverter.toJson(nullableFoo),
      'nullableFooWithDefaultAnnotation':
          nullableFooWithDefaultAnnotation == null
              ? const Foo('defaultBar')
              : _FooJsonConverter().toJson(nullableFooWithDefaultAnnotation!),
      'fieldValueAllowedInt': fieldValueAllowedInt.value,
      'fieldValueAllowedNullableInt': fieldValueAllowedNullableInt?.value,
      'fieldValueAllowedNullableIntWithDefaultAnnotation':
          fieldValueAllowedNullableIntWithDefaultAnnotation?.value ?? 0,
    };
    final jsonPostProcessors = <({String key, dynamic value})>[];
    return {
      ...json,
      ...Map.fromEntries(jsonPostProcessors
          .map((record) => MapEntry(record.key, record.value))),
    };
  }
}

class UpdateEntity {
  const UpdateEntity({
    this.text,
    this.textWithDefault = 'updateDefault',
    this.nullableText = 'updateDefault',
    this.integer,
    this.integerWithDefault,
    this.nullableInteger,
    this.doubleNumber,
    this.doubleNumberWithDefault,
    this.nullableDoubleNumber,
    this.isBool,
    this.isBoolWithDefault,
    this.nullableIsBool,
    this.texts,
    this.textsWithDefault,
    this.nullableTexts,
    this.map,
    this.mapWithDefault,
    this.nullableMap,
    this.stringMap,
    this.stringMapWithDefault,
    this.nullableStringMap,
    this.nestedMap,
    this.nestedMapWithDefault,
    this.nullableNestedMap,
    this.listMap,
    this.listMapWithDefault,
    this.nullableListMap,
    this.mapList,
    this.mapListWithDefault,
    this.nullableMapList,
    this.geoPoint,
    this.geoPointWithDefault,
    this.nullableGeoPoint,
    this.dateTime,
    this.nullableDateTime,
    this.timestamp,
    this.nullableTimestamp,
    this.documentReference,
    this.nullableDocumentReference,
    this.foo,
    this.fooWithDefault,
    this.nullableFoo,
    this.nullableFooWithDefaultAnnotation,
    this.fieldValueAllowedInt,
    this.fieldValueAllowedNullableInt,
    this.fieldValueAllowedNullableIntWithDefaultAnnotation,
  });

  final String? text;
  final String? textWithDefault;
  final String? nullableText;
  final int? integer;
  final int? integerWithDefault;
  final int? nullableInteger;
  final double? doubleNumber;
  final double? doubleNumberWithDefault;
  final double? nullableDoubleNumber;
  final bool? isBool;
  final bool? isBoolWithDefault;
  final bool? nullableIsBool;
  final List<String>? texts;
  final List<String>? textsWithDefault;
  final List<String>? nullableTexts;
  final Map<String, dynamic>? map;
  final Map<String, dynamic>? mapWithDefault;
  final Map<String, dynamic>? nullableMap;
  final Map<String, String>? stringMap;
  final Map<String, String>? stringMapWithDefault;
  final Map<String, String>? nullableStringMap;
  final Map<String, Map<String, int>>? nestedMap;
  final Map<String, Map<String, int>>? nestedMapWithDefault;
  final Map<String, Map<String, int>>? nullableNestedMap;
  final Map<String, List<int>>? listMap;
  final Map<String, List<int>>? listMapWithDefault;
  final Map<String, List<int>>? nullableListMap;
  final List<Map<String, int>>? mapList;
  final List<Map<String, int>>? mapListWithDefault;
  final List<Map<String, int>>? nullableMapList;
  final GeoPoint? geoPoint;
  final GeoPoint? geoPointWithDefault;
  final GeoPoint? nullableGeoPoint;
  final DateTime? dateTime;
  final DateTime? nullableDateTime;
  final Timestamp? timestamp;
  final Timestamp? nullableTimestamp;
  final DocumentReference<Object?>? documentReference;
  final DocumentReference<Object?>? nullableDocumentReference;
  final Foo? foo;
  final Foo? fooWithDefault;
  final Foo? nullableFoo;
  final Foo? nullableFooWithDefaultAnnotation;
  final FirestoreData<int>? fieldValueAllowedInt;
  final FirestoreData<int?>? fieldValueAllowedNullableInt;
  final FirestoreData<int?>? fieldValueAllowedNullableIntWithDefaultAnnotation;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      if (text != null) 'text': text,
      'textWithDefault': textWithDefault ?? 'updateDefault',
      'nullableText': nullableText ?? 'updateDefault',
      if (integer != null) 'integer': integer,
      if (integerWithDefault != null) 'integerWithDefault': integerWithDefault,
      if (nullableInteger != null) 'nullableInteger': nullableInteger,
      if (doubleNumber != null) 'doubleNumber': doubleNumber,
      if (doubleNumberWithDefault != null)
        'doubleNumberWithDefault': doubleNumberWithDefault,
      if (nullableDoubleNumber != null)
        'nullableDoubleNumber': nullableDoubleNumber,
      if (isBool != null) 'isBool': isBool,
      if (isBoolWithDefault != null) 'isBoolWithDefault': isBoolWithDefault,
      if (nullableIsBool != null) 'nullableIsBool': nullableIsBool,
      if (texts != null) 'texts': texts,
      if (textsWithDefault != null) 'textsWithDefault': textsWithDefault,
      if (nullableTexts != null) 'nullableTexts': nullableTexts,
      if (map != null) 'map': map,
      if (mapWithDefault != null) 'mapWithDefault': mapWithDefault,
      if (nullableMap != null) 'nullableMap': nullableMap,
      if (stringMap != null) 'stringMap': stringMap,
      if (stringMapWithDefault != null)
        'stringMapWithDefault': stringMapWithDefault,
      if (nullableStringMap != null) 'nullableStringMap': nullableStringMap,
      if (nestedMap != null) 'nestedMap': nestedMap,
      if (nestedMapWithDefault != null)
        'nestedMapWithDefault': nestedMapWithDefault,
      if (nullableNestedMap != null) 'nullableNestedMap': nullableNestedMap,
      if (listMap != null) 'listMap': listMap,
      if (listMapWithDefault != null) 'listMapWithDefault': listMapWithDefault,
      if (nullableListMap != null) 'nullableListMap': nullableListMap,
      if (mapList != null) 'mapList': mapList,
      if (mapListWithDefault != null) 'mapListWithDefault': mapListWithDefault,
      if (nullableMapList != null) 'nullableMapList': nullableMapList,
      if (geoPoint != null) 'geoPoint': geoPoint,
      if (geoPointWithDefault != null)
        'geoPointWithDefault': geoPointWithDefault,
      if (nullableGeoPoint != null) 'nullableGeoPoint': nullableGeoPoint,
      if (dateTime != null) 'dateTime': dateTime,
      if (nullableDateTime != null) 'nullableDateTime': nullableDateTime,
      if (timestamp != null) 'timestamp': timestamp,
      if (nullableTimestamp != null) 'nullableTimestamp': nullableTimestamp,
      if (documentReference != null) 'documentReference': documentReference,
      if (nullableDocumentReference != null)
        'nullableDocumentReference': nullableDocumentReference,
      if (foo != null) 'foo': _FooJsonConverter().toJson(foo!),
      if (fooWithDefault != null)
        'fooWithDefault': _FooJsonConverter().toJson(fooWithDefault!),
      if (nullableFoo != null)
        'nullableFoo': _nullableFooJsonConverter.toJson(nullableFoo!),
      if (nullableFooWithDefaultAnnotation != null)
        'nullableFooWithDefaultAnnotation':
            _FooJsonConverter().toJson(nullableFooWithDefaultAnnotation!),
      if (fieldValueAllowedInt != null)
        'fieldValueAllowedInt': fieldValueAllowedInt!.value,
      if (fieldValueAllowedNullableInt != null)
        'fieldValueAllowedNullableInt': fieldValueAllowedNullableInt!.value,
      if (fieldValueAllowedNullableIntWithDefaultAnnotation != null)
        'fieldValueAllowedNullableIntWithDefaultAnnotation':
            fieldValueAllowedNullableIntWithDefaultAnnotation!.value,
    };
    final jsonPostProcessors = <({String key, dynamic value})>[];
    return {
      ...json,
      ...Map.fromEntries(jsonPostProcessors
          .map((record) => MapEntry(record.key, record.value))),
    };
  }
}

class DeleteEntity {}

/// Provides a reference to the entities collection for reading.
final readEntityCollectionReference =
    FirebaseFirestore.instance.collection('entities').withConverter<ReadEntity>(
          fromFirestore: (ds, _) => ReadEntity.fromDocumentSnapshot(ds),
          toFirestore: (_, __) => throw UnimplementedError(),
        );

/// Provides a reference to a entity document for reading.
DocumentReference<ReadEntity> readEntityDocumentReference({
  required String entityId,
}) =>
    readEntityCollectionReference.doc(entityId);

/// Provides a reference to the entities collection for creating.
final createEntityCollectionReference = FirebaseFirestore.instance
    .collection('entities')
    .withConverter<CreateEntity>(
      fromFirestore: (_, __) => throw UnimplementedError(),
      toFirestore: (obj, _) => obj.toJson(),
    );

/// Provides a reference to a entity document for creating.
DocumentReference<CreateEntity> createEntityDocumentReference({
  required String entityId,
}) =>
    createEntityCollectionReference.doc(entityId);

/// Provides a reference to the entities collection for updating.
final updateEntityCollectionReference = FirebaseFirestore.instance
    .collection('entities')
    .withConverter<UpdateEntity>(
      fromFirestore: (_, __) => throw UnimplementedError(),
      toFirestore: (obj, _) => obj.toJson(),
    );

/// Provides a reference to a entity document for updating.
DocumentReference<UpdateEntity> updateEntityDocumentReference({
  required String entityId,
}) =>
    updateEntityCollectionReference.doc(entityId);

/// Provides a reference to the entities collection for deleting.
final deleteEntityCollectionReference = FirebaseFirestore.instance
    .collection('entities')
    .withConverter<DeleteEntity>(
      fromFirestore: (_, __) => throw UnimplementedError(),
      toFirestore: (_, __) => throw UnimplementedError(),
    );

/// Provides a reference to a entity document for deleting.
DocumentReference<DeleteEntity> deleteEntityDocumentReference({
  required String entityId,
}) =>
    deleteEntityCollectionReference.doc(entityId);

/// Manages queries against the entities collection.
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

  /// Fetches a specific [ReadEntity] document.
  Future<ReadEntity?> fetchDocument({
    required String entityId,
    GetOptions? options,
  }) async {
    final ds = await readEntityDocumentReference(
      entityId: entityId,
    ).get(options);
    return ds.data();
  }

  /// Subscribes a specific [Entity] document.
  Stream<ReadEntity?> subscribeDocument({
    required String entityId,
    bool includeMetadataChanges = false,
    bool excludePendingWrites = false,
  }) {
    var streamDs = readEntityDocumentReference(
      entityId: entityId,
    ).snapshots(includeMetadataChanges: includeMetadataChanges);
    if (excludePendingWrites) {
      streamDs = streamDs.where((ds) => !ds.metadata.hasPendingWrites);
    }
    return streamDs.map((ds) => ds.data());
  }

  /// Adds a [Entity] document.
  Future<DocumentReference<CreateEntity>> add({
    required CreateEntity createEntity,
  }) =>
      createEntityCollectionReference.add(createEntity);

  /// Sets a [Entity] document.
  Future<void> set({
    required String entityId,
    required CreateEntity createEntity,
    SetOptions? options,
  }) =>
      createEntityDocumentReference(
        entityId: entityId,
      ).set(createEntity, options);

  /// Updates a specific [Entity] document.
  Future<void> update({
    required String entityId,
    required UpdateEntity updateEntity,
  }) =>
      updateEntityDocumentReference(
        entityId: entityId,
      ).update(updateEntity.toJson());

  /// Deletes a specific [Entity] document.
  Future<void> delete({
    required String entityId,
  }) =>
      deleteEntityDocumentReference(
        entityId: entityId,
      ).delete();
}
