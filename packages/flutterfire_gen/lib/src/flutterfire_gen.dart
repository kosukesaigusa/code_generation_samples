import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:flutterfire_gen_annotation/flutterfire_gen_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'firestore_document_visitor.dart';
import 'parsers/firestore_document_annotation_parser.dart';
import 'templates/create/create_class_template.dart';
import 'templates/delete/delete_class_template.dart';
import 'templates/query_class_template.dart';
import 'templates/read/read_class_template.dart';
import 'templates/refs_template.dart';
import 'templates/update/update_class_template.dart';

/// A generator for [FirestoreDocument] annotation.
class FlutterFireGen extends GeneratorForAnnotation<FirestoreDocument> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final visitor = FirestoreDocumentVisitor();

    element.visitChildren(visitor);

    final config = FirestoreDocumentAnnotationParser(
      baseClassName: visitor.className,
      element: element,
    ).parse();

    final buffer = StringBuffer()
      ..writeln(
        ReadClassTemplate(config: config, visitor: visitor),
      )
      ..writeln(
        CreateClassTemplate(config: config, visitor: visitor),
      )
      ..writeln(
        UpdateClassTemplate(config: config, visitor: visitor),
      )
      ..writeln(DeleteClassTemplate(config: config))
      ..writeln(RefsTemplate(config: config))
      ..writeln(QueryClassTemplate(config: config));

    return buffer.toString();
  }
}
