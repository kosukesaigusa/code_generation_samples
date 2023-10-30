// import 'package:analyzer/dart/element/element.dart';
// import 'package:analyzer/dart/element/type.dart';
// import 'package:analyzer/dart/element/visitor.dart';
// import 'package:from_json_generator_annotation/from_json_generator_annotation.dart';
// import 'package:json_annotation/json_annotation.dart';
// import 'package:source_gen/source_gen.dart';

// import 'configs/json_converter_config.dart';

// /// A [SimpleElementVisitor] to visit [FromJson] annotated class.
// class FromJsonVisitor extends SimpleElementVisitor<void> {
//   /// A name of visited [FromJson] annotated class.
//   String className = '';

//   /// Fields of visited [FromJson] annotated class.
//   final Map<String, String> fields = {};

//   /// Default value strings of each field when parse from json.
//   final Map<String, String> defaultValueStrings = {};

//   /// [JsonConverter] configurations of each field.
//   final Map<String, JsonConverterConfig> jsonConverterConfigs = {};

//   @override
//   void visitConstructorElement(ConstructorElement element) {
//     final returnType = element.returnType.toString();
//     className = returnType;
//     _parseConstructorParameters(element.parameters);
//   }

//   @override
//   void visitFieldElement(FieldElement element) {
//     fields[element.name] = element.type.toString();
//     _parseAnnotations(element);
//   }

//   /// Parses default values of constructor parameters.
//   void _parseConstructorParameters(List<ParameterElement> parameters) {
//     for (final parameter in parameters) {
//       if (parameter.isOptional) {
//         final fieldName = parameter.name;
//         final defaultValueCode = parameter.defaultValueCode;
//         if (defaultValueCode != null) {
//           print(
//             'The default value $defaultValueCode for $className.$fieldName is '
//             'set in the constructor of $className.',
//           );
//         }
//       }
//     }
//   }

//   /// Parses annotations and json converters.
//   void _parseAnnotations(FieldElement element) {
//     const defaultTypeChecker = TypeChecker.fromRuntime(Default);
//     const jsonConverterTypeChecker = TypeChecker.fromRuntime(JsonConverter);

//     final metadata = element.metadata;
//     for (final meta in metadata) {
//       final fieldName = element.name;
//       final source = meta.toSource();
//       final object = meta.computeConstantValue()!;
//       final objectType = object.type!;
//       if (defaultTypeChecker.isAssignableFromType(objectType)) {
//         _parseDefaultAnnotation(
//           fieldName: fieldName,
//           source: source,
//           objectType: objectType,
//         );
//       }
//       if (jsonConverterTypeChecker.isAssignableFromType(objectType)) {
//         final interfaceTypes = (objectType.element! as ClassElement)
//             .allSupertypes
//             .where((t) => jsonConverterTypeChecker.isExactlyType(t));
//         final typeArguments = interfaceTypes.first.typeArguments;
//         if (typeArguments.length == 2) {
//           final clientType = typeArguments[0];
//           final firestoreType = typeArguments[1];
//           _parseJsonConverterAnnotation(
//             fieldName: fieldName,
//             source: source,
//             clientType: clientType,
//             firestoreType: firestoreType,
//           );
//         }
//       }
//     }
//   }

//   /// Parses [Default] annotation.
//   void _parseDefaultAnnotation({
//     required String fieldName,
//     required String source,
//     required DartType objectType,
//   }) {
//     final defaultTypeString =
//         objectType.getDisplayString(withNullability: false);
//     final res =
//         source.substring('@$defaultTypeString('.length, source.length - 1);
//     final needsConstModifier = !objectType.isDartCoreString &&
//         !res.trimLeft().startsWith('const') &&
//         (res.contains('(') || res.contains('[') || res.contains('{'));
//     if (needsConstModifier) {
//       defaultValueStrings[fieldName] = 'const $res';
//     } else {
//       defaultValueStrings[fieldName] = res;
//     }
//   }

//   /// Parses [JsonConverter] annotation.
//   void _parseJsonConverterAnnotation({
//     required String fieldName,
//     required String source,
//     required DartType clientType,
//     required DartType firestoreType,
//   }) {
//     final pattern = RegExp('@(.*)');
//     final match = pattern.firstMatch(source);
//     if (match != null) {
//       jsonConverterConfigs[fieldName] = JsonConverterConfig(
//         jsonConverterString: match.group(1)!,
//         clientTypeString: clientType.getDisplayString(withNullability: true),
//         firestoreTypeString:
//             firestoreType.getDisplayString(withNullability: true),
//       );
//     }
//   }
// }
