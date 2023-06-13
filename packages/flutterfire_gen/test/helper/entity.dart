import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfire_gen_annotation/flutterfire_gen_annotation.dart';

part 'entity.g.dart';

@FirestoreDocument(collectionName: 'entity', documentName: 'entityName')
class Entity {
  Entity({
    required this.name,
    required this.lastName,
    required this.isAdult,
    required this.age,
  });
  String name;
  String lastName;
  bool isAdult;
  int age;
}
