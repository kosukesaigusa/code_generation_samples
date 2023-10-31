/// A configuration for a json converter.
class JsonConverterConfig {
  /// Creates a new [JsonConverterConfig] instance.
  const JsonConverterConfig({
    required this.jsonConverterString,
    required this.clientTypeString,
    required this.jsonTypeString,
  });

  /// The name string of the json converter.
  final String jsonConverterString;

  /// The Dart client field type string of the json converter.
  final String clientTypeString;

  /// The JSON response field type string of the json converter.
  final String jsonTypeString;
}
