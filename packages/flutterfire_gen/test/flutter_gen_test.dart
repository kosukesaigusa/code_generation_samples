// ignore_for_file: lines_longer_than_80_chars

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterfire_gen/src/templates/read/from_json_template.dart';

import 'helper/entity.dart';

void main() {
  final data = <String, dynamic>{
    'text': 'text',
    'nullableText': null,
    'integer': 40,
    'isBool': true,
    'isNullableBool': null,
    'map': {
      'text': 'text',
      'nullableText': null,
      'integer': 40,
      'isBool': true,
      'isNullableBool': null,
      'map': <String, dynamic>{},
      'texts': ['a', 'b', 'c'],
      'nullableTexts': null,
      'geoPoint': const GeoPoint(0, 0),
      // 'dateTime': DateTime.now(),
      // 'nullableDateTime': FieldValue.serverTimestamp(),
    },
    'texts': ['a', 'b', 'c'],
    'nullableTexts': null,
    'geoPoint': const GeoPoint(0, 0),
    // 'dateTime': DateTime.now(),
    // 'nullableDateTime': FieldValue.serverTimestamp(),
    // 'foo': const Foo('foo'),
  };
  final query = EntityQuery();

  test('test', () async {
    final ref = await fakeDb.collection('entities').add(data);
    final json = (await ref.get()).data();
    print(json);

    final a = (await fakeDb.collection('entities').doc(ref.id).get()).data();
    print(a);

    final aa = await fakeDb.collection('entities').doc(ref.id).get();
    final aaa = await readEntityDocumentReference(entityId: ref.id).get();
    final aaaa = await fakeDb.collection('entities').doc(ref.id).get();

    final b =
        (await readEntityDocumentReference(entityId: ref.id).get()).data();
    print(b);

    final entity = await query.fetchDocument(entityId: ref.id);
    print(entity);
  });

  group('test fromJsonTemplate', () {
    final template = FromJsonTemplate(
      readClassName: '',
      fields: {},
      defaultValues: {},
    );

    test('parse String', () {
      final result = template.fromJsonEachField(
        fieldNameString: 'text',
        typeNameString: 'String',
      );
      expect(
        result,
        "text: json['text'] as String",
      );
    });

    test('parse String?', () {
      final result = template.fromJsonEachField(
        fieldNameString: 'nullableText',
        typeNameString: 'String?',
        defaultValueString: "'defaultText'",
      );
      expect(
        result,
        "nullableText: json['nullableText'] as String? ?? 'defaultText'",
      );
    });

    test('parse int', () {
      final result = template.fromJsonEachField(
        fieldNameString: 'integer',
        typeNameString: 'int',
      );
      expect(
        result,
        "integer: json['integer'] as int",
      );
    });

    test('parse bool', () {
      final result = template.fromJsonEachField(
        fieldNameString: 'isBool',
        typeNameString: 'bool',
      );
      expect(
        result,
        "isBool: json['isBool'] as bool",
      );
    });

    test('parse bool?', () {
      final result = template.fromJsonEachField(
        fieldNameString: 'isNullableBool',
        typeNameString: 'bool?',
        defaultValueString: 'false',
      );
      expect(
        result,
        "isNullableBool: json['isNullableBool'] as bool? ?? false",
      );
    });

    test('parse List<String>', () {
      final result = template.fromJsonEachField(
        fieldNameString: 'texts',
        typeNameString: 'List<String>',
      );
      expect(
        result,
        "texts: (json['texts'] as List<dynamic>).map((e) => e as String).toList()",
      );
    });

    test('parse List<String>?', () {
      final result = template.fromJsonEachField(
        fieldNameString: 'nullableTexts',
        typeNameString: 'List<String>?',
        defaultValueString: '<String>[]',
      );
      expect(
        result,
        "nullableTexts: (json['nullableTexts'] as List<dynamic>?)?.map((e) => e as String).toList() ?? <String>[]",
      );
    });

    test('parse Map<String, dynamic>', () {
      final result = template.fromJsonEachField(
        fieldNameString: 'map',
        typeNameString: 'Map<String, dynamic>',
      );
      expect(
        result,
        "map: json['map'] as Map<String, dynamic>",
      );
    });

    test('parse Map<String, dynamic>?', () {
      final result = template.fromJsonEachField(
        fieldNameString: 'nullableMap',
        typeNameString: 'Map<String, dynamic>?',
        defaultValueString: '{}',
      );
      expect(
        result,
        "nullableMap: json['nullableMap'] as Map<String, dynamic>? ?? {}",
      );
    });

    test('parse Map<String, int>', () {
      final result = template.fromJsonEachField(
        fieldNameString: 'map',
        typeNameString: 'Map<String, int>',
      );
      expect(
        result,
        "map: (json['map'] as Map<String, dynamic>).map((k, v) => MapEntry(k, v as int))",
      );
    });

    test('parse Map<String, int>?', () {
      final result = template.fromJsonEachField(
        fieldNameString: 'nullableMap',
        typeNameString: 'Map<String, int>?',
        defaultValueString: '{}',
      );
      expect(
        result,
        "nullableMap: (json['nullableMap'] as Map<String, dynamic>?)?.map((k, v) => MapEntry(k, v as int)) ?? {}",
      );
    });

    test('parse Map<String, Map<String, int>>', () {
      final result = template.fromJsonEachField(
        fieldNameString: 'nestedMap',
        typeNameString: 'Map<String, Map<String, int>>',
      );
      expect(
        result,
        "nestedMap: (json['nestedMap'] as Map<String, dynamic>).map((k, v) => MapEntry(k, (v as Map<String, dynamic>).map((k, v) => MapEntry(k, v as int))))",
      );
    });

    test('parse Map<String, Map<String, int>>?', () {
      final result = template.fromJsonEachField(
        fieldNameString: 'nullableNestedMap',
        typeNameString: 'Map<String, Map<String, int>>?',
        defaultValueString: '{}',
      );
      expect(
        result,
        "nullableNestedMap: (json['nullableNestedMap'] as Map<String, dynamic>?)?.map((k, v) => MapEntry(k, (v as Map<String, dynamic>).map((k, v) => MapEntry(k, v as int)))) ?? {}",
      );
    });

    test('parse Map<String, List<int>>', () {
      final result = template.fromJsonEachField(
        fieldNameString: 'listMap',
        typeNameString: 'Map<String, List<int>>',
      );
      expect(
        result,
        "listMap: (json['listMap'] as Map<String, dynamic>).map((k, v) => MapEntry(k, (v as List<dynamic>).map((e) => e as int).toList()))",
      );
    });

    test('parse Map<String, List<int>>?', () {
      final result = template.fromJsonEachField(
        fieldNameString: 'nullableListMap',
        typeNameString: 'Map<String, List<int>>?',
        defaultValueString: '{}',
      );
      expect(
        result,
        "nullableListMap: (json['nullableListMap'] as Map<String, dynamic>?)?.map((k, v) => MapEntry(k, (v as List<dynamic>).map((e) => e as int).toList())) ?? {}",
      );
    });

    test('parse List<Map<String, int>>', () {
      final result = template.fromJsonEachField(
        fieldNameString: 'mapList',
        typeNameString: 'List<Map<String, int>>',
      );
      expect(
        result,
        "mapList: (json['mapList'] as List<dynamic>).map((e) => (e as Map<String, dynamic>).map((k, v) => MapEntry(k, v as int))).toList()",
      );
    });

    test('parse List<Map<String, int>>?', () {
      final result = template.fromJsonEachField(
        fieldNameString: 'nullableMapList',
        typeNameString: 'List<Map<String, int>>?',
        defaultValueString: '[]',
      );
      expect(
        result,
        "nullableMapList: (json['nullableMapList'] as List<dynamic>?)?.map((e) => (e as Map<String, dynamic>).map((k, v) => MapEntry(k, v as int))).toList() ?? []",
      );
    });

    test('parse GeoPoint', () {
      final result = template.fromJsonEachField(
        fieldNameString: 'geoPoint',
        typeNameString: 'GeoPoint',
      );
      expect(
        result,
        "geoPoint: json['geoPoint'] as GeoPoint",
      );
    });

    test('parse GeoPoint?', () {
      final result = template.fromJsonEachField(
        fieldNameString: 'nullableGeoPoint',
        typeNameString: 'GeoPoint?',
        defaultValueString: 'GeoPoint(0, 0)',
      );
      expect(
        result,
        "nullableGeoPoint: json['nullableGeoPoint'] as GeoPoint? ?? GeoPoint(0, 0)",
      );
    });
  });
}
