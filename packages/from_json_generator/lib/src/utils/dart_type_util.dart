import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';

/// Extension on DartType.
///
/// Provides a set of utility methods and properties related to DartType.
extension DartTypeExtension on DartType {
  /// Determines whether the DartType is nullable.
  ///
  /// Returns true if this DartType is nullable, otherwise returns false.
  bool get isNullableType =>
      this is DynamicType || nullabilitySuffix == NullabilitySuffix.question;

  /// Returns the string representation of the DartType.
  ///
  /// If [forceNullable] is true, the resulting type will be nullable.
  String typeName({bool forceNullable = false}) =>
      _typeToCode(this, forceNullable: forceNullable);

  /// If the DartType is a List, returns its first type argument.
  ///
  /// Returns null if the DartType is not a List.
  DartType? get firstTypeArgumentOfList {
    if (isDartCoreList) {
      return (this as InterfaceType).typeArguments.firstOrNull;
    }
    return null;
  }

  /// Determines whether the DartType is of JsonMap `Map<String, dynamic>`
  /// format.
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

  /// If the DartType is a JsonMap, returns its key and value DartType as a
  /// Record.
  ///
  /// Returns null if the DartType is not a JsonMap.
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

  /// Converts the DartType to its Dart code representation.
  ///
  /// If [forceNullable] is true, the resulting type will be nullable.
  ///
  /// Note: This function is intentionally limited to only [InterfaceType]s
  /// and their optional type arguments, which should also be [InterfaceType]s.
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
