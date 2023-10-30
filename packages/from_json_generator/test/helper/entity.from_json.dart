// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'entity.dart';

// **************************************************************************
// FromJsonGenerator
// **************************************************************************

Entity _$EntityFromJson(Map<String, dynamic> json) => Entity(
      text: json['text'] as String,
      textWithDefault:
          json['textWithDefault'] as String? ?? 'requiredWithDefault',
      nullableText: json['nullableText'] as String? ?? 'defaultText',
      integer: json['integer'] as int,
      integerWithDefault: json['integerWithDefault'] as int? ?? 0,
      nullableInteger: json['nullableInteger'] as int? ?? 0,
      doubleNumber: json['doubleNumber'] as double,
      doubleNumberWithDefault:
          json['doubleNumberWithDefault'] as double? ?? 3.14,
      nullableDoubleNumber: json['nullableDoubleNumber'] as double? ?? 3.14,
      isBool: json['isBool'] as bool,
      isBoolWithDefault: json['isBoolWithDefault'] as bool? ?? false,
      nullableIsBool: json['nullableIsBool'] as bool? ?? false,
      texts: (json['texts'] as List<dynamic>).map((e) => e as String).toList(),
      textsWithDefault: (json['textsWithDefault'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>['requiredWithDefault'],
      nullableTexts: (json['nullableTexts'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      map: json['map'] as Map<String, dynamic>,
      mapWithDefault: json['mapWithDefault'] as Map<String, dynamic>? ??
          const <String, dynamic>{},
      nullableMap: json['nullableMap'] as Map<String, dynamic>?,
      nullableMapWithDefault:
          json['nullableMapWithDefault'] as Map<String, dynamic>? ??
              const <String, dynamic>{},
      stringMap: (json['stringMap'] as Map<String, dynamic>)
          .map((k, v) => MapEntry(k, v as String)),
      stringMapWithDefault:
          (json['stringMapWithDefault'] as Map<String, dynamic>?)
                  ?.map((k, v) => MapEntry(k, v as String)) ??
              const <String, String>{},
      nullableStringMap: (json['nullableStringMap'] as Map<String, dynamic>?)
              ?.map((k, v) => MapEntry(k, v as String)) ??
          const <String, String>{},
      nestedMap: (json['nestedMap'] as Map<String, dynamic>).map((k, v) =>
          MapEntry(
              k,
              (v as Map<String, dynamic>)
                  .map((k, v) => MapEntry(k, v as int)))),
      nestedMapWithDefault:
          (json['nestedMapWithDefault'] as Map<String, dynamic>?)?.map((k, v) =>
                  MapEntry(
                      k,
                      (v as Map<String, dynamic>)
                          .map((k, v) => MapEntry(k, v as int)))) ??
              const <String, Map<String, int>>{
                'requiredWithDefault': <String, int>{}
              },
      nullableNestedMap: (json['nullableNestedMap'] as Map<String, dynamic>?)
              ?.map((k, v) => MapEntry(
                  k,
                  (v as Map<String, dynamic>)
                      .map((k, v) => MapEntry(k, v as int)))) ??
          const <String, Map<String, int>>{},
      listMap: (json['listMap'] as Map<String, dynamic>).map((k, v) =>
          MapEntry(k, (v as List<dynamic>).map((e) => e as int).toList())),
      listMapWithDefault: (json['listMapWithDefault'] as Map<String, dynamic>?)
              ?.map((k, v) => MapEntry(
                  k, (v as List<dynamic>).map((e) => e as int).toList())) ??
          const <String, List<int>>{'requiredWithDefault': <int>[]},
      nullableListMap: (json['nullableListMap'] as Map<String, dynamic>?)?.map(
              (k, v) => MapEntry(
                  k, (v as List<dynamic>).map((e) => e as int).toList())) ??
          const <String, List<int>>{},
      mapList: (json['mapList'] as List<dynamic>)
          .map((e) =>
              (e as Map<String, dynamic>).map((k, v) => MapEntry(k, v as int)))
          .toList(),
      mapListWithDefault: (json['mapListWithDefault'] as List<dynamic>?)
              ?.map((e) => (e as Map<String, dynamic>)
                  .map((k, v) => MapEntry(k, v as int)))
              .toList() ??
          const <Map<String, int>>[
            <String, int>{'requiredWithDefault': 0}
          ],
      nullableMapList: (json['nullableMapList'] as List<dynamic>?)
              ?.map((e) => (e as Map<String, dynamic>)
                  .map((k, v) => MapEntry(k, v as int)))
              .toList() ??
          const <Map<String, int>>[],
      foo: _FooJsonConverter().fromJson(json['foo'] as Map<String, dynamic>),
      fooWithDefault: json['fooWithDefault'] == null
          ? const Foo('requiredWithDefault')
          : _FooJsonConverter()
              .fromJson(json['fooWithDefault'] as Map<String, dynamic>),
      nullableFoo: _nullableFooJsonConverter
          .fromJson(json['nullableFoo'] as Map<String, dynamic>),
      nullableFooWithDefaultAnnotation:
          json['nullableFooWithDefaultAnnotation'] == null
              ? const Foo('defaultBar')
              : _FooJsonConverter().fromJson(
                  json['nullableFooWithDefaultAnnotation']
                      as Map<String, dynamic>),
    );
