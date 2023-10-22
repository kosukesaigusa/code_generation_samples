import '../../configs/json_post_processor_config.dart';

/// A template for JSON post processors.
class JsonPostProcessorTemplate {
  /// Creates a [JsonPostProcessorTemplate].
  const JsonPostProcessorTemplate({
    required this.fields,
    required this.jsonPostProcessorConfigs,
  });

  /// The fields for the document.
  final Map<String, String> fields;

  /// The JSON post processor configs for the document.
  final Map<String, JsonPostProcessorConfig> jsonPostProcessorConfigs;

  /// Returns the JSON post processor fromJson string.
  String fromJsonTemplate() {
    final buffer = StringBuffer();
    for (final entry in fields.entries) {
      final fieldNameString = entry.key;
      final jsonPostProcessorConfig = jsonPostProcessorConfigs[fieldNameString];
      if (jsonPostProcessorConfig == null) {
        continue;
      }
      final value = '${jsonPostProcessorConfig.jsonPostProcessorString}.'
          'fromJson(json)';
      buffer.writeln("'$fieldNameString': $value,");
    }
    return buffer.toString();
  }
}
