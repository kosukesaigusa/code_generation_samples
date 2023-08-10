import 'package:flutterfire_gen_annotation/flutterfire_gen_annotation.dart';

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

  @ReadDefault('')
  @CreateDefault('')
  final String imageUrl;
}
