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
  });

  final String name;
  final int age;
  final bool isAdult;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'isAdult': isAdult,
    };
  }

  factory EntityFlutterFireGen.fromJson(Map<String, dynamic> json) {
    return EntityFlutterFireGen(
      name: json['name'] as String,
      age: json['age'] as int,
      isAdult: json['isAdult'] as bool,
    );
  }

  EntityFlutterFireGen copyWith({
    String? name,
    int? age,
    bool? isAdult,
  }) {
    return EntityFlutterFireGen(
      name: name ?? this.name,
      age: age ?? this.age,
      isAdult: isAdult ?? this.isAdult,
    );
  }
}
