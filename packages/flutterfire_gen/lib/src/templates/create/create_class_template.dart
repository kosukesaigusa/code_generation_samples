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

  ${fields.entries.map((entry) => 'final ${entry.value} ${entry.key};').join('\n')}
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
}
