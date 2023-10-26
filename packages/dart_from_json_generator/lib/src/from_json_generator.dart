import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:dart_from_json_generator_annotation/dart_from_json_generator_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'configs/build_yaml_config.dart';
import 'configs/code_generation_config.dart';
import 'from_json_visitor.dart';
import 'templates/from_json_template.dart';

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

    final visitor = FromJsonVisitor();

    element.visitChildren(visitor);

    final annotation = const TypeChecker.fromRuntime(FromJson)
        .firstAnnotationOf(element, throwOnUnresolved: false)!;

    final config = CodeGenerationConfig(
      className: element.name,
      fields: visitor.fields,
      jsonConverterConfigs: visitor.jsonConverterConfigs,
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

extension on DartObject {
  T decodeField<T>(
    String fieldName, {
    required T Function(DartObject obj) decode,
    required T Function() orElse,
  }) {
    final field = getField(fieldName);
    if (field == null || field.isNull) {
      return orElse();
    }
    return decode(field);
  }
}
