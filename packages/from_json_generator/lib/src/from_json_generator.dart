import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:from_json_generator_annotation/from_json_generator_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'configs/build_yaml_config.dart';
import 'configs/code_generation_config.dart';
import 'parsers/field_element_parser.dart';
import 'templates/from_json_template.dart';
import 'utils/dart_object_util.dart';

/// A generator for [FromJson] annotation.
class FromJsonGenerator extends GeneratorForAnnotation<FromJson> {
  /// Creates a new instance of [FromJsonGenerator].
  FromJsonGenerator(this._buildYamlConfig);

  /// A [BuildYamlConfig] instance.
  final BuildYamlConfig _buildYamlConfig;

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        '@FromJson can only be applied on classes. '
        'Failing element: ${element.name}',
        element: element,
      );
    }

    final annotation = const TypeChecker.fromRuntime(FromJson)
        .firstAnnotationOf(element, throwOnUnresolved: false)!;

    final config = CodeGenerationConfig(
      className: element.name,
      fieldConfigs: element.fields.map(parseFieldElement).toList(),
      convertSnakeCaseToCamelCase: annotation.decodeField<bool>(
        'convertSnakeToCamel',
        decode: (obj) => obj.toBoolValue()!,
        orElse: () => _buildYamlConfig.convertSnakeToCamel ?? false,
      ),
    );

    final buffer = StringBuffer()..writeln(FromJsonTemplate(config));

    return buffer.toString();
  }
}
