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
    'nullableInteger': null,
    'doubleNumber': 3.14,
    'nullableDoubleNumber': null,
    'isBool': true,
    'nullableIsBool': null,
    'texts': ['a', 'b', 'c'],
    'nullableTexts': null,
    'map': <String, dynamic>{
      'text': 'text',
      'nullableText': null,
      'integer': 40,
      'nullableInteger': null,
      'doubleNumber': 3.14,
      'nullableDoubleNumber': null,
      'isBool': true,
      'nullableIsBool': null,
      'texts': ['a', 'b', 'c'],
      'nullableTexts': null,
      'geoPoint': const GeoPoint(0, 0),
      'nullableGeoPoint': null,
      'dateTime': DateTime.now(),
      'nullableDateTime': null,
      'timestamp': Timestamp.now(),
      'nullableTimestamp': null,
      'documentReference': fakeDb.collection('a').doc('b'),
      'nullableDocumentReference': null,
    },
    'nullableMap': null,
    'stringMap': <String, String>{},
    'nullableStringMap': null,
    'nestedMap': <String, Map<String, int>>{},
    'nullableNestedMap': null,
    'listMap': <String, List<int>>{},
    'nullableListMap': null,
    'mapList': <Map<String, int>>[],
    'nullableMapList': null,
    'geoPoint': const GeoPoint(0, 0),
    'nullableGeoPoint': null,
    'dateTime': DateTime.now(),
    'nullableDateTime': null,
    'timestamp': Timestamp.now(),
    'nullableTimestamp': null,
    'documentReference': fakeDb.collection('a').doc('b'),
    'nullableDocumentReference': null,
    'foo': <String, dynamic>{'bar': 'bar'},
    'nullableFoo': null,
  };
  final query = EntityQuery();

  test('test', () async {
    final ref = await fakeDb.collection('entities').add(data);
    final json = (await ref.get()).data();
    print(json);

    final entity = await query.fetchDocument(entityId: ref.id);
    print(entity);
  });

  group('test fromJsonTemplate', () {
    final template = FromJsonTemplate(
      readClassName: '',
      fields: {},
      defaultValueStrings: {},
      jsonConverterConfigs: {},
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

    test('parse int?', () {
      final result = template.fromJsonEachField(
        fieldNameString: 'nullableInteger',
        typeNameString: 'int?',
        defaultValueString: '0',
      );
      expect(
        result,
        "nullableInteger: json['nullableInteger'] as int? ?? 0",
      );
    });

    test('parse double', () {
      final result = template.fromJsonEachField(
        fieldNameString: 'doubleNumber',
        typeNameString: 'double',
      );
      expect(
        result,
        "doubleNumber: json['doubleNumber'] as double",
      );
    });

    test('parse double?', () {
      final result = template.fromJsonEachField(
        fieldNameString: 'nullableDoubleNumber',
        typeNameString: 'double?',
        defaultValueString: '0.0',
      );
      expect(
        result,
        "nullableDoubleNumber: json['nullableDoubleNumber'] as double? ?? 0.0",
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
        fieldNameString: 'nullableIsBool',
        typeNameString: 'bool?',
        defaultValueString: 'false',
      );
      expect(
        result,
        "nullableIsBool: json['nullableIsBool'] as bool? ?? false",
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
        defaultValueString: '<String, dynamic>{}',
      );
      expect(
        result,
        "nullableMap: json['nullableMap'] as Map<String, dynamic>? ?? <String, dynamic>{}",
      );
    });

    test('parse Map<String, String>', () {
      final result = template.fromJsonEachField(
        fieldNameString: 'stringMap',
        typeNameString: 'Map<String, String>',
      );
      expect(
        result,
        "stringMap: (json['stringMap'] as Map<String, dynamic>).map((k, v) => MapEntry(k, v as String))",
      );
    });

    test('parse Map<String, String>?', () {
      final result = template.fromJsonEachField(
        fieldNameString: 'nullableStringMap',
        typeNameString: 'Map<String, string>?',
        defaultValueString: '<String, String>{}',
      );
      expect(
        result,
        "nullableStringMap: (json['nullableStringMap'] as Map<String, dynamic>?)?.map((k, v) => MapEntry(k, v as string)) ?? <String, String>{}",
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
        defaultValueString: '<String, Map<String, int>>{}',
      );
      expect(
        result,
        "nullableNestedMap: (json['nullableNestedMap'] as Map<String, dynamic>?)?.map((k, v) => MapEntry(k, (v as Map<String, dynamic>).map((k, v) => MapEntry(k, v as int)))) ?? <String, Map<String, int>>{}",
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
        defaultValueString: '<String, List<int>>{}',
      );
      expect(
        result,
        "nullableListMap: (json['nullableListMap'] as Map<String, dynamic>?)?.map((k, v) => MapEntry(k, (v as List<dynamic>).map((e) => e as int).toList())) ?? <String, List<int>>{}",
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
        defaultValueString: 'Map<String, int>>[]',
      );
      expect(
        result,
        "nullableMapList: (json['nullableMapList'] as List<dynamic>?)?.map((e) => (e as Map<String, dynamic>).map((k, v) => MapEntry(k, v as int))).toList() ?? Map<String, int>>[]",
      );
    });

    test('parse Map<String, Map<String, int>>', () {
      final result = template.fromJsonEachField(
        fieldNameString: 'nestedMapMap',
        typeNameString: 'Map<String, Map<String, int>>',
      );
      expect(
        result,
        "nestedMapMap: (json['nestedMapMap'] as Map<String, dynamic>).map((k, v) => MapEntry(k, (v as Map<String, dynamic>).map((k, v) => MapEntry(k, v as int))))",
      );
    });

    test('parse Map<String, Map<String, int>>?', () {
      final result = template.fromJsonEachField(
        fieldNameString: 'nullableNestedMapMap',
        typeNameString: 'Map<String, Map<String, int>>?',
        defaultValueString: '<String, Map<String, int>>{}',
      );
      expect(
        result,
        "nullableNestedMapMap: (json['nullableNestedMapMap'] as Map<String, dynamic>?)?.map((k, v) => MapEntry(k, (v as Map<String, dynamic>).map((k, v) => MapEntry(k, v as int)))) ?? <String, Map<String, int>>{}",
      );
    });

    test('parse List<Map<String, int>>', () {
      final result = template.fromJsonEachField(
        fieldNameString: 'nestedListMap',
        typeNameString: 'List<Map<String, int>>',
      );
      expect(
        result,
        "nestedListMap: (json['nestedListMap'] as List<dynamic>).map((e) => (e as Map<String, dynamic>).map((k, v) => MapEntry(k, v as int))).toList()",
      );
    });

    test('parse List<Map<String, int>>?', () {
      final result = template.fromJsonEachField(
        fieldNameString: 'nullableNestedListMap',
        typeNameString: 'List<Map<String, int>>?',
        defaultValueString: '<Map<String, int>>[]',
      );
      expect(
        result,
        "nullableNestedListMap: (json['nullableNestedListMap'] as List<dynamic>?)?.map((e) => (e as Map<String, dynamic>).map((k, v) => MapEntry(k, v as int))).toList() ?? <Map<String, int>>[]",
      );
    });

    test('parse Map<String, Map<String, Map<String, int>>>', () {
      final result = template.fromJsonEachField(
        fieldNameString: 'mapNestedMap',
        typeNameString: 'Map<String, Map<String, Map<String, int>>>',
      );
      expect(
        result,
        "mapNestedMap: (json['mapNestedMap'] as Map<String, dynamic>).map((k, v) => MapEntry(k, (v as Map<String, dynamic>).map((k, v) => MapEntry(k, (v as Map<String, dynamic>).map((k, v) => MapEntry(k, v as int))))))",
      );
    });

    test('parse Map<String, Map<String, Map<String, int>>>?', () {
      final result = template.fromJsonEachField(
        fieldNameString: 'nullableMapNestedMap',
        typeNameString: 'Map<String, Map<String, Map<String, int>>>?',
        defaultValueString: '<String, Map<String, Map<String, int>>{}',
      );
      expect(
        result,
        "nullableMapNestedMap: (json['nullableMapNestedMap'] as Map<String, dynamic>?)?.map((k, v) => MapEntry(k, (v as Map<String, dynamic>).map((k, v) => MapEntry(k, (v as Map<String, dynamic>).map((k, v) => MapEntry(k, v as int)))))) ?? <String, Map<String, Map<String, int>>{}",
      );
    });

    test('parse List<Map<String, Map<String, int>>>', () {
      final result = template.fromJsonEachField(
        fieldNameString: 'listMapMap',
        typeNameString: 'List<Map<String, Map<String, int>>>',
      );
      expect(
        result,
        "listMapMap: (json['listMapMap'] as List<dynamic>).map((e) => (e as Map<String, dynamic>).map((k, v) => MapEntry(k, (v as Map<String, dynamic>).map((k, v) => MapEntry(k, v as int))))).toList()",
      );
    });

    test('parse List<Map<String, Map<String, int>>>?', () {
      final result = template.fromJsonEachField(
        fieldNameString: 'nullableListMapMap',
        typeNameString: 'List<Map<String, Map<String, int>>>?',
        defaultValueString: '<Map<String, Map<String, int>>>[]',
      );
      expect(
        result,
        "nullableListMapMap: (json['nullableListMapMap'] as List<dynamic>?)?.map((e) => (e as Map<String, dynamic>).map((k, v) => MapEntry(k, (v as Map<String, dynamic>).map((k, v) => MapEntry(k, v as int))))).toList() ?? <Map<String, Map<String, int>>>[]",
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

    test('parse DateTime', () {
      final result = template.fromJsonEachField(
        fieldNameString: 'dateTime',
        typeNameString: 'DateTime',
      );
      expect(
        result,
        "dateTime: (json['dateTime'] as Timestamp).toDate()",
      );
    });

    test('parse DateTime?', () {
      final result = template.fromJsonEachField(
        fieldNameString: 'nullableDateTime',
        typeNameString: 'DateTime?',
      );
      expect(
        result,
        "nullableDateTime: (json['nullableDateTime'] as Timestamp?)?.toDate()",
      );
    });

    test('parse Timestamp', () {
      final result = template.fromJsonEachField(
        fieldNameString: 'timestamp',
        typeNameString: 'Timestamp',
      );
      expect(
        result,
        "timestamp: json['timestamp'] as Timestamp",
      );
    });

    test('parse Timestamp?', () {
      final result = template.fromJsonEachField(
        fieldNameString: 'nullableTimestamp',
        typeNameString: 'Timestamp?',
      );
      expect(
        result,
        "nullableTimestamp: json['nullableTimestamp'] as Timestamp?",
      );
    });

    test('parse DocumentReference<Object?>', () {
      final result = template.fromJsonEachField(
        fieldNameString: 'documentReference',
        typeNameString: 'DocumentReference<Object?>',
      );
      expect(
        result,
        "documentReference: json['documentReference'] as DocumentReference<Object?>",
      );
    });

    test('parse DocumentReference<Object?>?', () {
      final result = template.fromJsonEachField(
        fieldNameString: 'nullableDocumentReference',
        typeNameString: 'DocumentReference<Object?>?',
      );
      expect(
        result,
        "nullableDocumentReference: json['nullableDocumentReference'] as DocumentReference<Object?>?",
      );
    });
  });
}
