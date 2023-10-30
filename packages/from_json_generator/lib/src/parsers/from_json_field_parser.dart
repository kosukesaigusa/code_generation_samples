import 'package:analyzer/dart/element/type.dart';

import '../configs/json_converter_config.dart';
import '../utils/dart_type_util.dart';
import '../utils/string_util.dart';

/// A utility class responsible for generating Dart code for deserializing a
/// specific class field from a JSON object.
class FromJsonFieldParser {
  /// Constructs a [FromJsonFieldParser].
  ///
  /// - [name] The name of the class field.
  /// - [dartType] The Dart type of the field.
  /// - [defaultValueString] The default value of the field as a string, if any.
  /// - [jsonConverterConfig] Configuration for JSON conversion, if any.
  const FromJsonFieldParser({
    required this.name,
    required this.dartType,
    required this.defaultValueString,
    required this.jsonConverterConfig,
    required this.convertSnakeToCamel,
  });

  /// The name of the field in the class.
  final String name;

  /// The Dart type of the field.
  final DartType dartType;

  /// The default value of the field, represented as a string.
  final String? defaultValueString;

  /// Configuration for converting the field to and from JSON.
  final JsonConverterConfig? jsonConverterConfig;

  /// Whether to convert json response fields' snake case to camel case.
  final bool convertSnakeToCamel;

  /// The name of the field in the JSON field.
  String get _jsonFieldName {
    if (convertSnakeToCamel) {
      return name.convertToSnakeCaseIfCamelCase();
    } else {
      return name;
    }
  }

  @override
  String toString() {
    final result = _generateFromJsonCodeSnippet(
      dartType,
      defaultValueString: defaultValueString,
      jsonConverterConfig: jsonConverterConfig,
      isFirstLoop: true,
    );
    return '$name: $result,';
  }

  /// Generates a Dart code snippet for deserializing a field from a JSON
  /// object.
  ///
  /// This method recursively constructs Dart code to deserialize complex types
  /// like List or Map from a JSON object. The resulting string is meant to be
  /// used in a `fromJson` factory method.
  ///
  /// - [dartType] The type of the field to be deserialized.
  /// - [isFirstLoop] A flag to indicate whether this is the first recursive
  /// call.
  /// - [defaultValueString] A default value for the field, if any.
  /// - [jsonConverterConfig] Configuration for converting complex types.
  /// - [parsedKey] The key used in parsing, useful in recursion for nested
  /// types.
  ///
  /// Returns a string of Dart code that can deserialize a field of type
  /// [dartType] from a JSON object.
  String _generateFromJsonCodeSnippet(
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
          "fromJson(json['$_jsonFieldName']"
          ' as ${jsonConverterConfig.firestoreTypeString})';
      if (defaultValueString != null) {
        return "json['$_jsonFieldName'] == null "
            '? $defaultValueString : $fromJsonString';
      } else {
        return fromJsonString;
      }
    }

    final effectiveParsedKey =
        isFirstLoop ? "json['$_jsonFieldName']" : parsedKey;

    if (dartType.isDartCoreList) {
      if (dartType.firstTypeArgumentOfList != null) {
        final parsedListItemType = _generateFromJsonCodeSnippet(
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
          if (dartType.isNullableType || defaultValueExpression.isNotEmpty) {
            return '$effectiveParsedKey '
                'as Map<String, dynamic>?$defaultValueExpression';
          } else {
            return '$effectiveParsedKey as Map<String, dynamic>';
          }
        }
        final parsedMapValueType = _generateFromJsonCodeSnippet(
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
