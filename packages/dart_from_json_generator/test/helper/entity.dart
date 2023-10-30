import 'package:dart_from_json_generator_annotation/dart_from_json_generator_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'entity.dart_from_json_generator.dart';

@FromJson()
class Entity {
  Entity({
    required this.text,
    required this.textWithDefault,
    this.nullableText,
    required this.integer,
    required this.integerWithDefault,
    this.nullableInteger,
    required this.doubleNumber,
    required this.doubleNumberWithDefault,
    this.nullableDoubleNumber,
    required this.isBool,
    required this.isBoolWithDefault,
    this.nullableIsBool,
    required this.texts,
    required this.textsWithDefault,
    this.nullableTexts,
    required this.map,
    required this.mapWithDefault,
    this.nullableMap,
    this.nullableMapWithDefault,
    required this.stringMap,
    required this.stringMapWithDefault,
    this.nullableStringMap,
    required this.nestedMap,
    required this.nestedMapWithDefault,
    this.nullableNestedMap,
    required this.listMap,
    required this.listMapWithDefault,
    this.nullableListMap,
    required this.mapList,
    required this.mapListWithDefault,
    this.nullableMapList,
    required this.foo,
    required this.fooWithDefault,
    this.nullableFoo,
    this.nullableFooWithDefaultAnnotation,
  });

  final String text;

  @Default('requiredWithDefault')
  final String textWithDefault;

  @Default('defaultText')
  final String? nullableText;

  final int integer;

  @Default(0)
  final int integerWithDefault;

  @Default(0)
  final int? nullableInteger;

  final double doubleNumber;

  @Default(3.14)
  final double doubleNumberWithDefault;

  @Default(3.14)
  final double? nullableDoubleNumber;

  final bool isBool;

  @Default(false)
  final bool isBoolWithDefault;

  @Default(false)
  final bool? nullableIsBool;

  final List<String> texts;

  @Default(<String>['requiredWithDefault'])
  final List<String> textsWithDefault;

  @Default(<String>[])
  final List<String>? nullableTexts;

  final Map<String, dynamic> map;

  @Default(<String, dynamic>{})
  final Map<String, dynamic> mapWithDefault;

  final Map<String, dynamic>? nullableMap;

  @Default(<String, dynamic>{})
  final Map<String, dynamic>? nullableMapWithDefault;

  final Map<String, String> stringMap;

  @Default(<String, String>{})
  final Map<String, String> stringMapWithDefault;

  @Default(<String, String>{})
  final Map<String, String>? nullableStringMap;

  final Map<String, Map<String, int>> nestedMap;

  @Default(
    <String, Map<String, int>>{'requiredWithDefault': <String, int>{}},
  )
  final Map<String, Map<String, int>> nestedMapWithDefault;

  @Default(<String, Map<String, int>>{})
  final Map<String, Map<String, int>>? nullableNestedMap;

  final Map<String, List<int>> listMap;

  @Default(<String, List<int>>{'requiredWithDefault': <int>[]})
  final Map<String, List<int>> listMapWithDefault;

  @Default(<String, List<int>>{})
  final Map<String, List<int>>? nullableListMap;

  final List<Map<String, int>> mapList;

  @Default(<Map<String, int>>[
    <String, int>{'requiredWithDefault': 0},
  ])
  final List<Map<String, int>> mapListWithDefault;

  @Default(<Map<String, int>>[])
  final List<Map<String, int>>? nullableMapList;

  @_FooJsonConverter()
  final Foo foo;

  @Default(Foo('requiredWithDefault'))
  @_FooJsonConverter()
  final Foo fooWithDefault;

  @_nullableFooJsonConverter
  final Foo? nullableFoo;

  @Default(Foo('defaultBar'))
  @_FooJsonConverter()
  final Foo? nullableFooWithDefaultAnnotation;
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
