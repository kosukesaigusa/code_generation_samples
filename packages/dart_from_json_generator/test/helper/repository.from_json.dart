// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'repository.dart';

// **************************************************************************
// FromJsonGenerator
// **************************************************************************

Repository _$RepositoryFromJson(Map<String, dynamic> json) => Repository(
      id: json['id'] as String,
      name: json['name'] as String,
      private: json['private'] as bool? ?? false,
      starGazersCount: json['starGazersCount'] as int,
      topics: (json['topics'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      visibility: _visibilityConverter.fromJson(json['visibility'] as String),
      permissions: (json['permissions'] as Map<String, dynamic>)
          .map((k, v) => MapEntry(k, v as bool)),
      securityAndAnalysis: (json['securityAndAnalysis'] as Map<String, dynamic>)
          .map((k, v) => MapEntry(
              k,
              (v as Map<String, dynamic>)
                  .map((k, v) => MapEntry(k, v as String)))),
    );
