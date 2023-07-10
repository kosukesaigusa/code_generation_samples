import '../../config.dart';
import '../../firestore_document_visitor.dart';

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
  final Map<String, dynamic> fields;

  @override
  String toString() {
    return '''
class ${config.createClassName} {
  const ${config.createClassName}({
    ${_parseConstructorFields()}
  });

  ${_parseFields()}

  ${_toJson()}
}
''';
  }

  String _parseConstructorFields() {
    return '${fields.entries.map((entry) {
      final fieldNameString = entry.key;
      final typeNameString = entry.value as String;

      // TODO: 後で CreateDefault にする
      final defaultValueStrings = visitor.defaultValueStrings;
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
        // TODO: FieldValue と nullable, defalutValue などの組み合わせパターン
        if (isFieldValueAllowed) {
          return 'this.$fieldNameString = const ActualValue($defaultValueString)';
        }
        return 'this.$fieldNameString = $defaultValueString';
      }
      return 'this.$fieldNameString';
    }
    return 'required this.$fieldNameString';
  }

  String _parseFields() {
    return fields.entries.map((entry) {
      final fieldNameString = entry.key;
      final typeNameString = entry.value as String;
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

  String _toJson() {
    final defaultValueStrings = visitor.defaultValueStrings;
    final jsonConverterConfigs = visitor.jsonConverterConfigs;
    return '''
Map<String, dynamic> toJson() {
  return {
    ${fields.entries.map((entry) {
      final fieldNameString = entry.key;
      final typeNameString = entry.value as String;
      final defaultValueString = defaultValueStrings[fieldNameString];
      final hasDefaultValue = (defaultValueString ?? '').isNotEmpty;
      final nullableTypeMatch = RegExp(r'(\w+)\?').firstMatch(typeNameString);
      final isNullableType = nullableTypeMatch != null;
      final isFieldValueAllowed =
          visitor.fieldValueAllowedFields.contains(entry.key);
      final jsonConverterConfig = jsonConverterConfigs[fieldNameString];
      if (jsonConverterConfig != null) {
        if (hasDefaultValue && isNullableType) {
          return "'$fieldNameString': $fieldNameString == null "
              "? $defaultValueString "
              ": ${jsonConverterConfig.jsonConverterString}.toJson($fieldNameString!),";
        }
        return "'$fieldNameString': ${jsonConverterConfig.jsonConverterString}.toJson($fieldNameString),";
      }
      // TODO: FieldValue と nullable, defalutValue などの組み合わせパターン
      if (isFieldValueAllowed) {
        if (isNullableType) {
          if (hasDefaultValue) {
            return "'$fieldNameString': $fieldNameString?.value ?? $defaultValueString,";
          }
          return "'$fieldNameString': $fieldNameString?.value,";
        }
        return "'$fieldNameString': $fieldNameString.value,";
      }
      if (isNullableType && hasDefaultValue) {
        return "'$fieldNameString': $fieldNameString ?? $defaultValueString,";
      }
      return "'$fieldNameString': $fieldNameString,";
    }).join('\n')}
  };
}
''';
  }
}
