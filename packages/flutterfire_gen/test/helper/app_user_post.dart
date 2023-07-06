import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfire_gen_annotation/flutterfire_gen_annotation.dart';

part 'app_user_post.flutterfire_gen.dart';

@FirestoreDocument(
  path: 'appUsers/{appUserId}/appUserPosts',
  documentName: 'appUserPost',
)
class AppUserPost {
  AppUserPost({
    required this.content,
    required this.numbers,
    this.updatedAt,
  });

  @Default('')
  final String content;

  @Default(<int>[])
  final List<int> numbers;

  // 書き込み時は常に自動でサーバ時間のつもり、そういう JsonConverter を指定するべきか
  final DateTime? updatedAt;
}
