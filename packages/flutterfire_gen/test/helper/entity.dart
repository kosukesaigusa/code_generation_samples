import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutterfire_gen_annotation/flutterfire_gen_annotation.dart';

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
  });

  final String text;
  @Default('defaultText')
  final String? nullableText;
  final int integer;
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
}

class Foo {
  const Foo(this.bar);

  final String bar;
}
