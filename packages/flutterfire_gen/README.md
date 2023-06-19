# flutterfire_gen

## fromJson

fromJsonEachField

| Check | fieldNameString    | typeNameString               | defaultValueString | expected                                                                                                                                                                   |
| ----- | ------------------ | ---------------------------- | ------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| OK    | `'text'`           | `'String'`                   | `null`             | `"json['text'] as String"`                                                                                                                                                 |
| OK    | `'nullableText'`   | `'String?'`                  | `"'defaultText'"`  | `"nullableText: json['nullableText'] as String? ?? 'defaultText'"`                                                                                                         |
| OK    | `'integer'`        | `'int'`                      | `null`             | `"integer: json['integer'] as int"`                                                                                                                                        |
| OK    | `'isBool'`         | `'bool'`                     | `null`             | `"isBool: json['isBool'] as bool"`                                                                                                                                         |
| OK    | `'isNullableBool'` | `'bool?'`                    | `'false'`          | `"isNullableBool: json['isNullableBool'] as bool? ?? false"`                                                                                                               |
| OK    | `'texts'`          | `'List<String>'`             | `null`             | `"texts: (json['texts'] as List<dynamic>).map((e) => e as String).toList()"`                                                                                               |
| OK    | `'nullableTexts'`  | `'List<String>?'`            | `'<String>[]'`     | `"nullableTexts: (json['nullableTexts'] as List<dynamic>?)?.map((e) => e as String).toList() ?? <String>[]"`                                                               |
| OK    | `'twoDList'`       | `'List<List<String>>'`       | `null`             | `"twoDList: (json['twoDList'] as List<dynamic>).map((e) => (e as List<dynamic>).map((e) => e as String).toList()).toList()"`                                               |
| OK    | `'threeDList'`     | `'List<List<List<String>>>'` | `null`             | `"threeDList: (json['threeDList'] as List<dynamic>).map((e) => (e as List<dynamic>).map((e) => (e as List<dynamic>).map((e) => e as String).toList()).toList()).toList()"` |
| OK    | `'geoPoint'`       | `'GeoPoint'`                 | `null`             | `"geoPoint: json['geoPoint'] as GeoPoint"`                                                                                                                                 |
