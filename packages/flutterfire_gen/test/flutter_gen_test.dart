// ignore_for_file: lines_longer_than_80_chars

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterfire_gen/src/templates/read/from_json_template.dart';

import 'helper/entity.dart';

void main() {
  final db = FakeFirebaseFirestore();
  final data = <String, dynamic>{
    'name': 'name',
    'nullableText': 'nullableText',
    'age': 40,
    'isAdult': true,
    'map': {
      'name': 'name',
      'nullableText': 'nullableText',
      'age': 40,
      'isAdult': true,
      'texts': ['a', 'b', 'c'],
      'geoPoint': const GeoPoint(0, 0),
      'dateTime': DateTime.now(),
      'nullableDateTime': FieldValue.serverTimestamp(),
      // 'foo': const Foo('foo'),
    },
    'texts': ['a', 'b', 'c'],
    'geoPoint': const GeoPoint(0, 0),
    'dateTime': DateTime.now(),
    'nullableDateTime': FieldValue.serverTimestamp(),
    // 'foo': const Foo('foo'),
  };
  final query = EntityQuery();

  test('test', () {
    const a = 2 + 3;
    expect(a, 5);
  });

  test('test', () async {
    final ref = await db.collection('entities').add(data);
    final json = (await ref.get()).data();
    print(json);

    final a = (await db.collection('entities').doc(ref.id).get()).data();
    print(a);

    final b = (await db
            .collection('entities')
            .withConverter(
              fromFirestore: (ds, _) => ReadEntity.fromDocumentSnapshot(ds),
              toFirestore: (obj, _) => obj.toJson(),
            )
            .doc(ref.id)
            .get())
        .data();
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

    final params = [
      _FromJsonTemplateParamAndMatcher(
        fieldNameString: 'texts',
        typeNameString: 'List<String>',
        defaultValue: null,
        expected:
            "texts: (json['texts'] as List<dynamic>).map((e) => json['texts'] as String).toList(),",
      ),
      _FromJsonTemplateParamAndMatcher(
        fieldNameString: 'texts',
        typeNameString: 'List<String>',
        defaultValue: <String>[],
        expected:
            "texts: (json['texts'] as List<dynamic>).map((e) => json['texts'] as String ?? []).toList() ?? [],",
      ),
      _FromJsonTemplateParamAndMatcher(
        fieldNameString: 'twoDList',
        typeNameString: 'List<List<String>>',
        defaultValue: null,
        expected:
            "twoDList: (json['twoDList'] as List<dynamic>).map((e) => (json['twoDList'] as List<dynamic>).map((e) => json['twoDList'] as String).toList()).toList(),",
      ),
    ];

    test('parse various types', () {
      for (final p in params) {
        final result = template.fromJsonEachField(
          fieldNameString: p.fieldNameString,
          typeNameString: p.typeNameString,
          defaultValue: p.defaultValue,
        );
        expect(result, p.expected);
      }
    });
  });
}

class _FromJsonTemplateParamAndMatcher {
  _FromJsonTemplateParamAndMatcher({
    required this.fieldNameString,
    required this.typeNameString,
    required this.defaultValue,
    required this.expected,
  });

  final String fieldNameString;

  final String typeNameString;

  final Object? defaultValue;

  final String expected;
}
