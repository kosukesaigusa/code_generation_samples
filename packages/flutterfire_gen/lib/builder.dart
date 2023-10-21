import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/flutterfire_gen.dart';

/// Builds generators for `build_runner` to run.
Builder flutterfireGenBuilder(BuilderOptions options) => PartBuilder(
      [FlutterFireGen()],
      '.flutterfire_gen.dart',
      header: '''
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark
''',
      options: options,
    );
