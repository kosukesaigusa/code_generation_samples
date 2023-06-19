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
    required this.isNullableBool,
    // required this.map,
    // required this.nestedMap,
    required this.texts,
    this.nullableTexts,
    required this.twoDList,
    required this.threeDList,
    // this.nullableTwoDList,
    required this.geoPoint,
    // required this.dateTime,
    // this.serverTimestamp,
    // required this.foo,
  });

  final String text;
  @Default('defaultText')
  final String? nullableText;
  final int integer;
  final bool isBool;
  @Default(false)
  final bool? isNullableBool;
  // final Map<String, dynamic> map;
  // TODO: nestedMap の対応
  // final Map<String, Map<String, int>> nestedMap;
  final List<String> texts;
  @Default(<String>[])
  final List<String>? nullableTexts;
  final List<List<String>> twoDList;
  final List<List<List<String>>> threeDList;
  // TODO: nullableNDList の対応
  // @Default(<String>[])
  // final List<List<String>>? nullableTwoDList;
  final GeoPoint geoPoint;
  // final DateTime dateTime;
  // final DateTime? serverTimestamp;
  // final Foo foo;
}

class Foo {
  const Foo(this.bar);

  final String bar;
}
