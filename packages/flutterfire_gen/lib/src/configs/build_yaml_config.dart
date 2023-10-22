/// Configuration values defined in build.yaml.
class BuildYamlConfig {
  /// Creates a [BuildYamlConfig].
  BuildYamlConfig({
    this.includePathField,
    this.includeDocumentReferenceField,
    this.generateCopyWith,
  });

  /// Decode the options from a build.yaml.
  factory BuildYamlConfig.fromBuildYaml(Map<String, dynamic> json) =>
      BuildYamlConfig(
        includePathField: json['includePathField'] as bool? ?? false,
        includeDocumentReferenceField:
            json['includeDocumentReferenceField'] as bool? ?? false,
        generateCopyWith: json['generateCopyWith'] as bool? ?? false,
      );

  /// Whether to include `path` field in ReadEntity class.
  final bool? includePathField;

  /// Whether to include `DocumentReference` field in ReadEntity class.
  final bool? includeDocumentReferenceField;

  /// Whether to generate `copyWith` method in ReadEntity class.
  final bool? generateCopyWith;
}
