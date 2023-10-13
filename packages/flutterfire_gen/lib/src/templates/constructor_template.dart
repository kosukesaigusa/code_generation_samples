/// A template for a constructor.
class ConstructorTemplate {
  /// The name of the constructor.
  ConstructorTemplate({
    required this.className,
    required this.requiredFieldNames,
    required this.optionalFieldNames,
  });

  /// The name of the class.
  final String className;

  /// The names of the required fields.
  final List<String> requiredFieldNames;

  /// The names of the optional fields.
  final List<String> optionalFieldNames;

  @override
  String toString() {
    return '''
const $className({
    ${requiredFieldNames.map((fieldName) => 'required this.$fieldName,').join('\n')}
    ${optionalFieldNames.map((fieldName) => 'this.$fieldName,').join('\n')}
});
  ''';
  }
}
