import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfire_gen_annotation/flutterfire_gen_annotation.dart';

part 'entity.g.dart';

@FirestoreDocument(collectionName: 'entities', documentName: 'entity')
class Entity {
  const Entity({
    required this.name,
    required this.age,
    required this.isAdult,
    required this.foo,
  });

  final String name;

  final int age;

  @Default(false)
  final bool isAdult;

  @Default(Foo('bar'))
  final Foo foo;
}

class Foo {
  const Foo(this.bar);

  final String bar;
}
