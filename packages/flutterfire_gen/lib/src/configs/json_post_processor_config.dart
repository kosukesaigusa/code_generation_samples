/// Configuration for the json_post_processor
class JsonPostProcessorConfig {
  /// Creates a new [JsonPostProcessorConfig] instance.
  const JsonPostProcessorConfig({
    required this.jsonPostProcessorString,
    required this.clientTypeString,
    required this.firestoreTypeString,
  });

  /// The name string of the json post processor.
  final String jsonPostProcessorString;

  /// The client type string of the json post processor.
  final String clientTypeString;

  /// The Cloud Firestore type string of the json post processor.
  final String firestoreTypeString;
}
