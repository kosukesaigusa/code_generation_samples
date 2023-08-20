import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';

/// A [SimpleElementVisitor] to visit [CustomTypeScript] annotated class.
class CustomTypeScriptVisitor extends SimpleElementVisitor<void> {
  /// A name of visited [CustomTypeScript] annotated class.
  String className = '';

  /// Fields of visited [CustomTypeScript] annotated class.
  final Map<String, Map<String, String>> fieldsByClassName = {};

  @override
  void visitConstructorElement(ConstructorElement element) {
    final returnType = element.returnType.toString();
    className = returnType;
  }

  @override
  void visitFieldElement(FieldElement element) {
    final enclosingElementName = element.enclosingElement.name;
    if (enclosingElementName == null) {
      return;
    }
    if (fieldsByClassName.containsKey(enclosingElementName)) {
      fieldsByClassName[enclosingElementName]![element.name] =
          element.type.toString();
    } else {
      fieldsByClassName[enclosingElementName] = {
        element.name: element.type.toString()
      };
    }
  }
}
