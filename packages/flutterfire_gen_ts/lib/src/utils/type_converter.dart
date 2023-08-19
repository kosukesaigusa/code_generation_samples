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

  if (typeNameString == 'dynamic') {
    return ('unknown', isUndefinedAllowed);
  } else if (typeNameString == 'bool') {
    return ('boolean', isUndefinedAllowed);
  } else if (typeNameString == 'int' || typeNameString == 'double') {
    return ('number', isUndefinedAllowed);
  } else if (typeNameString == 'String') {
    return ('string', isUndefinedAllowed);
  } else if (typeNameString == 'DateTime') {
    return ('Date', isUndefinedAllowed);
  } else if (typeNameString == 'GeoPoint') {
    return ('GeoPoint', isUndefinedAllowed);
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
  } else if (typeNameString.startsWith('Map<')) {
    var level = 0;
    var index = 0;
    for (var i = 0; i < typeNameString.length; i++) {
      if (typeNameString[i] == '<') {
        level++;
      } else if (typeNameString[i] == '>') {
        level--;
      } else if (typeNameString[i] == ',' && level == 1) {
        index = i;
        break;
      }
    }

    final keyType = typeNameString.substring(4, index).trim();
    final valueType =
        typeNameString.substring(index + 1, typeNameString.length - 1).trim();

    final (nestedKeyTypeString, _) =
        returnsTypeScriptTypeStringAndUndefinedAllowed(keyType);
    final (nestedValueTypeString, nestedValueIsUndefinedAllowed) =
        returnsTypeScriptTypeStringAndUndefinedAllowed(valueType);

    var resultTypeString =
        'Record<$nestedKeyTypeString, $nestedValueTypeString>';
    if (nestedValueIsUndefinedAllowed) {
      resultTypeString =
          'Record<$nestedKeyTypeString, $nestedValueTypeString | undefined>';
    }

    if (isUndefinedAllowed) {
      resultTypeString += ' | undefined';
    }

    return (resultTypeString, false); // false にして、再帰呼び出しの結果をこの関数の呼び出し元に反映させる
  } else {
    return (typeNameString, isUndefinedAllowed);
  }
}

/// Dart の様々なデフォルト値の文字列を TypeScript の値の文字列に変換する。
String toTypeScriptDefaultValueString({
  required String dartTypeNameString,
  required String dartDefaultValueString,
}) {
  final (typeNameString, isUndefinedAllowed) =
      returnsTypeScriptTypeStringAndUndefinedAllowed(dartTypeNameString);

  // undefined が許可されていて、デフォルト値が null の場合
  if (isUndefinedAllowed && dartDefaultValueString == 'null') {
    return 'undefined';
  }

  // List 型の処理
  if (typeNameString.startsWith('List<') || typeNameString.endsWith('[]')) {
    return '[]';
  }

  // Map 型の処理
  if (typeNameString.startsWith('Map<') ||
      typeNameString.startsWith('Record<')) {
    return '{}';
  }

  switch (typeNameString) {
    case 'string':
      final isEmptyString = {"''", '""'}.contains(dartDefaultValueString);
      return isEmptyString ? "''" : dartDefaultValueString;
    case 'number':
      return dartDefaultValueString;
    case 'boolean':
      return dartDefaultValueString;
    case 'Date':
      return "new Date('$dartDefaultValueString')";
    case 'GeoPoint':
      // Dart の形式 'const GeoPoint(0, 0)' または 'GeoPoint(0, 0)' を
      // TypeScript の形式 'new GeoPoint(0, 0)' に変換
      return dartDefaultValueString.replaceFirst(
        RegExp(r'(const\s+)?'),
        'new ',
      );
    default:
      // その他の型に対してのエラー処理
      print('🚧 変換エラー $typeNameString $dartDefaultValueString');
      return '';
  }
}
