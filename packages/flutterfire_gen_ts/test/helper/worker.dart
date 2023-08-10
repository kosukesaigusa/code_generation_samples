import 'package:flutterfire_gen_annotation/flutterfire_gen_annotation.dart';

@FirestoreDocument(path: 'workers', documentName: 'worker')
class Worker {
  const Worker({
    required this.displayName,
    required this.imageUrl,
    required this.isHost,
    // this.createdAt = const ServerTimestamp(),
    // this.updatedAt = const ServerTimestamp(),
  });

  @ReadDefault('')
  final String displayName;

  @ReadDefault('')
  final String imageUrl;

  @ReadDefault(false)
  final bool isHost;

  // // TODO: やや冗長になってしまっているのは、flutterfire_gen と
  // // flutterfire_json_converters の作りのため。それらのパッケージが更新されたら
  // // この実装も変更する。
  // @sealedTimestampConverter
  // @CreateDefault(ServerTimestamp())
  // final SealedTimestamp createdAt;

  // // TODO: やや冗長になってしまっているのは、flutterfire_gen と
  // // flutterfire_json_converters の作りのため。それらのパッケージが更新されたら
  // // この実装も変更する。
  // @alwaysUseServerTimestampSealedTimestampConverter
  // @CreateDefault(ServerTimestamp())
  // @UpdateDefault(ServerTimestamp())
  // final SealedTimestamp updatedAt;
}
