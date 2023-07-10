import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfire_gen_annotation/flutterfire_gen_annotation.dart';
import 'package:flutterfire_gen_utils/flutterfire_gen_utils.dart';

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

  @ReadDefault('')
  final String content;

  @ReadDefault(<int>[])
  @AllowFieldValue()
  final List<int> numbers;

  // 書き込み時は常に自動でサーバ時間のつもり、そういう JsonConverter を指定するべきか
  final DateTime? updatedAt;
}
