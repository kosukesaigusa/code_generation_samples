import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';

import 'json_converter_config.dart';

/// A configuration for a field.
class FieldConfig {
  /// Creates a new [FieldConfig] instance.
  FieldConfig({
    required this.name,
    required this.dartType,
    this.defaultValueString,
    this.jsonConverterConfig,
  });

  /// The name of the field.
  final String name;

  /// The [DartType] of the field.
  final DartType dartType;

  /// Whether the field is nullable.
  bool get isNullableType => dartType.isNullableType;

  /// The type name String of the field.
  String get typeName => _typeToCode(dartType);

  /// The default value string of the field.
  final String? defaultValueString;

  /// The [JsonConverterConfig] of the field.
  final JsonConverterConfig? jsonConverterConfig;

  /// Whether the field is a list.
  bool get isNonNullableList => dartType.isDartCoreList && !isNullableType;

  /// Whether the field is a nullable list.
  bool get isNullableList => dartType.isDartCoreList && isNullableType;
}

extension on DartType {
  bool get isNullableType =>
      this is DynamicType || nullabilitySuffix == NullabilitySuffix.question;
}

/// Return the Dart code presentation for the given [type].
///
/// This function is intentionally limited, and does not support all possible
/// types and locations of these files in code. Specifically, it supports
/// only [InterfaceType]s, with optional type arguments that are also should
/// be [InterfaceType]s.
String _typeToCode(
  DartType type, {
  bool forceNullable = false,
}) {
  if (type is DynamicType) {
    return 'dynamic';
  } else if (type is InterfaceType) {
    return [
      type.element.name,
      if (type.typeArguments.isNotEmpty)
        '<${type.typeArguments.map(_typeToCode).join(', ')}>',
      if (type.isNullableType || forceNullable) '?' else '',
    ].join();
  }

  if (type is TypeParameterType) {
    return type.getDisplayString(withNullability: false);
  }
  throw UnimplementedError('(${type.runtimeType}) $type');
}
