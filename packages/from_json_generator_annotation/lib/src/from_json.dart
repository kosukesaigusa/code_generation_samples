/// A class that represents the `@FromJson` annotation.
///
/// This annotation indicates that the annotated field should be populated by
/// deserializing a JSON object. It doesn't carry any data, serving as a marker.
class FromJson {
  /// Constructs an instance of [FromJson].
  const FromJson({this.convertSnakeToCamel = false});

  /// Whether to convert snake case to camel case when deserializing.
  final bool convertSnakeToCamel;
}
