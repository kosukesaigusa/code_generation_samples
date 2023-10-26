// See: https://docs.github.com/en/rest/repos/repos?apiVersion=2022-11-28#get-a-repository

import 'package:dart_from_json_generator_annotation/dart_from_json_generator_annotation.dart';

part 'repository.dart_from_json_generator.dart';

@FromJson()
class Repository {
  Repository({
    required this.id,
    required this.name,
    required this.private,
    required this.starGazersCount,
  });

  factory Repository.fromJson(Map<String, dynamic> json) =>
      _$RepositoryFromJson(json);

  final String id;

  final String name;

  final bool private;

  final int starGazersCount;
}
