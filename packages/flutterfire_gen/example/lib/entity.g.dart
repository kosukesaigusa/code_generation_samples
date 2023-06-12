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
      name: json['name'] as String? ?? 'aaaaa',
      age: json['age'] as int,
      isAdult: json['isAdult'] as bool? ?? false,
      foo: json['foo'] as Foo? ?? const Foo('ba'),
    );
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
