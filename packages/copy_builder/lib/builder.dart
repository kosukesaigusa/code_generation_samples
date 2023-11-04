import 'package:build/build.dart';

/// A [Builder] which copies .dart files to .copy.dart files.
Builder copyBuilder(BuilderOptions _) => CopyBuilder();

/// A really simple [Builder], it just makes copies of .copy.dart files from
/// original .dart ones.
class CopyBuilder implements Builder {
  @override
  final buildExtensions = const {
    '.dart': ['.copy.dart'],
  };

  @override
  Future<void> build(BuildStep buildStep) async {
    final inputId = buildStep.inputId;
    final copy = inputId.changeExtension('.copy.dart');
    final contents = await buildStep.readAsString(inputId);
    await buildStep.writeAsString(copy, contents);
  }
}
