// TODO: ここのロジックを良い感じにリファクタする
// TODO: Map の場合も Map<String, dynamic> でない場合の考慮が必要なはず

final RegExp listType = RegExp(r'^List<(.*)>$');
final RegExp mapType = RegExp(r'^Map<(.+),\s*(.*)>$');

String parseType(
  String fieldNameString,
  String typeNameString, {
  Object? defaultValue,
}) {
  final match = listType.firstMatch(typeNameString);
  final defaultValueString = defaultValue != null ? ' ?? $defaultValue' : '';

  if (match != null) {
    final listItemType = match.group(1)!;
    final nullableSign = listItemType.endsWith('?') ? '?' : '';
    final nonNullableListItemType = listItemType.replaceAll('?', '');
    final parsedListItemType = parseType(
      fieldNameString,
      nonNullableListItemType,
      defaultValue: defaultValue,
    );
    return "(json['$fieldNameString'] as List<dynamic>$nullableSign).map((e) => $parsedListItemType).toList()$defaultValueString";
  } else {
    return "json['$fieldNameString'] as $typeNameString$defaultValueString";
  }
}

String fromJsonEachField({
  required String fieldNameString,
  required String typeNameString,
  Object? defaultValue,
}) {
  final a =
      '${parseType(fieldNameString, typeNameString, defaultValue: defaultValue)},';
  final b = '$fieldNameString: $a';
  print('⭐');
  print(b);
  print('⭐');
  return b;
}
