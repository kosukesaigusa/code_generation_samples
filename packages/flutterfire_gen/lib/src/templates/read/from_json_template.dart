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
  final Map<String, dynamic> defaultValues;

  final _listType = RegExp(r'^List<(.*)>$');

  final _mapType = RegExp(r'^Map<(.+),\s*(.*)>$');

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
      final defaultValue = defaultValues[fieldNameString];
      return fromJsonEachField(
        fieldNameString: fieldNameString,
        typeNameString: typeNameString,
        defaultValue: defaultValue,
      );
    }).join(',\n');
  }

  String _parseType(
    String fieldNameString,
    String typeNameString, {
    required bool isFirstLoop,
    Object? defaultValue,
  }) {
    final listMatch = _listType.firstMatch(typeNameString);

    final defaultValueString = defaultValue != null ? ' ?? $defaultValue' : '';
    final parsedKey = isFirstLoop ? "json['$fieldNameString']" : 'e';

    if (listMatch != null) {
      final listItemType = listMatch.group(1)!;
      final nullableSign = listItemType.endsWith('?') ? '?' : '';
      final nonNullableListItemType = listItemType.replaceAll('?', '');
      final parsedListItemType = _parseType(
        fieldNameString,
        nonNullableListItemType,
        defaultValue: defaultValue,
        isFirstLoop: false,
      );
      return '($parsedKey as List<dynamic>$nullableSign).map((e) => $parsedListItemType).toList()$defaultValueString';
    } else {
      return '$parsedKey as $typeNameString$defaultValueString';
    }
  }

  ///
  @visibleForTesting
  String fromJsonEachField({
    required String fieldNameString,
    required String typeNameString,
    Object? defaultValue,
  }) {
    return '$fieldNameString: '
        '${_parseType(
      fieldNameString,
      typeNameString,
      defaultValue: defaultValue,
      isFirstLoop: true,
    )}';
  }
}
