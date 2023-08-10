import '../../config.dart';
import '../../firestore_document_visitor.dart';
import '../../utils/type_converter.dart';
import 'to_json_template.dart';

///
class UpdateClassTemplate {
  /// Creates a [UpdateClassTemplate].
  const UpdateClassTemplate({
    required this.config,
    required this.visitor,
    required this.fields,
  });

  ///
  final FirestoreDocumentConfig config;

  ///
  final FirestoreDocumentVisitor visitor;

  ///
  final Map<String, String> fields;

  @override
  String toString() {
    return '''
export class ${config.updateClassName} {
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

  ${ToJsonTemplate(
      fields: fields,
      defaultValueStrings: visitor.updateDefaultValueStrings,
      jsonConverterConfigs: visitor.jsonConverterConfigs,
      fieldValueAllowedFields: visitor.fieldValueAllowedFields,
    )}
}
''';
  }

  // TODO: 可読性、テスト対象を定める意味でリファクタできそう
  String _parseConstructorFields() {
    return '${fields.entries.map((entry) {
      final fieldNameString = entry.key;
      final typeNameString = entry.value;

      final defaultValueStrings = visitor.updateDefaultValueStrings;
      final isFieldValueAllowed =
          visitor.fieldValueAllowedFields.contains(entry.key);

      final defaultValueString = defaultValueStrings[fieldNameString];
      return _constructorEachField(
        fieldNameString: fieldNameString,
        typeNameString: typeNameString,
        defaultValueString: defaultValueString,
        isFieldValueAllowed: isFieldValueAllowed,
      );
    }).join(',\n')},';
  }

  String _constructorEachField({
    required String fieldNameString,
    required String typeNameString,
    required String? defaultValueString,
    required bool isFieldValueAllowed,
  }) {
    final hasDefaultValue = (defaultValueString ?? '').isNotEmpty;
    if (hasDefaultValue) {
      if (isFieldValueAllowed) {
        return 'this.$fieldNameString = const ActualValue($defaultValueString)';
      }
      return 'this.$fieldNameString = $defaultValueString';
    }
    return 'this.$fieldNameString';
  }

  // String _parseFields() {
  //   return fields.entries.map((entry) {
  //     final fieldNameString = entry.key;
  //     final typeNameString = entry.value;
  //     final isFieldValueAllowed =
  //         visitor.fieldValueAllowedFields.contains(entry.key);
  //     // TODO: いったん FieldValue は無視
  //     // if (isFieldValueAllowed) {
  //     //   // TODO: typeNameString が nullable になる可能性はある？
  //     //   return 'final FirestoreData<$typeNameString>? $fieldNameString;';
  //     // } else {
  //     //   return 'final ${typeNameString.ensureNullable()} $fieldNameString;';
  //     // }
  //     // TODO: undefinedable に対応する
  //     return 'readonly $fieldNameString?: $typeNameString';
  //   }).join('\n');
  // }
}
