import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/flutterfire_gen.dart';

Builder flutterfireGen(BuilderOptions options) {
  return SharedPartBuilder(
    [FlutterFireGen()],
    'flutterfire_gen',
  );
}
