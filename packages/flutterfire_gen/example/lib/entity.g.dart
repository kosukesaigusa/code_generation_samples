// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entity.dart';

// **************************************************************************
// Generator: FlutterFireGen
// **************************************************************************

class EntityFlutterFireGen {
  const EntityFlutterFireGen({
    required this.name,
    required this.age,
    required this.isAdult,
    required this.foo,
  });

  final String name;
  final int age;
  final bool isAdult;
  final Foo foo;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'isAdult': isAdult,
      'foo': foo,
    };
  }

  factory EntityFlutterFireGen.fromJson(Map<String, dynamic> json) {
    return EntityFlutterFireGen(
      name: json['name'] as String,
      age: json['age'] as int,
      isAdult: json['isAdult'] as bool? ?? false,
      foo: json['foo'] as Foo? ?? const Foo('bar'),
    );
  }

  factory EntityFlutterFireGen.fromDocumentSnapshot(DocumentSnapshot ds) {
    final data = ds.data()! as Map<String, dynamic>;
    return EntityFlutterFireGen.fromJson(<String, dynamic>{
      ...data,
      'entityId': ds.id,
    });
  }

  EntityFlutterFireGen copyWith({
    String? name,
    int? age,
    bool? isAdult,
    Foo? foo,
  }) {
    return EntityFlutterFireGen(
      name: name ?? this.name,
      age: age ?? this.age,
      isAdult: isAdult ?? this.isAdult,
      foo: foo ?? this.foo,
    );
  }
}
