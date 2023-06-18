import 'package:cloud_firestore/cloud_firestore.dart';

/// Cloud Firestore に存在する型一覧
/// string, number, boolean, map, array, null, timestamp, geopoint, reference

class Person {
  const Person({
    required this.name,
    this.nullableText,
    required this.age,
    required this.isAdult,
    required this.map,
    required this.texts,
    this.nullableTexts,
    required this.twoDimensionList,
    required this.geoPoint,
    required this.foo,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      name: json['name'] as String,
      nullableText: json['nullableText'] as String? ?? 'defaultText',
      age: json['age'] as int,
      isAdult: json['isAdult'] as bool? ?? false,
      map: json['map'] as Map<String, dynamic>,
      texts: (json['texts'] as List<dynamic>).map((e) => e as String).toList(),
      nullableTexts: (json['nullableTexts'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      twoDimensionList: (json['towDimensionList'] as List<dynamic>)
          .map(
            (item) =>
                (item as List<dynamic>).map((item) => item as String).toList(),
          )
          .toList(),
      geoPoint: json['geoPoint'] as GeoPoint,
      foo: json['foo'] as Foo? ?? const Foo('bar'),
    );
  }

  factory Person.fromDocumentSnapshot(DocumentSnapshot ds) {
    final data = ds.data()! as Map<String, dynamic>;
    return Person.fromJson(<String, dynamic>{
      ...data,
      'entityId': ds.id,
    });
  }

  final String name;
  final String? nullableText;
  final int age;
  final bool isAdult;
  final Map<String, dynamic> map;
  final List<String> texts;
  final List<String>? nullableTexts;
  final List<List<String>> twoDimensionList;
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
      'geoPoint': geoPoint,
      'foo': foo,
    };
  }

  Person copyWith({
    String? name,
    String? nullableText,
    int? age,
    bool? isAdult,
    Map<String, dynamic>? map,
    List<String>? texts,
    GeoPoint? geoPoint,
    Foo? foo,
  }) {
    return Person(
      name: name ?? this.name,
      nullableText: nullableText ?? this.nullableText,
      age: age ?? this.age,
      isAdult: isAdult ?? this.isAdult,
      map: map ?? this.map,
      texts: texts ?? this.texts,
      geoPoint: geoPoint ?? this.geoPoint,
      foo: foo ?? this.foo,
    );
  }
}

class Foo {
  const Foo(this.bar);

  final String bar;
}
