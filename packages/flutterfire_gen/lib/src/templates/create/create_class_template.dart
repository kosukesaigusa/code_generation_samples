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
  ${_parseConstructor()}

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

  String _parseConstructor() {
    final fields = _parseConstructorFields();
    if (fields.isEmpty) {
      return 'const ${config.createClassName}();';
    }
    return '''
const ${config.createClassName}({
  ${_parseConstructorFields()}
});
''';
  }

  // TODO: 可読性、テスト対象を定める意味でリファクタできそう
  String _parseConstructorFields() {
    return effectiveEntries.map((entry) {
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
    }).join('\n');
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
        if (isFieldValueAllowed) {
          return 'this.$fieldNameString = const ActualValue($defaultValueString),';
        } else {
          return 'this.$fieldNameString = $defaultValueString,';
        }
      } else {
        return 'this.$fieldNameString,';
      }
    } else {
      return 'required this.$fieldNameString,';
    }
  }

  String _parseFields() {
    return effectiveEntries.map((entry) {
      final fieldNameString = entry.key;
      final typeNameString = entry.value;
      final nullableTypeMatch = RegExp(r'(\w+)\?').firstMatch(typeNameString);
      final isFieldValueAllowed =
          visitor.fieldValueAllowedFields.contains(entry.key);

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

  ///
  Iterable<MapEntry<String, String>> get effectiveEntries =>
      fields.entries.where(
        (entry) => !visitor.alwaysUseFieldValueServerTimestampWhenCreatingFields
            .contains(
          entry.key,
        ),
      );
}
