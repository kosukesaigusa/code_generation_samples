// ignore_for_file: lines_longer_than_80_chars

import 'package:meta/meta.dart';

///
class FromJsonTemplate {
  ///
  FromJsonTemplate({
    required this.readClassName,
    required this.fields,
    required this.defaultValueStrings,
    required this.jsonConverterStrings,
  });

  ///
  final String readClassName;

  ///
  final Map<String, dynamic> fields;

  ///
  final Map<String, String> defaultValueStrings;

  ///
  final Map<String, String> jsonConverterStrings;

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
      final defaultValueString = defaultValueStrings[fieldNameString];
      final jsonConverterString = jsonConverterStrings[fieldNameString];
      return fromJsonEachField(
        fieldNameString: fieldNameString,
        typeNameString: typeNameString,
        defaultValueString: defaultValueString,
        jsonConverterString: jsonConverterString,
      );
    }).join(',\n');
  }

  String _parseType(
    String fieldNameString,
    String typeNameString, {
    required bool isFirstLoop,
    String? defaultValueString,
    String? jsonConverterString,
    String parsedKey = 'e',
  }) {
    // TODO: nullable の場合のデフォルト値の取扱を考える
    if ((jsonConverterString ?? '').isNotEmpty) {
      return "$jsonConverterString.fromJson(json['$fieldNameString'] as Object)";
    }
    final defaultValueExpression = (isFirstLoop && defaultValueString != null)
        ? ' ?? $defaultValueString'
        : '';
    final effectiveParsedKey =
        isFirstLoop ? "json['$fieldNameString']" : parsedKey;

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
      return '($effectiveParsedKey as List<dynamic>?)?.map((e) => $parsedListItemType).toList()$defaultValueExpression';
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
      return '($effectiveParsedKey as List<dynamic>).map((e) => $parsedListItemType).toList()';
    }

    final nullableMapMatch =
        RegExp(r'^Map<String, (.*)>\?$').firstMatch(typeNameString);
    if (nullableMapMatch != null) {
      final mapValueType = nullableMapMatch.group(1)!;
      if (mapValueType == 'dynamic') {
        return '$effectiveParsedKey as Map<String, dynamic>?$defaultValueExpression';
      }
      final parsedMapValueType = _parseType(
        fieldNameString,
        mapValueType,
        defaultValueString: defaultValueString,
        isFirstLoop: false,
        parsedKey: 'v',
      );
      return '($effectiveParsedKey as Map<String, dynamic>?)?.map((k, v) => MapEntry(k, $parsedMapValueType))$defaultValueExpression';
    }

    final mapMatch = RegExp(r'^Map<String, (.*)>$').firstMatch(typeNameString);
    if (mapMatch != null) {
      final mapValueType = mapMatch.group(1)!;
      if (mapValueType == 'dynamic') {
        return '$effectiveParsedKey as Map<String, dynamic>$defaultValueExpression';
      } else {
        final parsedMapValueType = _parseType(
          fieldNameString,
          mapValueType,
          defaultValueString: defaultValueString,
          isFirstLoop: false,
          parsedKey: 'v',
        );
        return '($effectiveParsedKey as Map<String, dynamic>).map((k, v) => MapEntry(k, $parsedMapValueType))$defaultValueExpression';
      }
    }

    final dateTimeMatch = RegExp(r'^DateTime\??$').firstMatch(typeNameString);
    if (dateTimeMatch != null) {
      if (typeNameString.endsWith('?')) {
        return '($effectiveParsedKey as Timestamp?)?.toDate()';
      } else {
        return '($effectiveParsedKey as Timestamp).toDate()';
      }
    }

    return '$effectiveParsedKey as $typeNameString$defaultValueExpression';
  }

  ///
  @visibleForTesting
  String fromJsonEachField({
    required String fieldNameString,
    required String typeNameString,
    String? defaultValueString,
    String? jsonConverterString,
  }) {
    return '$fieldNameString: ${_parseType(
      fieldNameString,
      typeNameString,
      defaultValueString: defaultValueString,
      jsonConverterString: jsonConverterString,
      isFirstLoop: true,
    )}';
  }
}
