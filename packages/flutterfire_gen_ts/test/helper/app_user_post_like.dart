import 'package:flutterfire_gen_annotation/flutterfire_gen_annotation.dart';

@FirestoreDocument(
  path: 'appUsers/{appUserId}/appUserPosts/{appUserPostId}/appUserPostLikes',
  documentName: 'appUserPostLike',
)
class AppUserPostLike {
  AppUserPostLike({
    required this.likedByAppUserId,
    required this.stringWithDefaultValue,
    required this.nullableString,
    required this.nullableStringWithDefaultValue,
    this.likedAt,
  });

  final String likedByAppUserId;

  @ReadDefault('defaultText')
  final String stringWithDefaultValue;

  final String? nullableString;

  @ReadDefault('defaultText')
  final String? nullableStringWithDefaultValue;

  final DateTime? likedAt;
}
