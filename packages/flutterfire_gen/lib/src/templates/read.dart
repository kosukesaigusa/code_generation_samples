// import 'package:meta/meta.dart';

import '../firestore_document_visitor.dart';
import '../flutterfire_gen.dart';
import '../utils/string.dart';

/// Returns Read class template.
String readClassTemplate({
  required FirestoreDocumentConfig config,
  required FirestoreDocumentVisitor visitor,
  required Map<String, dynamic> fields,
}) {
  return '''
class ${config.readClassName} {
  const ${config.readClassName}({
    ${fields.entries.map((entry) => 'required this.${entry.key},').join('\n')}
  });

  ${fields.entries.map((entry) => 'final ${entry.value} ${entry.key};').join('\n')}

  Map<String, dynamic> toJson() {
    return {
      ${fields.entries.map((entry) => "'${entry.key}': ${entry.key},").join('\n')}
    };
  }

  factory ${config.readClassName}.fromJson(Map<String, dynamic> json) {
    return ${config.readClassName}(
      ${fields.entries.map((entry) {
    final fieldNameString = entry.key;
    final typeNameString = entry.value as String;
    final defaultValue = visitor.defaultValues[fieldNameString];
    // TODO: ここのロジックを良い感じにリファクタする
    // TODO: Map の場合も Map<String, dynamic> でない場合の考慮が必要なはず
    if (typeNameString.startsWith('List')) {
      // if (defaultValue != null) {
      //   return "$fieldNameString: (json['$fieldNameString'] as List<dynamic>?)?.map((e) => e as String).toList() ?? $defaultValue,";
      // } else {
      //   return "$fieldNameString: (json['$fieldNameString'] as List<dynamic>).map((e) => e as String).toList(),";
      // }
      return fromJsonEachField(
        fieldNameString: fieldNameString,
        typeNameString: typeNameString,
      );
    }
    if (defaultValue != null) {
      return "$fieldNameString: json['$fieldNameString'] as ${typeNameString.ensureNullable()} ?? $defaultValue,";
    } else {
      return "$fieldNameString: json['$fieldNameString'] as $typeNameString,";
    }
  }).join('\n')}
    );
  }

  factory ${config.readClassName}.fromDocumentSnapshot(DocumentSnapshot ds) {
    final data = ds.data()! as Map<String, dynamic>;
    return ${config.readClassName}.fromJson(<String, dynamic>{
      ...data,
      '${config.documentName}Id': ds.id,
    });
  }

  ${config.readClassName} copyWith({
    ${fields.entries.map((entry) {
    final fieldNameString = entry.key;
    final typeNameString = entry.value as String;
    return '${typeNameString.ensureNullable()} $fieldNameString,';
  }).join('\n')}
  }) {
    return ${config.readClassName}(
      ${fields.entries.map((entry) => '${entry.key}: ${entry.key} ?? this.${entry.key},').join('\n')}
    );
  }
}
''';
}

String fromJsonEachField({
  required String fieldNameString,
  required String typeNameString,
  Object? defaultValue,
}) {
  final listItemType = typeNameString.substring(
    typeNameString.indexOf('<') + 1,
    typeNameString.indexOf('>'),
  );
  if (defaultValue != null) {
    // ignore: missing_whitespace_between_adjacent_strings
    return "$fieldNameString: (json['$fieldNameString'] as List<dynamic>?)?"
        '.map((e) => e as $listItemType).toList() ?? $defaultValue,';
  } else {
    // ignore: missing_whitespace_between_adjacent_strings
    return "$fieldNameString: (json['$fieldNameString'] as List<dynamic>)"
        '.map((e) => e as $listItemType).toList(),';
  }
}
