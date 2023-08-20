import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:flutterfire_gen_ts_annotation/flutterfire_gen_ts_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'translate_to_typescript_document_visitor.dart';
import 'utils/type_converter.dart';

/// A generator for [TranslateToTypeScript] annotation.
class GeneratorForTranslateToTypeScript
    extends GeneratorForAnnotation<TranslateToTypeScript> {
  /// A [TranslateToTypeScriptVisitor].
  final visitor = TranslateToTypeScriptVisitor();

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    element.visitChildren(visitor);

    final className = visitor.className;
    final fieldsByClassName = visitor.fieldsByClassName;
    final fields = fieldsByClassName[className] ?? {};

    const matcher = TypeChecker.fromRuntime(TranslateToTypeScript);
    final translateToTypeScriptAnnotation = element.metadata.where((meta) {
      final obj = meta.computeConstantValue();
      if (obj == null) {
        return false;
      }
      return matcher.isExactlyType(obj.type!);
    }).firstOrNull;

    if (translateToTypeScriptAnnotation == null) {
      throw InvalidGenerationSourceError(
        'No @TranslateToTypeScript annotation is found. '
        'Failing element: ${element.name}',
        element: element,
      );
    }

    final source = translateToTypeScriptAnnotation.toSource();

    final isEnum = _isEnum(element: element, source: source);

    if (isEnum) {
      return '''
export type $className = ${_enumEffectiveEntries(fields).map((entry) => "'${entry.key}'").join(' | ')}
''';
    } else if (fields.isEmpty) {
      return 'export class $className {}';
    } else {
      return '''
export class $className {
  constructor({
    ${fields.entries.map((entry) => '${entry.key},').join('\n')}
  }: {
    ${fields.entries.map((entry) {
        return toTypeScriptFieldDefinitionString(
          dartTypeNameString: entry.value,
          dartFieldNameString: entry.key,
        );
      }).join('\n')}
  }) {
    ${fields.entries.map((entry) => 'this.${entry.key} = ${entry.key}').join('\n')}
  }

  ${fields.entries.map((entry) {
        return 'readonly ${toTypeScriptFieldDefinitionString(
          dartTypeNameString: entry.value,
          dartFieldNameString: entry.key,
        )}';
      }).join('\n\n')}
}
''';
    }
  }

  bool _isEnum({
    required Element element,
    required String source,
  }) {
    final match =
        RegExp(TranslateToTypeScript.isEnumRegExpSource).firstMatch(source);
    if (match == null) {
      return false;
    }
    return match.group(1) == 'true';
  }

  Iterable<MapEntry<String, String>> _enumEffectiveEntries(
    Map<String, String> fields,
  ) =>
      fields.entries.where((entry) => entry.key != 'values');
}
