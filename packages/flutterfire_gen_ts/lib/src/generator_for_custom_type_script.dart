import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:flutterfire_gen_ts_annotation/flutterfire_gen_ts_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'custom_typescript_document_visitor.dart';
import 'utils/type_converter.dart';

/// A generator for [CustomTypeScript] annotation.
class GeneratorForCustomTypeScript
    extends GeneratorForAnnotation<CustomTypeScript> {
  /// A [CustomTypeScriptVisitor].
  final visitor = CustomTypeScriptVisitor();

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    element.visitChildren(visitor);

    const matcher = TypeChecker.fromRuntime(CustomTypeScript);
    final firestoreDocumentAnnotation = element.metadata.where((meta) {
      final obj = meta.computeConstantValue();
      if (obj == null) {
        return false;
      }
      return matcher.isExactlyType(obj.type!);
    }).firstOrNull;

    if (firestoreDocumentAnnotation == null) {
      throw InvalidGenerationSourceError(
        'No @CustomTypeScript annotation is found. '
        'Failing element: ${element.name}',
        element: element,
      );
    }

    final source = firestoreDocumentAnnotation.toSource();

    final isEnum = _isEnum(element: element, source: source);

    if (isEnum) {
      return '''
export type $_className = ${_enumEffectiveEntries(_fields).map((entry) => "'${entry.key}'").join(' | ')}
''';
    } else if (_fields.isEmpty) {
      return 'export class $_className {}';
    } else {
      return '''
export class $_className {
  constructor({
    ${_fields.entries.map((entry) => '${entry.key},').join('\n')}
  }: {
    ${_fields.entries.map((entry) {
        return toTypeScriptFieldDefinitionString(
          dartTypeNameString: entry.value,
          dartFieldNameString: entry.key,
        );
      }).join('\n')}
  }) {
    ${_fields.entries.map((entry) => 'this.${entry.key} = ${entry.key}').join('\n')}
  }

  ${_fields.entries.map((entry) {
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
        RegExp(CustomTypeScript.isEnumRegExpSource).firstMatch(source);
    if (match == null) {
      return false;
    }
    return match.group(1) == 'true';
  }

  String get _className => visitor.className;

  Map<String, Map<String, String>> get _fieldsByClassName =>
      visitor.fieldsByClassName;

  Map<String, String> get _fields => _fieldsByClassName[_className] ?? {};

  Iterable<MapEntry<String, String>> _enumEffectiveEntries(
    Map<String, String> fields,
  ) =>
      fields.entries.where((entry) => entry.key != 'values');
}
