import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/flutterfire_gen.dart';

Builder flutterfireGen(BuilderOptions options) {
  // TODO: SharedPartBuilder, PartBuilder（freezed で使用されている）の違いや機能を詳しく調査する
  return SharedPartBuilder(
    [FlutterFireGen()],
    'flutterfire_gen',
  );
}
