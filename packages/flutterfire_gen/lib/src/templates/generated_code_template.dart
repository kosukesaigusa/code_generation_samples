import 'package:build/build.dart';
import 'package:dart_style/dart_style.dart';
import 'package:path/path.dart';

import 'comments/comments_template.dart';

/// A template for generating generated code.
class GeneratedCodeTemplate {
  /// Creates a [GeneratedCodeTemplate] instance.
  const GeneratedCodeTemplate({
    required this.generatedCode,
    required this.inputAssetId,
  });

  /// The generated code.
  final String generatedCode;

  /// The input asset id.
  final AssetId inputAssetId;

  @override
  String toString() {
    return DartFormatter().format('''
${CommentsTemplate()}

part of '${basename(inputAssetId.path)}';

$generatedCode
''');
  }
}
