// ignore_for_file: lines_longer_than_80_chars

import '../../config.dart';
import '../../firestore_document_visitor.dart';
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

  @override
  String toString() {
    return '''
class ${config.createClassName} {
  const ${config.createClassName}({
    ${_parseConstructorFields()}
  });

  ${_parseFields()}

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
    return fields.entries.map((entry) {
      final fieldNameString = entry.key;
      final typeNameString = entry.value;

      final defaultValueStrings = visitor.createDefaultValueStrings;
      final isFieldValueAllowed =
          visitor.fieldValueAllowedFields.contains(entry.key);
      final alwaysUseFieldValueServerTimestamp =
          visitor.alwaysUseFieldValueServerTimestampWhenCreatingFields.contains(
        entry.key,
      );

      final defaultValueString = defaultValueStrings[fieldNameString];
      return _constructorEachField(
        fieldNameString: fieldNameString,
        typeNameString: typeNameString,
        defaultValueString: defaultValueString,
        isFieldValueAllowed: isFieldValueAllowed,
        alwaysUseFieldValueServerTimestamp: alwaysUseFieldValueServerTimestamp,
      );
    }).join('\n');
  }

  String _constructorEachField({
    required String fieldNameString,
    required String typeNameString,
    required String? defaultValueString,
    required bool isFieldValueAllowed,
    required bool alwaysUseFieldValueServerTimestamp,
  }) {
    final hasDefaultValue = (defaultValueString ?? '').isNotEmpty;
    final isNullable = typeNameString.endsWith('?');
    if (alwaysUseFieldValueServerTimestamp) {
      return '';
    }
    if (hasDefaultValue || isNullable) {
      if (hasDefaultValue) {
        if (isFieldValueAllowed) {
          return 'this.$fieldNameString = const ActualValue($defaultValueString),';
        }
        return 'this.$fieldNameString = $defaultValueString,';
      }
      return 'this.$fieldNameString,';
    }
    return 'required this.$fieldNameString,';
  }

  String _parseFields() {
    return fields.entries.map((entry) {
      final fieldNameString = entry.key;
      final typeNameString = entry.value;
      final nullableTypeMatch = RegExp(r'(\w+)\?').firstMatch(typeNameString);
      final isFieldValueAllowed =
          visitor.fieldValueAllowedFields.contains(entry.key);
      final alwaysUseFieldValueServerTimestamp =
          visitor.alwaysUseFieldValueServerTimestampWhenCreatingFields.contains(
        entry.key,
      );

      if (alwaysUseFieldValueServerTimestamp) {
        return '';
      }
      if (isFieldValueAllowed) {
        if (nullableTypeMatch != null) {
          final type = nullableTypeMatch.group(1)!;
          return 'final FirestoreData<$type>? $fieldNameString;';
        } else {
          return 'final FirestoreData<$typeNameString> $fieldNameString;';
        }
      } else {
        return 'final $typeNameString $fieldNameString;';
      }
    }).join('\n');
  }
}
