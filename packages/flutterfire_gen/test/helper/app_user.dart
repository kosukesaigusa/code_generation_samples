import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfire_gen/src/templates/create/create.dart';
import 'package:flutterfire_gen_annotation/flutterfire_gen_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_user.flutterfire_gen.dart';

@FirestoreDocument(
  path: 'appUsers',
  documentName: 'appUser',
)
class AppUser {
  AppUser({
    required this.name,
    required this.imageUrl,
    this.nullableTextWithDefault,
    this.nullableTextWithoutDefault,
    required this.fieldValueAllowedInt,
    this.fieldValueAllowedNullableInt,
    this.fieldValueAllowedNullableIntWithDefaultAnnotation,
    this.fieldValueAllowedNullableIntWithDefaultInConstructor = 0,
    required this.foo,
    this.nullableFoo,
    this.nullableFooWithDefaultAnnotation,
    this.nullableFooWithDefaultInConstructor = const Foo('bar'),
  });

  final String name;

  @Default('')
  final String imageUrl;

  @Default('')
  final String? nullableTextWithDefault;

  final String? nullableTextWithoutDefault;

  @AllowFieldValue()
  final int fieldValueAllowedInt;

  @AllowFieldValue()
  final int? fieldValueAllowedNullableInt;

  @AllowFieldValue()
  @Default(0)
  final int? fieldValueAllowedNullableIntWithDefaultAnnotation;

  @AllowFieldValue()
  final int? fieldValueAllowedNullableIntWithDefaultInConstructor;

  @_FooJsonConverter()
  final Foo foo;

  @_nullableFooJsonConverter
  final Foo? nullableFoo;

  @Default(Foo('bar'))
  @_FooJsonConverter()
  final Foo? nullableFooWithDefaultAnnotation;

  @_FooJsonConverter()
  final Foo? nullableFooWithDefaultInConstructor;
}

class Foo {
  const Foo(this.bar);

  final String bar;
}

class _FooJsonConverter implements JsonConverter<Foo, Map<String, dynamic>> {
  const _FooJsonConverter();

  @override
  Foo fromJson(Map<String, dynamic> json) {
    final bar = json['bar'] as String;
    return Foo(bar);
  }

  @override
  Map<String, dynamic> toJson(Foo foo) {
    return <String, dynamic>{'bar': foo.bar};
  }
}

const _nullableFooJsonConverter = _NullableFooJsonConverter();

class _NullableFooJsonConverter
    implements JsonConverter<Foo?, Map<String, dynamic>> {
  const _NullableFooJsonConverter();

  @override
  Foo? fromJson(Map<String, dynamic> json) {
    final bar = json['bar'] as String?;
    if (bar == null) {
      return null;
    }
    return Foo(bar);
  }

  @override
  Map<String, dynamic> toJson(Foo? foo) {
    if (foo == null) {
      return <String, dynamic>{'bar': 'defaultBar'};
    }
    return <String, dynamic>{'bar': foo.bar};
  }
}
