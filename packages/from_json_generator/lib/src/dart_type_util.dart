import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';

extension DartTypeExtension on DartType {
  bool get isNullableType =>
      this is DynamicType || nullabilitySuffix == NullabilitySuffix.question;

  String typeName({bool forceNullable = false}) =>
      _typeToCode(this, forceNullable: forceNullable);

  DartType? get firstTypeArgumentOfList {
    if (isDartCoreList) {
      return (this as InterfaceType).typeArguments.firstOrNull;
    }
    return null;
  }

  bool get isJsonMap {
    if (isDartCoreMap) {
      final arguments = (this as InterfaceType).typeArguments;
      final key = arguments.elementAtOrNull(0);
      final value = arguments.elementAtOrNull(1);
      if (key == null || value == null) {
        return false;
      }
      return key.isDartCoreString;
    }
    return false;
  }

  ({DartType key, DartType value})? get keyValueOfMap {
    if (isJsonMap) {
      final arguments = (this as InterfaceType).typeArguments;
      final key = arguments.elementAtOrNull(0);
      final value = arguments.elementAtOrNull(1);
      if (key == null || value == null) {
        return null;
      }
      return (key: key, value: value);
    }
    return null;
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
}
