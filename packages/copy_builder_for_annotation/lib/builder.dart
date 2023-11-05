import 'package:build/build.dart';

/// A [Builder] which copies .dart files (annotated only) to .copy.dart files.
Builder copyBuilderForAnnotation(BuilderOptions _) =>
    CopyBuilderForAnnotation();

/// A really simple [Builder], it just makes copies of .copy.dart files from
/// original .dart ones for annotated classes.
class CopyBuilderForAnnotation implements Builder {
  @override
  final buildExtensions = const {
    '.dart': ['.copy.dart'],
  };

  @override
  Future<void> build(BuildStep buildStep) async {
    final inputId = buildStep.inputId;
    final outputId = inputId.changeExtension('.copy.dart');
    final contents = await buildStep.readAsString(inputId);
    await buildStep.writeAsString(outputId, contents);
  }
}
