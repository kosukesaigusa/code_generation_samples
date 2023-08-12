// ignore_for_file: lines_longer_than_80_chars

import '../../config.dart';
import '../../firestore_document_visitor.dart';
import '../../utils/type_converter.dart';
import 'to_json_template.dart';

///
class CreateClassTemplate {
  ///
  const CreateClassTemplate({
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

  // TODO: デフォルト値, undefined 許容の扱いをどうするか考える
  @override
  String toString() {
    return '''
export class ${config.createClassName} {
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
      defaultValueStrings: visitor.createDefaultValueStrings,
      fieldValueAllowedFields: visitor.fieldValueAllowedFields,
      alwaysUseFieldValueServerTimestampWhenCreatingFields:
          visitor.alwaysUseFieldValueServerTimestampWhenCreatingFields,
      jsonConverterConfigs: visitor.jsonConverterConfigs,
    )}
}
''';
  }

  // TODO: 可読性、テスト対象を定める意味でリファクタできそう
  String _parseConstructorFields() {
    return '${fields.entries.map((entry) {
      final fieldNameString = entry.key;
      final typeNameString = entry.value;

      final defaultValueStrings = visitor.createDefaultValueStrings;
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
    final isNullable = typeNameString.endsWith('?');
    if (hasDefaultValue || isNullable) {
      if (hasDefaultValue) {
        // TODO: いったん FieldValue は無視
        // if (isFieldValueAllowed) {
        //   return 'this.$fieldNameString = const ActualValue($defaultValueString)';
        // }
        return '$fieldNameString = $defaultValueString';
      }
      return fieldNameString;
    }
    return fieldNameString;
  }

  // String _parseFields() {
  //   return fields.entries.map((entry) {
  //     final fieldNameString = entry.key;
  //     final typeNameString = entry.value;
  //     final nullableTypeMatch = RegExp(r'(\w+)\?').firstMatch(typeNameString);
  //     final isFieldValueAllowed =
  //         visitor.fieldValueAllowedFields.contains(entry.key);

  //     // TODO: いったん FieldValue は無視
  //     // if (isFieldValueAllowed) {
  //     //   if (nullableTypeMatch != null) {
  //     //     final type = nullableTypeMatch.group(1)!;
  //     //     return 'final FirestoreData<$type>? $fieldNameString;';
  //     //   } else {
  //     //     return 'final FirestoreData<$typeNameString> $fieldNameString;';
  //     //   }
  //     // } else {
  //     //   return 'final $typeNameString $fieldNameString;';
  //     // }
  //     return 'readonly $fieldNameString: $typeNameString';
  //   }).join('\n');
  // }
}
