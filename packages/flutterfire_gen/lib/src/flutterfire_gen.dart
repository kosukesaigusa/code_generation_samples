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

    final buffer = StringBuffer();
    final className = '${visitor.className}FlutterFireGen';
    buffer.writeln('class $className {');
    for (var i = 0; i < visitor.fields.length; i++) {
      buffer.writeln(
        'final ${visitor.fields.values.elementAt(i)} ${visitor.fields.keys.elementAt(i)};',
      );
    }
    // CONSTRUCTOR
    buffer.writeln('const $className({');
    for (var i = 0; i < visitor.fields.length; i++) {
      buffer.writeln(
        'required this.${visitor.fields.keys.elementAt(i)},',
      );
    }
    buffer.writeln('});');

    // TO MAP
    buffer.writeln('Map<String, dynamic> toMap() {');
    buffer.writeln('return {');
    for (var i = 0; i < visitor.fields.length; i++) {
      buffer.writeln(
        "'${visitor.fields.keys.elementAt(i)}': ${visitor.fields.keys.elementAt(i)},",
      );
    }
    buffer.writeln('};');
    buffer.writeln('}');

    // FROM MAP
    buffer.writeln('factory $className.fromMap(Map<String, dynamic> map) {');
    buffer.writeln('return $className(');
    for (var i = 0; i < visitor.fields.length; i++) {
      buffer.writeln(
        "${visitor.fields.keys.elementAt(i)}: map['${visitor.fields.keys.elementAt(i)}'],",
      );
    }
    buffer.writeln(');');
    buffer.writeln('}');

    // copyWith
    buffer.writeln('$className copyWith({');
    for (var i = 0; i < visitor.fields.length; i++) {
      buffer.writeln(
        '${visitor.fields.values.elementAt(i)}? ${visitor.fields.keys.elementAt(i)},',
      );
    }
    buffer.writeln('}) {');
    buffer.writeln('return $className(');
    for (var i = 0; i < visitor.fields.length; i++) {
      buffer.writeln(
        '${visitor.fields.keys.elementAt(i)}: ${visitor.fields.keys.elementAt(i)} ?? this.${visitor.fields.keys.elementAt(i)},',
      );
    }
    buffer.writeln(');');
    buffer.writeln('}');
    buffer.writeln('}');

    return buffer.toString();
  }
}
