import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:flutterfire_gen_annotation/flutterfire_gen_annotation.dart';
import 'package:source_gen/source_gen.dart';

class ModelVisitor extends SimpleElementVisitor<void> {
  String className = '';
  Map<String, dynamic> fields = {};
  Map<String, dynamic> defaultValues = {};

  @override
  void visitConstructorElement(ConstructorElement element) {
    final returnType = element.returnType.toString();
    className = returnType.replaceFirst('*', '');
  }

  @override
  void visitFieldElement(FieldElement element) {
    fields[element.name] = element.type.toString().replaceFirst('*', '');

    // TODO: このロジック @Default を適用するロジックを完全に理解する
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
