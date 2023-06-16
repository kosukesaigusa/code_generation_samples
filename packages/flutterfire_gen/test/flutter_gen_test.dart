import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

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

  test('aaa', () {
    final aaa = fromJsonEachField(
      fieldNameString: 'texts',
      typeNameString: 'List<String>',
    );
    print(aaa);
  });
}

String fromJsonEachField({
  required String fieldNameString,
  required String typeNameString,
  Object? defaultValue,
}) {
  final listItemType = typeNameString.substring(
    typeNameString.indexOf('<') + 1,
    typeNameString.indexOf('>'),
  );
  if (defaultValue != null) {
    // ignore: missing_whitespace_between_adjacent_strings
    return "$fieldNameString: (json['$fieldNameString'] as List<dynamic>?)?"
        '.map((e) => e as $listItemType).toList() ?? $defaultValue,';
  } else {
    // ignore: missing_whitespace_between_adjacent_strings
    return "$fieldNameString: (json['$fieldNameString'] as List<dynamic>)"
        '.map((e) => e as $listItemType).toList(),';
  }
}
