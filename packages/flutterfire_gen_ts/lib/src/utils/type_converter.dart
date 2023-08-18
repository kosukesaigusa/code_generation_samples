///
String toTypeScriptFieldDefinitionString({
  required String dartTypeNameString,
  required String dartFieldNameString,
  bool isFieldValueAllowed = false,
}) {
  final (typeScriptTypeNameString, isUndefinedAllowed) =
      returnsTypeScriptTypeStringAndUndefinedAllowed(dartTypeNameString);
  if (isUndefinedAllowed) {
    if (isFieldValueAllowed) {
      return '$dartFieldNameString?: $typeScriptTypeNameString | FieldValue';
    } else {
      return '$dartFieldNameString?: $typeScriptTypeNameString';
    }
  } else {
    if (isFieldValueAllowed) {
      return '$dartFieldNameString: $typeScriptTypeNameString | FieldValue';
    } else {
      return '$dartFieldNameString: $typeScriptTypeNameString';
    }
  }
}

///
(String, bool) returnsTypeScriptTypeStringAndUndefinedAllowed(
  String dartTypeNameString,
) {
  var typeNameString = dartTypeNameString;
  var isUndefinedAllowed = false;
  if (dartTypeNameString.endsWith('?')) {
    typeNameString =
        dartTypeNameString.substring(0, dartTypeNameString.length - 1);
    isUndefinedAllowed = true;
  }

  // Dart の List<T> の文字列を表す正規表現
  final listTypeRegExp = RegExp(r'^List<(.*)>$');

  // Dart の Map<K,V> の文字列を表す正規表現
  final mapTypeRegExp = RegExp(r'^Map<(.*)>$');

  if (typeNameString == 'bool') {
    return ('boolean', isUndefinedAllowed);
  } else if (typeNameString == 'int' || typeNameString == 'double') {
    return ('number', isUndefinedAllowed);
  } else if (typeNameString == 'String') {
    return ('string', isUndefinedAllowed);
  } else if (typeNameString == 'DateTime') {
    return ('Date', isUndefinedAllowed);
  } else if (typeNameString == 'List') {
    return ('unknown[]', isUndefinedAllowed);
  } else if (listTypeRegExp.hasMatch(typeNameString)) {
    final match = listTypeRegExp.firstMatch(typeNameString);
    final typeArg = match!.group(1);
    final (nestedTypeNameString, nestedIsUndefinedAllowed) =
        returnsTypeScriptTypeStringAndUndefinedAllowed(typeArg!);
    if (nestedIsUndefinedAllowed) {
      return ('($nestedTypeNameString | undefined)[]', isUndefinedAllowed);
    } else {
      return ('$nestedTypeNameString[]', isUndefinedAllowed);
    }
  } else if (typeNameString == 'Map') {
    return ('Record<string, unknown>', isUndefinedAllowed);
  } else if (mapTypeRegExp.hasMatch(typeNameString)) {
    final match = mapTypeRegExp.firstMatch(typeNameString);
    final typeArg = match!.group(1);
    final (nestedTypeNameString, nestedIsUndefinedAllowed) =
        returnsTypeScriptTypeStringAndUndefinedAllowed(typeArg!);
    if (nestedIsUndefinedAllowed) {
      return (
        'Record<string, $nestedTypeNameString | undefined>',
        isUndefinedAllowed
      );
    } else {
      return ('Record<string, $nestedTypeNameString>', isUndefinedAllowed);
    }
  } else {
    return (typeNameString, isUndefinedAllowed);
  }
}
