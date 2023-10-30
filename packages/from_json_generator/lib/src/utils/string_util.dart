/// Utility functions for [String]s.
extension StringExtension on String {
  /// Converts a [String] to snake case if it is in camel case.
  ///
  /// This function takes an input [String] and checks if it is in camel case
  /// (words start with an uppercase letter except the first word). If it is,
  /// the function converts it to snake case.
  ///
  /// ## Parameters
  ///
  /// - `input`: The input [String] that may be in camel case.
  ///
  /// ## Returns
  ///
  /// - A [String] that is converted to snake case if the input was in camel
  /// case.
  /// - If the input was not in camel case or was empty, it returns the input
  /// [String] as is.
  ///
  /// ## Examples
  ///
  /// ```dart
  /// final result1 = convertToSnakeCaseIfCamelCase('helloWorld');  // returns 'hello_world'
  /// final result2 = convertToSnakeCaseIfCamelCase('HelloWorld');  // returns 'hello_world'
  /// final result3 = convertToSnakeCaseIfCamelCase('hello');       // returns 'hello'
  /// ```
  String convertToSnakeCaseIfCamelCase() {
    return replaceAllMapped(RegExp('([A-Z])'), (m) => '_${m[1]!.toLowerCase()}')
        .toLowerCase();
  }
}
