/// A class that represents the `@Default` annotation to specify a default value
///  for a field.
///
/// This annotation is used to set the default value of a class property when
/// deserializing from a JSON object. If the JSON object does not contain the
/// key for this property, the `defaultValue` will be used instead.
class Default {
  /// Constructs an instance of [Default].
  ///
  /// Takes an optional [defaultValue] that will be used when the JSON object
  /// does not contain a value for the annotated property.
  const Default(this.defaultValue);

  /// The default value for the annotated property.
  final Object? defaultValue;
}
