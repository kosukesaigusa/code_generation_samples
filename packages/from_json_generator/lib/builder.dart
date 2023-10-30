import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/configs/build_yaml_config.dart';
import 'src/from_json_generator.dart';

/// Builds generators for `build_runner` to run.
Builder fromJsonGenerator(BuilderOptions options) {
  return PartBuilder(
    [FromJsonGenerator(BuildYamlConfig.fromBuildYaml(options.config))],
    '.from_json.dart',
    header: '''
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark
''',
    options: options,
  );
}

/** 
Builder fromJsonGenerator(BuilderOptions options) => _FromJsonBuilder(options);

/// A [Builder] class of [FromJsonGenerator] code generator.
class _FromJsonBuilder implements Builder {
  _FromJsonBuilder(this._options);

  /// A [BuildYamlConfig] instance.
  final BuilderOptions _options;

  @override
  Map<String, List<String>> get buildExtensions => const {
        '.dart': ['.from_json.dart'],
      };

  @override
  Future<void> build(BuildStep buildStep) async {
    final inputAssetId = buildStep.inputId;
    final outputAssetId =
        inputAssetId.changeExtension('.from_json.dart');
    final library = await buildStep.inputLibrary;

    final generatedCode =
        await FromJsonGenerator(BuildYamlConfig.fromBuildYaml(_options.config))
            .generate(LibraryReader(library), buildStep);

    final formattedCode = DartFormatter().format(generatedCode);

    await buildStep.writeAsString(outputAssetId, formattedCode);
  }
}
*/
