import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfire_gen_annotation/flutterfire_gen_annotation.dart';

part 'app_user_post.flutterfire_gen.dart';

@FirestoreDocument(
  path: 'appUsers/{appUserId}/appUserPosts',
  documentName: 'appUserPost',
)
class AppUserPost {
  AppUserPost({required this.content});

  @Default('')
  final String content;
}
