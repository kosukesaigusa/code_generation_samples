import '../../configs/firestore_document_config.dart';
import '../../firestore_document_visitor.dart';
import '../../utils/string.dart';
import 'to_json_template.dart';

///
class UpdateClassTemplate {
  /// Creates a [UpdateClassTemplate].
  const UpdateClassTemplate({
    required this.config,
    required this.visitor,
    // required this.fields,
  });

  ///
  final FirestoreDocumentConfig config;

  ///
  final FirestoreDocumentVisitor visitor;

  ///
  Map<String, String> get fields => visitor.fields;

  @override
  String toString() {
    return '''
class ${config.updateClassName} {
  ${_parseConstructor()}

  ${_parseFields()}

  ${ToJsonTemplate(
      fields: fields,
      defaultValueStrings: visitor.updateDefaultValueStrings,
      fieldValueAllowedFields: visitor.fieldValueAllowedFields,
      alwaysUseFieldValueServerTimestampWhenUpdatingFields:
          visitor.alwaysUseFieldValueServerTimestampWhenUpdatingFields,
      jsonConverterConfigs: visitor.jsonConverterConfigs,
      jsonPostProcessorConfigs: visitor.jsonPostProcessorConfigs,
    )}
}
''';
  }

  String _parseConstructor() {
    final fields = _parseConstructorFields();
    if (fields.isEmpty) {
      return 'const ${config.updateClassName}();';
    } else {
      return '''
const ${config.updateClassName}({
  ${_parseConstructorFields()}
  });
''';
    }
  }

  // TODO: 可読性、テスト対象を定める意味でリファクタできそう
  String _parseConstructorFields() {
    return effectiveEntries.map((entry) {
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
    }).join('\n');
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
        return 'this.$fieldNameString = const ActualValue($defaultValueString),';
      }
      return 'this.$fieldNameString = $defaultValueString,';
    }
    return 'this.$fieldNameString,';
  }

  String _parseFields() {
    return effectiveEntries.map((entry) {
      final fieldNameString = entry.key;
      final typeNameString = entry.value;
      final isFieldValueAllowed =
          visitor.fieldValueAllowedFields.contains(entry.key);

      if (isFieldValueAllowed) {
        // TODO: typeNameString が nullable になる可能性はある？
        return 'final FirestoreData<$typeNameString>? $fieldNameString;';
      } else {
        return 'final ${typeNameString.ensureNullable()} $fieldNameString;';
      }
    }).join('\n');
  }

  ///
  Iterable<MapEntry<String, String>> get effectiveEntries =>
      fields.entries.where(
        (entry) => !visitor.alwaysUseFieldValueServerTimestampWhenUpdatingFields
            .contains(
          entry.key,
        ),
      );
}
