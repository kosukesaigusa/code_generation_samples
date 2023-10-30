/// Configuration values defined in build.yaml.
class BuildYamlConfig {
  /// Creates a [BuildYamlConfig].
  BuildYamlConfig({this.convertSnakeToCamel});

  /// Decode the options from a build.yaml.
  factory BuildYamlConfig.fromBuildYaml(Map<String, dynamic> yaml) =>
      BuildYamlConfig(
        convertSnakeToCamel: (yaml['field_rename'] as String?) == 'snake',
      );

  /// Whether to convert field name snake_case to camelCase.
  final bool? convertSnakeToCamel;
}
