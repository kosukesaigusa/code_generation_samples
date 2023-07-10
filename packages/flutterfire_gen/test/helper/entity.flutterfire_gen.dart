// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'entity.dart';

final fakeDb = FakeFirebaseFirestore();

class ReadEntity {
  const ReadEntity._({
    required this.entityId,
    required this.entityReference,
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
    required this.nullableFooWithDefaultValueInConstructor,
    required this.fieldValueAllowedInt,
    required this.fieldValueAllowedNullableInt,
    required this.fieldValueAllowedNullableIntWithDefaultAnnotation,
    required this.fieldValueAllowedNullableIntWithDefaultInConstructor,
  });

  final String entityId;
  final DocumentReference<ReadEntity> entityReference;
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
  final Foo? nullableFooWithDefaultValueInConstructor;
  final int fieldValueAllowedInt;
  final int? fieldValueAllowedNullableInt;
  final int? fieldValueAllowedNullableIntWithDefaultAnnotation;
  final int? fieldValueAllowedNullableIntWithDefaultInConstructor;

  factory ReadEntity._fromJson(Map<String, dynamic> json) {
    return ReadEntity._(
      entityId: json['entityId'] as String,
      entityReference: json['entityReference'] as DocumentReference<ReadEntity>,
      text: json['text'] as String,
      textWithDefault:
          json['textWithDefault'] as String? ?? 'requiredWithDefault',
      nullableText: json['nullableText'] as String? ?? 'defaultText',
      integer: json['integer'] as int,
      integerWithDefault: json['integerWithDefault'] as int? ?? 0,
      nullableInteger: json['nullableInteger'] as int? ?? 0,
      doubleNumber: json['doubleNumber'] as double,
      doubleNumberWithDefault:
          json['doubleNumberWithDefault'] as double? ?? 3.14,
      nullableDoubleNumber: json['nullableDoubleNumber'] as double? ?? 3.14,
      isBool: json['isBool'] as bool,
      isBoolWithDefault: json['isBoolWithDefault'] as bool? ?? false,
      nullableIsBool: json['nullableIsBool'] as bool? ?? false,
      texts: (json['texts'] as List<dynamic>).map((e) => e as String).toList(),
      textsWithDefault: (json['textsWithDefault'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>['requiredWithDefault'],
      nullableTexts: (json['nullableTexts'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      map: json['map'] as Map<String, dynamic>,
      mapWithDefault: json['mapWithDefault'] as Map<String, dynamic>? ??
          const <String, dynamic>{},
      nullableMap: json['nullableMap'] as Map<String, dynamic>? ??
          const <String, dynamic>{},
      stringMap: (json['stringMap'] as Map<String, dynamic>)
          .map((k, v) => MapEntry(k, v as String)),
      stringMapWithDefault:
          (json['stringMapWithDefault'] as Map<String, dynamic>?)
                  ?.map((k, v) => MapEntry(k, v as String)) ??
              const <String, String>{},
      nullableStringMap: (json['nullableStringMap'] as Map<String, dynamic>?)
              ?.map((k, v) => MapEntry(k, v as String)) ??
          const <String, String>{},
      nestedMap: (json['nestedMap'] as Map<String, dynamic>).map((k, v) =>
          MapEntry(
              k,
              (v as Map<String, dynamic>)
                  .map((k, v) => MapEntry(k, v as int)))),
      nestedMapWithDefault:
          (json['nestedMapWithDefault'] as Map<String, dynamic>?)?.map((k, v) =>
                  MapEntry(
                      k,
                      (v as Map<String, dynamic>)
                          .map((k, v) => MapEntry(k, v as int)))) ??
              const <String, Map<String, int>>{
                'requiredWithDefault': <String, int>{}
              },
      nullableNestedMap: (json['nullableNestedMap'] as Map<String, dynamic>?)
              ?.map((k, v) => MapEntry(
                  k,
                  (v as Map<String, dynamic>)
                      .map((k, v) => MapEntry(k, v as int)))) ??
          const <String, Map<String, int>>{},
      listMap: (json['listMap'] as Map<String, dynamic>).map((k, v) =>
          MapEntry(k, (v as List<dynamic>).map((e) => e as int).toList())),
      listMapWithDefault: (json['listMapWithDefault'] as Map<String, dynamic>?)
              ?.map((k, v) => MapEntry(
                  k, (v as List<dynamic>).map((e) => e as int).toList())) ??
          const <String, List<int>>{'requiredWithDefault': <int>[]},
      nullableListMap: (json['nullableListMap'] as Map<String, dynamic>?)?.map(
              (k, v) => MapEntry(
                  k, (v as List<dynamic>).map((e) => e as int).toList())) ??
          const <String, List<int>>{},
      mapList: (json['mapList'] as List<dynamic>)
          .map((e) =>
              (e as Map<String, dynamic>).map((k, v) => MapEntry(k, v as int)))
          .toList(),
      mapListWithDefault: (json['mapListWithDefault'] as List<dynamic>?)
              ?.map((e) => (e as Map<String, dynamic>)
                  .map((k, v) => MapEntry(k, v as int)))
              .toList() ??
          const <Map<String, int>>[
            <String, int>{'requiredWithDefault': 0}
          ],
      nullableMapList: (json['nullableMapList'] as List<dynamic>?)
              ?.map((e) => (e as Map<String, dynamic>)
                  .map((k, v) => MapEntry(k, v as int)))
              .toList() ??
          const <Map<String, int>>[],
      geoPoint: json['geoPoint'] as GeoPoint,
      geoPointWithDefault:
          json['geoPointWithDefault'] as GeoPoint? ?? const GeoPoint(0, 0),
      nullableGeoPoint:
          json['nullableGeoPoint'] as GeoPoint? ?? const GeoPoint(0, 0),
      dateTime: (json['dateTime'] as Timestamp).toDate(),
      nullableDateTime: (json['nullableDateTime'] as Timestamp?)?.toDate(),
      timestamp: json['timestamp'] as Timestamp,
      nullableTimestamp: json['nullableTimestamp'] as Timestamp?,
      documentReference:
          json['documentReference'] as DocumentReference<Object?>,
      nullableDocumentReference:
          json['nullableDocumentReference'] as DocumentReference<Object?>?,
      foo: _FooJsonConverter().fromJson(json['foo'] as Map<String, dynamic>),
      fooWithDefault: json['fooWithDefault'] == null
          ? const Foo('requiredWithDefault')
          : _FooJsonConverter()
              .fromJson(json['fooWithDefault'] as Map<String, dynamic>),
      nullableFoo: _nullableFooJsonConverter
          .fromJson(json['nullableFoo'] as Map<String, dynamic>),
      nullableFooWithDefaultAnnotation:
          json['nullableFooWithDefaultAnnotation'] == null
              ? const Foo('defaultBar')
              : _FooJsonConverter().fromJson(
                  json['nullableFooWithDefaultAnnotation']
                      as Map<String, dynamic>),
      nullableFooWithDefaultValueInConstructor:
          json['nullableFooWithDefaultValueInConstructor'] == null
              ? const Foo('defaultBar')
              : _FooJsonConverter().fromJson(
                  json['nullableFooWithDefaultValueInConstructor']
                      as Map<String, dynamic>),
      fieldValueAllowedInt: json['fieldValueAllowedInt'] as int,
      fieldValueAllowedNullableInt:
          json['fieldValueAllowedNullableInt'] as int?,
      fieldValueAllowedNullableIntWithDefaultAnnotation:
          json['fieldValueAllowedNullableIntWithDefaultAnnotation'] as int? ??
              0,
      fieldValueAllowedNullableIntWithDefaultInConstructor:
          json['fieldValueAllowedNullableIntWithDefaultInConstructor']
                  as int? ??
              0,
    );
  }

  factory ReadEntity.fromDocumentSnapshot(DocumentSnapshot ds) {
    final data = ds.data()! as Map<String, dynamic>;
    return ReadEntity._fromJson(<String, dynamic>{
      ...data,
      'entityId': ds.id,
      'entityReference': ds.reference.parent.doc(ds.id).withConverter(
            fromFirestore: (ds, _) => ReadEntity.fromDocumentSnapshot(ds),
            toFirestore: (obj, _) => throw UnimplementedError(),
          ),
    });
  }

  ReadEntity copyWith({
    String? entityId,
    DocumentReference<ReadEntity>? entityReference,
    String? text,
    String? textWithDefault,
    String? nullableText,
    int? integer,
    int? integerWithDefault,
    int? nullableInteger,
    double? doubleNumber,
    double? doubleNumberWithDefault,
    double? nullableDoubleNumber,
    bool? isBool,
    bool? isBoolWithDefault,
    bool? nullableIsBool,
    List<String>? texts,
    List<String>? textsWithDefault,
    List<String>? nullableTexts,
    Map<String, dynamic>? map,
    Map<String, dynamic>? mapWithDefault,
    Map<String, dynamic>? nullableMap,
    Map<String, String>? stringMap,
    Map<String, String>? stringMapWithDefault,
    Map<String, String>? nullableStringMap,
    Map<String, Map<String, int>>? nestedMap,
    Map<String, Map<String, int>>? nestedMapWithDefault,
    Map<String, Map<String, int>>? nullableNestedMap,
    Map<String, List<int>>? listMap,
    Map<String, List<int>>? listMapWithDefault,
    Map<String, List<int>>? nullableListMap,
    List<Map<String, int>>? mapList,
    List<Map<String, int>>? mapListWithDefault,
    List<Map<String, int>>? nullableMapList,
    GeoPoint? geoPoint,
    GeoPoint? geoPointWithDefault,
    GeoPoint? nullableGeoPoint,
    DateTime? dateTime,
    DateTime? nullableDateTime,
    Timestamp? timestamp,
    Timestamp? nullableTimestamp,
    DocumentReference<Object?>? documentReference,
    DocumentReference<Object?>? nullableDocumentReference,
    Foo? foo,
    Foo? fooWithDefault,
    Foo? nullableFoo,
    Foo? nullableFooWithDefaultAnnotation,
    Foo? nullableFooWithDefaultValueInConstructor,
    int? fieldValueAllowedInt,
    int? fieldValueAllowedNullableInt,
    int? fieldValueAllowedNullableIntWithDefaultAnnotation,
    int? fieldValueAllowedNullableIntWithDefaultInConstructor,
  }) {
    return ReadEntity._(
      entityId: entityId ?? this.entityId,
      entityReference: entityReference ?? this.entityReference,
      text: text ?? this.text,
      textWithDefault: textWithDefault ?? this.textWithDefault,
      nullableText: nullableText ?? this.nullableText,
      integer: integer ?? this.integer,
      integerWithDefault: integerWithDefault ?? this.integerWithDefault,
      nullableInteger: nullableInteger ?? this.nullableInteger,
      doubleNumber: doubleNumber ?? this.doubleNumber,
      doubleNumberWithDefault:
          doubleNumberWithDefault ?? this.doubleNumberWithDefault,
      nullableDoubleNumber: nullableDoubleNumber ?? this.nullableDoubleNumber,
      isBool: isBool ?? this.isBool,
      isBoolWithDefault: isBoolWithDefault ?? this.isBoolWithDefault,
      nullableIsBool: nullableIsBool ?? this.nullableIsBool,
      texts: texts ?? this.texts,
      textsWithDefault: textsWithDefault ?? this.textsWithDefault,
      nullableTexts: nullableTexts ?? this.nullableTexts,
      map: map ?? this.map,
      mapWithDefault: mapWithDefault ?? this.mapWithDefault,
      nullableMap: nullableMap ?? this.nullableMap,
      stringMap: stringMap ?? this.stringMap,
      stringMapWithDefault: stringMapWithDefault ?? this.stringMapWithDefault,
      nullableStringMap: nullableStringMap ?? this.nullableStringMap,
      nestedMap: nestedMap ?? this.nestedMap,
      nestedMapWithDefault: nestedMapWithDefault ?? this.nestedMapWithDefault,
      nullableNestedMap: nullableNestedMap ?? this.nullableNestedMap,
      listMap: listMap ?? this.listMap,
      listMapWithDefault: listMapWithDefault ?? this.listMapWithDefault,
      nullableListMap: nullableListMap ?? this.nullableListMap,
      mapList: mapList ?? this.mapList,
      mapListWithDefault: mapListWithDefault ?? this.mapListWithDefault,
      nullableMapList: nullableMapList ?? this.nullableMapList,
      geoPoint: geoPoint ?? this.geoPoint,
      geoPointWithDefault: geoPointWithDefault ?? this.geoPointWithDefault,
      nullableGeoPoint: nullableGeoPoint ?? this.nullableGeoPoint,
      dateTime: dateTime ?? this.dateTime,
      nullableDateTime: nullableDateTime ?? this.nullableDateTime,
      timestamp: timestamp ?? this.timestamp,
      nullableTimestamp: nullableTimestamp ?? this.nullableTimestamp,
      documentReference: documentReference ?? this.documentReference,
      nullableDocumentReference:
          nullableDocumentReference ?? this.nullableDocumentReference,
      foo: foo ?? this.foo,
      fooWithDefault: fooWithDefault ?? this.fooWithDefault,
      nullableFoo: nullableFoo ?? this.nullableFoo,
      nullableFooWithDefaultAnnotation: nullableFooWithDefaultAnnotation ??
          this.nullableFooWithDefaultAnnotation,
      nullableFooWithDefaultValueInConstructor:
          nullableFooWithDefaultValueInConstructor ??
              this.nullableFooWithDefaultValueInConstructor,
      fieldValueAllowedInt: fieldValueAllowedInt ?? this.fieldValueAllowedInt,
      fieldValueAllowedNullableInt:
          fieldValueAllowedNullableInt ?? this.fieldValueAllowedNullableInt,
      fieldValueAllowedNullableIntWithDefaultAnnotation:
          fieldValueAllowedNullableIntWithDefaultAnnotation ??
              this.fieldValueAllowedNullableIntWithDefaultAnnotation,
      fieldValueAllowedNullableIntWithDefaultInConstructor:
          fieldValueAllowedNullableIntWithDefaultInConstructor ??
              this.fieldValueAllowedNullableIntWithDefaultInConstructor,
    );
  }
}

class CreateEntity {
  const CreateEntity({
    required this.text,
    this.textWithDefault = 'requiredWithDefault',
    this.nullableText = 'defaultText',
    required this.integer,
    this.integerWithDefault = 0,
    this.nullableInteger = 0,
    required this.doubleNumber,
    this.doubleNumberWithDefault = 3.14,
    this.nullableDoubleNumber = 3.14,
    required this.isBool,
    this.isBoolWithDefault = false,
    this.nullableIsBool = false,
    required this.texts,
    this.textsWithDefault = const <String>['requiredWithDefault'],
    this.nullableTexts = const <String>[],
    required this.map,
    this.mapWithDefault = const <String, dynamic>{},
    this.nullableMap = const <String, dynamic>{},
    required this.stringMap,
    this.stringMapWithDefault = const <String, String>{},
    this.nullableStringMap = const <String, String>{},
    required this.nestedMap,
    this.nestedMapWithDefault = const <String, Map<String, int>>{
      'requiredWithDefault': <String, int>{}
    },
    this.nullableNestedMap = const <String, Map<String, int>>{},
    required this.listMap,
    this.listMapWithDefault = const <String, List<int>>{
      'requiredWithDefault': <int>[]
    },
    this.nullableListMap = const <String, List<int>>{},
    required this.mapList,
    this.mapListWithDefault = const <Map<String, int>>[
      <String, int>{'requiredWithDefault': 0}
    ],
    this.nullableMapList = const <Map<String, int>>[],
    required this.geoPoint,
    this.geoPointWithDefault = const GeoPoint(0, 0),
    this.nullableGeoPoint = const GeoPoint(0, 0),
    required this.dateTime,
    this.nullableDateTime,
    required this.timestamp,
    this.nullableTimestamp,
    required this.documentReference,
    this.nullableDocumentReference,
    required this.foo,
    this.fooWithDefault = const Foo('requiredWithDefault'),
    this.nullableFoo,
    this.nullableFooWithDefaultAnnotation = const Foo('defaultBar'),
    this.nullableFooWithDefaultValueInConstructor = const Foo('defaultBar'),
    required this.fieldValueAllowedInt,
    this.fieldValueAllowedNullableInt,
    this.fieldValueAllowedNullableIntWithDefaultAnnotation =
        const ActualValue(0),
    this.fieldValueAllowedNullableIntWithDefaultInConstructor =
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
  final Foo? nullableFooWithDefaultValueInConstructor;
  final FirestoreData<int> fieldValueAllowedInt;
  final FirestoreData<int>? fieldValueAllowedNullableInt;
  final FirestoreData<int>? fieldValueAllowedNullableIntWithDefaultAnnotation;
  final FirestoreData<int>?
      fieldValueAllowedNullableIntWithDefaultInConstructor;

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'textWithDefault': textWithDefault,
      'nullableText': nullableText ?? 'defaultText',
      'integer': integer,
      'integerWithDefault': integerWithDefault,
      'nullableInteger': nullableInteger ?? 0,
      'doubleNumber': doubleNumber,
      'doubleNumberWithDefault': doubleNumberWithDefault,
      'nullableDoubleNumber': nullableDoubleNumber ?? 3.14,
      'isBool': isBool,
      'isBoolWithDefault': isBoolWithDefault,
      'nullableIsBool': nullableIsBool ?? false,
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
      'nullableGeoPoint': nullableGeoPoint ?? const GeoPoint(0, 0),
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
      'nullableFooWithDefaultValueInConstructor':
          nullableFooWithDefaultValueInConstructor == null
              ? const Foo('defaultBar')
              : _FooJsonConverter()
                  .toJson(nullableFooWithDefaultValueInConstructor!),
      'fieldValueAllowedInt': fieldValueAllowedInt.value,
      'fieldValueAllowedNullableInt': fieldValueAllowedNullableInt?.value,
      'fieldValueAllowedNullableIntWithDefaultAnnotation':
          fieldValueAllowedNullableIntWithDefaultAnnotation?.value ?? 0,
      'fieldValueAllowedNullableIntWithDefaultInConstructor':
          fieldValueAllowedNullableIntWithDefaultInConstructor?.value ?? 0,
    };
  }
}

/// A [CollectionReference] to entities collection to read.
final readEntityCollectionReference =
    fakeDb.collection('entities').withConverter(
          fromFirestore: (ds, _) => ReadEntity.fromDocumentSnapshot(ds),
          toFirestore: (obj, _) => throw UnimplementedError(),
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
    final ds = await readEntityDocumentReference(
      entityId: entityId,
    ).get(options);
    return ds.data();
  }

  /// Subscribes [Entity] document.
  Future<Stream<ReadEntity?>> subscribeDocument({
    required String entityId,
    bool includeMetadataChanges = false,
    bool excludePendingWrites = false,
  }) async {
    var streamDs = readEntityDocumentReference(
      entityId: entityId,
    ).snapshots(includeMetadataChanges: includeMetadataChanges);
    if (excludePendingWrites) {
      streamDs = streamDs.where((ds) => !ds.metadata.hasPendingWrites);
    }
    return streamDs.map((ds) => ds.data());
  }
}
