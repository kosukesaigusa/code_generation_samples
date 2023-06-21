import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutterfire_gen_annotation/flutterfire_gen_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'entity.g.dart';

@FirestoreDocument(
  useFakeFirebaseFirestore: true,
  collectionName: 'entities',
  documentName: 'entity',
)
class Entity {
  Entity({
    required this.text,
    this.nullableText,
    required this.integer,
    this.nullableInteger,
    required this.doubleNumber,
    this.nullableDoubleNumber,
    required this.isBool,
    this.nullableIsBool,
    required this.texts,
    this.nullableTexts,
    required this.map,
    this.nullableMap,
    required this.stringMap,
    this.nullableStringMap,
    required this.nestedMap,
    this.nullableNestedMap,
    required this.listMap,
    this.nullableListMap,
    required this.mapList,
    this.nullableMapList,
    required this.geoPoint,
    this.nullableGeoPoint,
    required this.dateTime,
    this.nullableDateTime,
    required this.timestamp,
    this.nullableTimestamp,
    required this.documentReference,
    this.nullableDocumentReference,
    required this.foo,
    this.nullableFooWithDefaultAnnotation,
    this.nullableFooWithDefaultValueInConstructor = const Foo('defaultBar'),
  });

  final String text;
  @Default('defaultText')
  final String? nullableText;
  final int integer;
  @Default(0)
  final int? nullableInteger;
  final double doubleNumber;
  @Default(0.0)
  final double? nullableDoubleNumber;
  final bool isBool;
  final bool? nullableIsBool;
  final List<String> texts;
  @Default(<String>[])
  final List<String>? nullableTexts;
  final Map<String, dynamic> map;
  @Default(<String, dynamic>{})
  final Map<String, dynamic>? nullableMap;
  final Map<String, String> stringMap;
  @Default(<String, String>{})
  final Map<String, String>? nullableStringMap;
  final Map<String, Map<String, int>> nestedMap;
  @Default(<String, Map<String, int>>{})
  final Map<String, Map<String, int>>? nullableNestedMap;
  final Map<String, List<int>> listMap;
  @Default(<String, List<int>>{})
  final Map<String, List<int>>? nullableListMap;
  final List<Map<String, int>> mapList;
  @Default(<Map<String, int>>[])
  final List<Map<String, int>>? nullableMapList;
  final GeoPoint geoPoint;
  @Default(GeoPoint(0, 0))
  final GeoPoint? nullableGeoPoint;
  final DateTime dateTime;
  final DateTime? nullableDateTime;
  final Timestamp timestamp;
  final Timestamp? nullableTimestamp;
  final DocumentReference<Object?> documentReference;
  final DocumentReference<Object?>? nullableDocumentReference;
  @_FooJsonConverter()
  final Foo foo;
  @Default(Foo('defaultBar'))
  @_nullableFooJsonConverter
  final Foo? nullableFooWithDefaultAnnotation;
  @_nullableFooJsonConverter
  final Foo? nullableFooWithDefaultValueInConstructor;
}

class Foo {
  const Foo(this.bar);

  final String bar;
}

class _FooJsonConverter implements JsonConverter<Foo, Map<String, dynamic>> {
  const _FooJsonConverter();

  @override
  Foo fromJson(Map<String, dynamic> json) {
    final bar = json['bar'] as String;
    return Foo(bar);
  }

  @override
  Map<String, dynamic> toJson(Foo foo) {
    return <String, dynamic>{'bar': foo.bar};
  }
}

const _nullableFooJsonConverter = _NullableFooJsonConverter();

class _NullableFooJsonConverter
    implements JsonConverter<Foo?, Map<String, dynamic>> {
  const _NullableFooJsonConverter();

  @override
  Foo? fromJson(Map<String, dynamic> json) {
    final bar = json['bar'] as String?;
    if (bar == null) {
      return null;
    }
    return Foo(bar);
  }

  @override
  Map<String, dynamic> toJson(Foo? foo) {
    if (foo == null) {
      return <String, dynamic>{'bar': 'defaultBar'};
    }
    return <String, dynamic>{'bar': foo.bar};
  }
}
