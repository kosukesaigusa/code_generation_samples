import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:flutterfire_gen_annotation/flutterfire_gen_annotation.dart';
import 'package:source_gen/source_gen.dart';

/// A [SimpleElementVisitor] to visit [FirestoreDocument] annotated class.
class FirestoreDocumentVisitor extends SimpleElementVisitor<void> {
  /// A name of visited [FirestoreDocument] annotated class.
  String className = '';

  /// Fields of visited [FirestoreDocument] annotated class.
  Map<String, dynamic> fields = {};

  /// Default values of visited [FirestoreDocument] annotated class' each field.
  Map<String, String> defaultValues = {};

  @override
  void visitConstructorElement(ConstructorElement element) {
    final returnType = element.returnType.toString();
    className = returnType;
  }

  @override
  void visitFieldElement(FieldElement element) {
    fields[element.name] = element.type.toString();
    _parseDefaultAnnotation(element);
  }

  /// Parses [Default] annotation.
  void _parseDefaultAnnotation(FieldElement element) {
    const matcher = TypeChecker.fromRuntime(Default);
    final metadata = element.metadata;
    for (final meta in metadata) {
      final obj = meta.computeConstantValue()!;
      if (matcher.isExactlyType(obj.type!)) {
        final source = meta.toSource();
        final res = source.substring('@Default('.length, source.length - 1);
        final needsConstModifier = !obj.type!.isDartCoreString &&
            !res.trimLeft().startsWith('const') &&
            (res.contains('(') || res.contains('[') || res.contains('{'));
        if (needsConstModifier) {
          defaultValues[element.name] = 'const $res';
        } else {
          defaultValues[element.name] = res;
        }
      }
    }
  }
}
