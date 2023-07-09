import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfire_gen/src/templates/create/create.dart';
import 'package:flutterfire_gen_annotation/flutterfire_gen_annotation.dart';

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
}
