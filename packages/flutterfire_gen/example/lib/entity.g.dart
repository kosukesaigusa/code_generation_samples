// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entity.dart';

// **************************************************************************
// Generator: FlutterFireGen
// **************************************************************************

class EntityFlutterFireGen {
  final String name;
  final String lastName;
  final bool isAdult;
  final int age;
  const EntityFlutterFireGen({
    required this.name,
    required this.lastName,
    required this.isAdult,
    required this.age,
  });
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'lastName': lastName,
      'isAdult': isAdult,
      'age': age,
    };
  }

  factory EntityFlutterFireGen.fromMap(Map<String, dynamic> map) {
    return EntityFlutterFireGen(
      name: map['name'],
      lastName: map['lastName'],
      isAdult: map['isAdult'],
      age: map['age'],
    );
  }
  EntityFlutterFireGen copyWith({
    String? name,
    String? lastName,
    bool? isAdult,
    int? age,
  }) {
    return EntityFlutterFireGen(
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      isAdult: isAdult ?? this.isAdult,
      age: age ?? this.age,
    );
  }
}
