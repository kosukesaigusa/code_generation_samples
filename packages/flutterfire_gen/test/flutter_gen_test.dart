import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterfire_gen/src/templates/read/from_json.dart';

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
