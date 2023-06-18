import '../../utils/string.dart';

///
class CopyWithTemplate {
  ///
  const CopyWithTemplate({
    required this.readClassName,
    required this.fields,
  });

  ///
  final String readClassName;

  ///
  final Map<String, dynamic> fields;

  @override
  String toString() {
    return '''
$readClassName copyWith({
    ${fields.entries.map((entry) {
      final fieldNameString = entry.key;
      final typeNameString = entry.value as String;
      return '${typeNameString.ensureNullable()} $fieldNameString,';
    }).join('\n')}
  }) {
    return $readClassName(
      ${fields.entries.map((entry) => '${entry.key}: ${entry.key} ?? this.${entry.key},').join('\n')}
    );
  }
''';
  }
}
