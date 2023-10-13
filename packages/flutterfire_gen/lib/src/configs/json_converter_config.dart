///
class JsonConverterConfig {
  ///
  const JsonConverterConfig({
    required this.jsonConverterString,
    required this.clientTypeString,
    required this.firestoreTypeString,
  });

  ///
  final String jsonConverterString;

  ///
  final String clientTypeString;

  ///
  final String firestoreTypeString;
}

///
class JsonPostProcessorConfig {
  ///
  const JsonPostProcessorConfig({
    required this.jsonPostProcessorString,
    required this.clientTypeString,
    required this.firestoreTypeString,
  });

  ///
  final String jsonPostProcessorString;

  ///
  final String clientTypeString;

  ///
  final String firestoreTypeString;
}
