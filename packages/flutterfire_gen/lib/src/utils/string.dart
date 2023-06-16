/// An extension class on [String].
extension StringExtension on String {
  /// Capitalizes the given [String].
  String capitalize() {
    if (isEmpty) {
      return '';
    }
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Ensures the string represents a nullable type.
  ///
  /// If the string does not end with a '?', it appends one and returns the
  /// result.
  /// If the string already ends with a '?', it returns the string as is.
  ///
  /// Example:
  /// ```dart
  /// var nullableType = 'String'.ensureNullable();
  /// print(nullableType);  // Output: String?
  /// ```
  String ensureNullable() {
    return endsWith('?') ? this : '$this?';
  }
}
