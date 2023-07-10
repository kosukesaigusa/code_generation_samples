import 'package:cloud_firestore/cloud_firestore.dart';
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
  });

  final String name;

  @FromJsonDefault('')
  final String imageUrl;
}
