// ignore_for_file: lines_longer_than_80_chars

import 'package:meta/meta.dart';

import '../../config.dart';
import '../../utils/string.dart';

///
class FromJsonTemplate {
  ///
  FromJsonTemplate({
    required this.config,
    required this.fields,
    required this.defaultValueStrings,
    required this.jsonConverterConfigs,
  });

  ///
  final FirestoreDocumentConfig config;

  ///
  final Map<String, dynamic> fields;

  ///
  final Map<String, String> defaultValueStrings;

  ///
  final Map<String, JsonConverterConfig> jsonConverterConfigs;

  @override
  String toString() {
    return '''
factory ${config.readClassName}._fromJson(Map<String, dynamic> json) {
    return ${config.readClassName}._(
      ${config.documentIdFieldName}: json['${config.documentIdFieldName}'] as String,
      ${config.documentReferenceFieldName}: json['${config.documentReferenceFieldName}'] as DocumentReference<${config.readClassName}>,
      ${_parseFields()}
    );
  }
''';
  }

  ///
  String _parseFields() {
    return '${fields.entries.map((entry) {
      final fieldNameString = entry.key;
      final typeNameString = entry.value as String;
      final defaultValueString = defaultValueStrings[fieldNameString];
      final jsonConverterConfig = jsonConverterConfigs[fieldNameString];
      return fromJsonEachField(
        fieldNameString: fieldNameString,
        typeNameString: typeNameString,
        defaultValueString: defaultValueString,
        jsonConverterConfig: jsonConverterConfig,
      );
    }).join(',\n')},\n';
  }

  String _parseType(
    String fieldNameString,
    String typeNameString, {
    required bool isFirstLoop,
    String? defaultValueString,
    JsonConverterConfig? jsonConverterConfig,
    String parsedKey = 'e',
  }) {
    final hasDefaultValue = (defaultValueString ?? '').isNotEmpty;
    final defaultValueExpression =
        (isFirstLoop && hasDefaultValue) ? ' ?? $defaultValueString' : '';

    if (jsonConverterConfig != null) {
      final fromJsonString = '${jsonConverterConfig.jsonConverterString}.'
          "fromJson(json['$fieldNameString']"
          ' as ${jsonConverterConfig.firestoreTypeString})';
      if (defaultValueString != null) {
        return "json['$fieldNameString'] == null ? $defaultValueString : $fromJsonString";
      } else {
        return fromJsonString;
      }
    }

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
      if (defaultValueExpression.isEmpty) {
        return '($effectiveParsedKey as List<dynamic>).map((e) => $parsedListItemType).toList()';
      } else {
        return '($effectiveParsedKey as List<dynamic>?)?.map((e) => $parsedListItemType).toList()$defaultValueExpression';
      }
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
        if (defaultValueExpression.isEmpty) {
          return '$effectiveParsedKey as Map<String, dynamic>$defaultValueExpression';
        } else {
          return '$effectiveParsedKey as Map<String, dynamic>?$defaultValueExpression';
        }
      } else {
        final parsedMapValueType = _parseType(
          fieldNameString,
          mapValueType,
          defaultValueString: defaultValueString,
          isFirstLoop: false,
          parsedKey: 'v',
        );
        if (defaultValueExpression.isEmpty) {
          return '($effectiveParsedKey as Map<String, dynamic>).map((k, v) => MapEntry(k, $parsedMapValueType))$defaultValueExpression';
        } else {
          return '($effectiveParsedKey as Map<String, dynamic>?)?.map((k, v) => MapEntry(k, $parsedMapValueType))$defaultValueExpression';
        }
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

    if (defaultValueExpression.isEmpty) {
      return '$effectiveParsedKey as $typeNameString$defaultValueExpression';
    } else {
      return '$effectiveParsedKey as ${typeNameString.ensureNullable()}$defaultValueExpression';
    }
  }

  ///
  @visibleForTesting
  String fromJsonEachField({
    required String fieldNameString,
    required String typeNameString,
    String? defaultValueString,
    JsonConverterConfig? jsonConverterConfig,
  }) {
    return '$fieldNameString: ${_parseType(
      fieldNameString,
      typeNameString,
      defaultValueString: defaultValueString,
      jsonConverterConfig: jsonConverterConfig,
      isFirstLoop: true,
    )}';
  }
}
