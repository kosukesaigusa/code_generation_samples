// ignore_for_file: lines_longer_than_80_chars

import 'package:meta/meta.dart';

import '../../config.dart';
import '../../utils/type_converter.dart';

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
  final Map<String, String> fields;

  ///
  final Map<String, String> defaultValueStrings;

  ///
  final Map<String, JsonConverterConfig> jsonConverterConfigs;

  @override
  String toString() {
    return '''
private static fromJson(json: Record<string, unknown>): ${config.readClassName} {
    return new ${config.readClassName}({
      ${config.documentIdFieldName}: json['${config.documentIdFieldName}'] as string,
      ${config.documentPathFieldName}: json['${config.documentPathFieldName}'] as string,
      ${_parseFields()}
    })
  }
''';
  }

  ///
  String _parseFields() {
    return '${fields.entries.map((entry) {
      final fieldNameString = entry.key;
      final typeNameString = entry.value;
      final defaultValueString = defaultValueStrings[fieldNameString];
      final jsonConverterConfig = jsonConverterConfigs[fieldNameString];
      return fromJsonEachField(
        fieldNameString: fieldNameString,
        typeNameString: typeNameString,
        defaultValueString: defaultValueString,
        jsonConverterConfig: jsonConverterConfig,
      );
    }).join(',\n')},';
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
    final defaultValueExpression = (isFirstLoop && hasDefaultValue)
        ? ' ?? ${toTypeScriptDefaultValueString(
            dartTypeNameString: typeNameString,
            dartDefaultValueString: defaultValueString!,
          )}'
        : '';

    // TODO: jsonConverter は使えないはずなのでいったんコメントアウト
    // if (jsonConverterConfig != null) {
    //   final fromJsonString = '${jsonConverterConfig.jsonConverterString}.'
    //       "fromJson(json['$fieldNameString']"
    //       ' as ${jsonConverterConfig.firestoreTypeString})';
    //   if (defaultValueString != null) {
    //     return "json['$fieldNameString'] == null ? $defaultValueString : $fromJsonString";
    //   } else {
    //     return fromJsonString;
    //   }
    // }

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
      return '($effectiveParsedKey as unknown[] | undefined)?.map((e) => $parsedListItemType)$defaultValueExpression';
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
        return '($effectiveParsedKey as unknown[]).map((e) => $parsedListItemType)';
      } else {
        return '($effectiveParsedKey as unknown[] | undefined)?.map((e) => $parsedListItemType)$defaultValueExpression';
      }
    }

    // TODO: 修正する
    final nullableMapMatch =
        RegExp(r'^Map<String, (.*)>\?$').firstMatch(typeNameString);
    // if (nullableMapMatch != null) {
    //   final mapValueType = nullableMapMatch.group(1)!;
    //   final parsedMapValueType = _parseType(
    //     fieldNameString,
    //     mapValueType,
    //     defaultValueString: defaultValueString,
    //     isFirstLoop: false,
    //     parsedKey: 'v',
    //   );
    //   return '($effectiveParsedKey ? Object.fromEntries(Object.entries($effectiveParsedKey as Record<string, Record<string, string>>).map(([k, v]) => [k, Object.fromEntries(Object.entries(v).map(([k, v]) => [k, v] as [string, string]))])) : {})$defaultValueExpression';
    // }

    final mapMatch = RegExp(r'^Map<String, (.*)>$').firstMatch(typeNameString);
    // if (mapMatch != null) {
    //   final mapValueType = mapMatch.group(1)!;
    //   final parsedMapValueType = _parseType(
    //     fieldNameString,
    //     mapValueType,
    //     defaultValueString: defaultValueString,
    //     isFirstLoop: false,
    //     parsedKey: 'v',
    //   );
    //   return 'Object.fromEntries(Object.entries($effectiveParsedKey as Record<string, Record<string, string>>).map(([k, v]) => [k, Object.fromEntries(Object.entries(v).map(([k, v]) => [k, v] as [string, string]))]))$defaultValueExpression';
    // }
    if (nullableMapMatch != null || mapMatch != null) {
      final mapValueType = (nullableMapMatch?.group(1) ?? mapMatch?.group(1))!;
      final parsedMapValueType = _parseType(
        fieldNameString,
        mapValueType,
        defaultValueString: defaultValueString,
        isFirstLoop: false,
        parsedKey: 'v',
      );
      return 'Object.fromEntries(Object.entries($effectiveParsedKey as Record<string, unknown>).map(([k, v]) => [k, $parsedMapValueType]))$defaultValueExpression';
    }

    final dateTimeMatch = RegExp(r'^DateTime\??$').firstMatch(typeNameString);
    if (dateTimeMatch != null) {
      if (typeNameString.endsWith('?')) {
        return '($effectiveParsedKey as FirebaseFirestore.Timestamp | undefined)?.toDate()';
      } else {
        return '($effectiveParsedKey as FirebaseFirestore.Timestamp).toDate()';
      }
    }
    final (typeScriptTypeString, isUndefinedAllowed) =
        returnsTypeScriptTypeStringAndUndefinedAllowed(typeNameString);
    if (defaultValueExpression.isEmpty) {
      if (isUndefinedAllowed) {
        return '$effectiveParsedKey as $typeScriptTypeString | undefined';
      } else {
        return '$effectiveParsedKey as $typeScriptTypeString';
      }
    } else {
      return '($effectiveParsedKey as $typeScriptTypeString | undefined)$defaultValueExpression';
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
