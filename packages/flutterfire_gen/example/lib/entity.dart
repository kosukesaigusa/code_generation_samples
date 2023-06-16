import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfire_gen_annotation/flutterfire_gen_annotation.dart';

part 'entity.g.dart';

@FirestoreDocument(collectionName: 'entities', documentName: 'entity')
class Entity {
  const Entity({
    required this.name,
    required this.age,
    required this.isAdult,
    this.nullableInt,
    this.nullableText,
    required this.foo,
  });

  /// A [String] type field.
  final String name;

  /// An [int] type field.
  final int age;

  /// A [bool] type field.
  @Default(false)
  final bool isAdult;

  /// A nullable type field.
  final int? nullableInt;

  /// A nullable type, but [Default] value specified field.
  @Default('defaultText')
  final String? nullableText;

  /// A self-defined [Foo] type field.
  @Default(Foo('bar'))
  final Foo foo;
}

class Foo {
  const Foo(this.bar);

  final String bar;
}
