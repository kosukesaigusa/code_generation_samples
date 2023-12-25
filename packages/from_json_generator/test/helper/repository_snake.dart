// See: https://docs.github.com/en/rest/repos/repos?apiVersion=2022-11-28#get-a-repository

import 'package:from_json_generator_annotation/from_json_generator_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'repository_snake.from_json.dart';

@FromJson(convertSnakeToCamel: true)
class Repository {
  Repository({
    required this.id,
    required this.name,
    required this.private,
    required this.starGazersCount,
    required this.topics,
    required this.visibility,
    required this.permissions,
    required this.securityAndAnalysis,
  });

  factory Repository.fromJson(Map<String, dynamic> json) =>
      _$RepositoryFromJson(json);

  final String id;

  final String name;

  @Default(false)
  final bool private;

  final int starGazersCount;

  @Default(<String>[])
  List<String> topics;

  @_visibilityConverter
  final Visibility visibility;

  final Map<String, bool> permissions;

  final Map<String, Map<String, String>> securityAndAnalysis;
}

enum Visibility {
  public,
  private,
  ;

  factory Visibility.fromString(String visibilityString) {
    switch (visibilityString) {
      case 'public':
        return Visibility.public;
      case 'private':
        return Visibility.private;
    }
    throw ArgumentError('visibility is not valid: $visibilityString');
  }
}

const _visibilityConverter = _VisibilityConverter();

class _VisibilityConverter implements JsonConverter<Visibility, String> {
  const _VisibilityConverter();

  @override
  Visibility fromJson(String json) => Visibility.fromString(json);

  @override
  String toJson(Visibility _) => throw UnimplementedError();
}
