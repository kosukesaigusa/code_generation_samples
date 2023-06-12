// ignore_for_file: implementation_imports, depend_on_referenced_packages

import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:flutterfire_gen_annotation/flutterfire_gen_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'model_visitor.dart';

class FlutterFireGen extends GeneratorForAnnotation<FlutterFireGenAnnotation> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final visitor = ModelVisitor();
    element.visitChildren(visitor);
    final fields = visitor.fields;

    final buffer = StringBuffer();
    final className = '${visitor.className}FlutterFireGen';

    // 冒頭のクラスの定義
    buffer.writeln('class $className {');

    // コンストラクタ
    buffer.writeln('const $className({');
    for (final entry in fields.entries) {
      buffer.writeln('required this.${entry.key},');
    }
    buffer.writeln('});');
    buffer.writeln();

    // 各フィールド
    for (final entry in fields.entries) {
      buffer.writeln('final ${entry.value} ${entry.key};');
    }
    buffer.writeln();

    // fromJson
    buffer.writeln('Map<String, dynamic> toJson() {');
    buffer.writeln('return {');
    for (final entry in fields.entries) {
      buffer.writeln("'${entry.key}': ${entry.key},");
    }
    buffer.writeln('};');
    buffer.writeln('}');

    // toJson
    buffer.writeln('factory $className.fromJson(Map<String, dynamic> json) {');
    buffer.writeln('return $className(');

    for (final entry in fields.entries) {
      final key = entry.key;
      final value = entry.value;
      final defaultValue = visitor.defaultValues[key];
      if (defaultValue != null) {
        buffer.writeln("$key: json['$key'] as $value? ?? $defaultValue,");
      } else {
        buffer.writeln("$key: json['$key'] as $value,");
      }
    }
    buffer.writeln(');');
    buffer.writeln('}');
    buffer.writeln();

    // copyWith
    buffer.writeln('$className copyWith({');
    for (final entry in fields.entries) {
      buffer.writeln('${entry.value}? ${entry.key},');
    }
    buffer.writeln('}) {');
    buffer.writeln('return $className(');
    for (final entry in fields.entries) {
      buffer.writeln('${entry.key}: ${entry.key} ?? this.${entry.key},');
    }
    buffer.writeln(');');
    buffer.writeln('}');

    // クラス定義の最後の閉じカッコ
    buffer.writeln('}');

    return buffer.toString();
  }
}
