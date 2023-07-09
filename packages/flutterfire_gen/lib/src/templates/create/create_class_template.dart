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
}
''';
  }

  String _parseConstructorFields() {
    return '${fields.entries.map((entry) {
      final fieldNameString = entry.key;
      final typeNameString = entry.value as String;

      // TODO: 後で CreateDefault にする
      final defaultValueStrings = visitor.defaultValueStrings;

      final defaultValueString = defaultValueStrings[fieldNameString];
      return _constructorEachField(
        fieldNameString,
        typeNameString,
        defaultValueString: defaultValueString,
      );
    }).join(',\n')},';
  }

  String _constructorEachField(
    String fieldNameString,
    String typeNameString, {
    String? defaultValueString,
  }) {
    final hasDefaultValue = (defaultValueString ?? '').isNotEmpty;
    final isNullable = typeNameString.endsWith('?');
    if (hasDefaultValue || isNullable) {
      if (hasDefaultValue) {
        return 'this.$fieldNameString=$defaultValueString';
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
}
