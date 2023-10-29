import 'package:analyzer/dart/element/type.dart';

import '../configs/json_converter_config.dart';
import '../dart_type_util.dart';

/// A parser for a field of a class.
class FromJsonFieldParser {
  /// Creates a [FromJsonFieldParser] with the given [name] and [dartType].
  const FromJsonFieldParser({
    required this.name,
    required this.dartType,
    required this.defaultValueString,
    required this.jsonConverterConfig,
  });

  /// The name of the field.
  final String name;

  /// The type of the field.
  final DartType dartType;

  /// The default value of the field.
  final String? defaultValueString;

  /// The [JsonConverterConfig] of the field.
  final JsonConverterConfig? jsonConverterConfig;

  @override
  String toString() {
    final result = _parseType(
      name,
      dartType,
      defaultValueString: defaultValueString,
      jsonConverterConfig: jsonConverterConfig,
      isFirstLoop: true,
    );
    return '$name: $result,';
  }

  String _parseType(
    String fieldNameString,
    DartType dartType, {
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
          "fromJson(json['$name']"
          ' as ${jsonConverterConfig.firestoreTypeString})';
      if (defaultValueString != null) {
        return "json['$name'] == null "
            '? $defaultValueString : $fromJsonString';
      } else {
        return fromJsonString;
      }
    }

    final effectiveParsedKey = isFirstLoop ? "json['$name']" : parsedKey;

    if (dartType.isDartCoreList) {
      if (dartType.firstTypeArgumentOfList != null) {
        final parsedListItemType = _parseType(
          fieldNameString,
          dartType.firstTypeArgumentOfList!,
          defaultValueString: defaultValueString,
          isFirstLoop: false,
        );
        if (dartType.isNullableType || defaultValueExpression.isNotEmpty) {
          return '($effectiveParsedKey as List<dynamic>?)?.map((e) '
              '=> $parsedListItemType).toList()$defaultValueExpression';
        } else {
          return '($effectiveParsedKey as List<dynamic>).map((e) '
              '=> $parsedListItemType).toList()';
        }
      }
    }

    if (dartType.isJsonMap) {
      if (dartType.keyValueOfMap != null) {
        final valueType = dartType.keyValueOfMap!.value;
        if (valueType is DynamicType) {
          return '$effectiveParsedKey '
              'as Map<String, dynamic>?$defaultValueExpression';
        }
        final parsedMapValueType = _parseType(
          fieldNameString,
          valueType,
          defaultValueString: defaultValueString,
          isFirstLoop: false,
          parsedKey: 'v',
        );
        if (dartType.isNullableType || defaultValueExpression.isNotEmpty) {
          return '($effectiveParsedKey as Map<String, dynamic>?)?.map((k, v) '
              '=> MapEntry(k, $parsedMapValueType))$defaultValueExpression';
        } else {
          return '($effectiveParsedKey as Map<String, dynamic>).map((k, v) => '
              'MapEntry(k, $parsedMapValueType))$defaultValueExpression';
        }
      }
    }

    final typeNameString = dartType.typeName(
      forceNullable:
          dartType.isNullableType || defaultValueExpression.isNotEmpty,
    );
    return '$effectiveParsedKey as $typeNameString$defaultValueExpression';
  }
}
