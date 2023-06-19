import 'package:meta/meta.dart';

///
class FromJsonTemplate {
  ///
  FromJsonTemplate({
    required this.readClassName,
    required this.fields,
    required this.defaultValues,
  });

  ///
  final String readClassName;

  ///
  final Map<String, dynamic> fields;

  ///
  final Map<String, String> defaultValues;

  @override
  String toString() {
    return '''
factory $readClassName.fromJson(Map<String, dynamic> json) {
    return $readClassName(
      ${_parseFields()}
    );
  }
''';
  }

  ///
  String _parseFields() {
    return fields.entries.map((entry) {
      final fieldNameString = entry.key;
      final typeNameString = entry.value as String;
      final defaultValueString = defaultValues[fieldNameString];
      return fromJsonEachField(
        fieldNameString: fieldNameString,
        typeNameString: typeNameString,
        defaultValueString: defaultValueString,
      );
    }).join(',\n');
  }

  String _parseType(
    String fieldNameString,
    String typeNameString, {
    required bool isFirstLoop,
    String? defaultValueString,
  }) {
    final defaultValueExpression = (isFirstLoop && defaultValueString != null)
        ? ' ?? $defaultValueString'
        : '';
    final parsedKey = isFirstLoop ? "json['$fieldNameString']" : 'e';

    final nullableListMatch =
        RegExp(r'^List<(.*)>\?$').firstMatch(typeNameString);
    if (nullableListMatch != null) {
      final listItemType = nullableListMatch.group(1)!;
      final parsedListItemType = _parseType(
        fieldNameString,
        listItemType,
        defaultValueString: defaultValueString,
        isFirstLoop: false,
      );
      return '($parsedKey as List<dynamic>?)?.map((e) => $parsedListItemType).toList()$defaultValueExpression';
    }

    final listMatch = RegExp(r'^List<(.*)>$').firstMatch(typeNameString);
    if (listMatch != null) {
      final listItemType = listMatch.group(1)!;
      final parsedListItemType = _parseType(
        fieldNameString,
        listItemType,
        defaultValueString: defaultValueString,
        isFirstLoop: false,
      );
      return '($parsedKey as List<dynamic>).map((e) => $parsedListItemType).toList()';
    }

    return '$parsedKey as $typeNameString$defaultValueExpression';
  }

  ///
  @visibleForTesting
  String fromJsonEachField({
    required String fieldNameString,
    required String typeNameString,
    String? defaultValueString,
  }) {
    return '$fieldNameString: ${_parseType(
      fieldNameString,
      typeNameString,
      defaultValueString: defaultValueString,
      isFirstLoop: true,
    )}';
  }
}
