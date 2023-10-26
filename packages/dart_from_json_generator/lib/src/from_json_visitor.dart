import 'package:analyzer/dart/element/visitor.dart';
import 'package:dart_from_json_generator_annotation/dart_from_json_generator_annotation.dart';

/// A [SimpleElementVisitor] to visit [FromJson] annotated class.
class FromJsonVisitor extends SimpleElementVisitor<FromJson> {}
