// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lines_longer_than_80_chars, text_direction_code_point_in_literal

part of 'entity.dart';

// **************************************************************************
// Generator: FlutterFireGen
// **************************************************************************

class EntityFlutterFireGen {
  const EntityFlutterFireGen({
    required this.name,
    required this.lastName,
    required this.isAdult,
    required this.age,
  });

  final String name;
  final String lastName;
  final bool isAdult;
  final int age;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'lastName': lastName,
      'isAdult': isAdult,
      'age': age,
    };
  }

  factory EntityFlutterFireGen.fromJson(Map<String, dynamic> json) {
    return EntityFlutterFireGen(
      name: json['name'] as String,
      lastName: json['lastName'] as String,
      isAdult: json['isAdult'] as bool,
      age: json['age'] as int,
    );
  }

  factory EntityFlutterFireGen.fromDocumentSnapshot(DocumentSnapshot ds) {
    final data = ds.data()! as Map<String, dynamic>;
    return EntityFlutterFireGen.fromJson(<String, dynamic>{
      ...data,
      'entityNameId': ds.id,
    });
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
