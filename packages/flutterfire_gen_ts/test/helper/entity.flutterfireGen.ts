import * as admin from 'firebase-admin'
import {
    DocumentReference,
    FieldValue,
    QueryDocumentSnapshot,
    QuerySnapshot,
    WriteResult
} from 'firebase-admin/firestore'

export class ReadEntity {
  constructor ({
    entityId,
    path,
    text,
textWithDefault,
nullableText,
integer,
integerWithDefault,
nullableInteger,
doubleNumber,
doubleNumberWithDefault,
nullableDoubleNumber,
isBool,
isBoolWithDefault,
nullableIsBool,
texts,
textsWithDefault,
nullableTexts,
map,
mapWithDefault,
nullableMap,
stringMap,
stringMapWithDefault,
nullableStringMap,
nestedMap,
nestedMapWithDefault,
nullableNestedMap,
listMap,
listMapWithDefault,
nullableListMap,
mapList,
mapListWithDefault,
nullableMapList,
geoPoint,
geoPointWithDefault,
nullableGeoPoint,
dateTime,
nullableDateTime,
timestamp,
nullableTimestamp,
documentReference,
nullableDocumentReference,
foo,
fooWithDefault,
nullableFoo,
nullableFooWithDefaultAnnotation,
nullableFooWithDefaultValueInConstructor,
fieldValueAllowedInt,
fieldValueAllowedNullableInt,
fieldValueAllowedNullableIntWithDefaultAnnotation,
fieldValueAllowedNullableIntWithDefaultInConstructor,
  }: {
    entityId: string
    path: string
    text: string
textWithDefault: string
nullableText?: string
integer: number
integerWithDefault: number
nullableInteger?: number
doubleNumber: number
doubleNumberWithDefault: number
nullableDoubleNumber?: number
isBool: boolean
isBoolWithDefault: boolean
nullableIsBool?: boolean
texts: string[]
textsWithDefault: string[]
nullableTexts?: string[]
map: Record<string, String, dynamic>
mapWithDefault: Record<string, String, dynamic>
nullableMap?: Record<string, String, dynamic>
stringMap: Record<string, String, String>
stringMapWithDefault: Record<string, String, String>
nullableStringMap?: Record<string, String, String>
nestedMap: Record<string, String, Map<String, int>>
nestedMapWithDefault: Record<string, String, Map<String, int>>
nullableNestedMap?: Record<string, String, Map<String, int>>
listMap: Record<string, String, List<int>>
listMapWithDefault: Record<string, String, List<int>>
nullableListMap?: Record<string, String, List<int>>
mapList: Record<string, String, int>[]
mapListWithDefault: Record<string, String, int>[]
nullableMapList?: Record<string, String, int>[]
geoPoint: GeoPoint
geoPointWithDefault: GeoPoint
nullableGeoPoint?: GeoPoint
dateTime: Date
nullableDateTime?: Date
timestamp: Timestamp
nullableTimestamp?: Timestamp
documentReference: DocumentReference<Object?>
nullableDocumentReference?: DocumentReference<Object?>
foo: Foo
fooWithDefault: Foo
nullableFoo?: Foo
nullableFooWithDefaultAnnotation?: Foo
nullableFooWithDefaultValueInConstructor?: Foo
fieldValueAllowedInt: number
fieldValueAllowedNullableInt?: number
fieldValueAllowedNullableIntWithDefaultAnnotation?: number
fieldValueAllowedNullableIntWithDefaultInConstructor?: number
  }) {
    this.entityId = entityId
    this.path = path
    this.text = text
this.textWithDefault = textWithDefault
this.nullableText = nullableText
this.integer = integer
this.integerWithDefault = integerWithDefault
this.nullableInteger = nullableInteger
this.doubleNumber = doubleNumber
this.doubleNumberWithDefault = doubleNumberWithDefault
this.nullableDoubleNumber = nullableDoubleNumber
this.isBool = isBool
this.isBoolWithDefault = isBoolWithDefault
this.nullableIsBool = nullableIsBool
this.texts = texts
this.textsWithDefault = textsWithDefault
this.nullableTexts = nullableTexts
this.map = map
this.mapWithDefault = mapWithDefault
this.nullableMap = nullableMap
this.stringMap = stringMap
this.stringMapWithDefault = stringMapWithDefault
this.nullableStringMap = nullableStringMap
this.nestedMap = nestedMap
this.nestedMapWithDefault = nestedMapWithDefault
this.nullableNestedMap = nullableNestedMap
this.listMap = listMap
this.listMapWithDefault = listMapWithDefault
this.nullableListMap = nullableListMap
this.mapList = mapList
this.mapListWithDefault = mapListWithDefault
this.nullableMapList = nullableMapList
this.geoPoint = geoPoint
this.geoPointWithDefault = geoPointWithDefault
this.nullableGeoPoint = nullableGeoPoint
this.dateTime = dateTime
this.nullableDateTime = nullableDateTime
this.timestamp = timestamp
this.nullableTimestamp = nullableTimestamp
this.documentReference = documentReference
this.nullableDocumentReference = nullableDocumentReference
this.foo = foo
this.fooWithDefault = fooWithDefault
this.nullableFoo = nullableFoo
this.nullableFooWithDefaultAnnotation = nullableFooWithDefaultAnnotation
this.nullableFooWithDefaultValueInConstructor = nullableFooWithDefaultValueInConstructor
this.fieldValueAllowedInt = fieldValueAllowedInt
this.fieldValueAllowedNullableInt = fieldValueAllowedNullableInt
this.fieldValueAllowedNullableIntWithDefaultAnnotation = fieldValueAllowedNullableIntWithDefaultAnnotation
this.fieldValueAllowedNullableIntWithDefaultInConstructor = fieldValueAllowedNullableIntWithDefaultInConstructor
  }

  readonly entityId: string

  readonly path: string

  readonly text: string

readonly textWithDefault: string

readonly nullableText?: string

readonly integer: number

readonly integerWithDefault: number

readonly nullableInteger?: number

readonly doubleNumber: number

readonly doubleNumberWithDefault: number

readonly nullableDoubleNumber?: number

readonly isBool: boolean

readonly isBoolWithDefault: boolean

readonly nullableIsBool?: boolean

readonly texts: string[]

readonly textsWithDefault: string[]

readonly nullableTexts?: string[]

readonly map: Record<string, String, dynamic>

readonly mapWithDefault: Record<string, String, dynamic>

readonly nullableMap?: Record<string, String, dynamic>

readonly stringMap: Record<string, String, String>

readonly stringMapWithDefault: Record<string, String, String>

readonly nullableStringMap?: Record<string, String, String>

readonly nestedMap: Record<string, String, Map<String, int>>

readonly nestedMapWithDefault: Record<string, String, Map<String, int>>

readonly nullableNestedMap?: Record<string, String, Map<String, int>>

readonly listMap: Record<string, String, List<int>>

readonly listMapWithDefault: Record<string, String, List<int>>

readonly nullableListMap?: Record<string, String, List<int>>

readonly mapList: Record<string, String, int>[]

readonly mapListWithDefault: Record<string, String, int>[]

readonly nullableMapList?: Record<string, String, int>[]

readonly geoPoint: GeoPoint

readonly geoPointWithDefault: GeoPoint

readonly nullableGeoPoint?: GeoPoint

readonly dateTime: Date

readonly nullableDateTime?: Date

readonly timestamp: Timestamp

readonly nullableTimestamp?: Timestamp

readonly documentReference: DocumentReference<Object?>

readonly nullableDocumentReference?: DocumentReference<Object?>

readonly foo: Foo

readonly fooWithDefault: Foo

readonly nullableFoo?: Foo

readonly nullableFooWithDefaultAnnotation?: Foo

readonly nullableFooWithDefaultValueInConstructor?: Foo

readonly fieldValueAllowedInt: number

readonly fieldValueAllowedNullableInt?: number

readonly fieldValueAllowedNullableIntWithDefaultAnnotation?: number

readonly fieldValueAllowedNullableIntWithDefaultInConstructor?: number

  private static fromJson(json: Record<string, unknown>): ReadEntity {
    return new ReadEntity({
      entityId: json['entityId'] as string,
      path: json['path'] as string,
      text: json['text'] as string,
textWithDefault: (json['textWithDefault'] as string | undefined) ?? 'requiredWithDefault',
nullableText: (json['nullableText'] as string | undefined) ?? 'defaultText',
integer: json['integer'] as number,
integerWithDefault: (json['integerWithDefault'] as number | undefined) ?? 0,
nullableInteger: (json['nullableInteger'] as number | undefined) ?? 0,
doubleNumber: json['doubleNumber'] as number,
doubleNumberWithDefault: (json['doubleNumberWithDefault'] as number | undefined) ?? 3.14,
nullableDoubleNumber: (json['nullableDoubleNumber'] as number | undefined) ?? 3.14,
isBool: json['isBool'] as boolean,
isBoolWithDefault: (json['isBoolWithDefault'] as boolean | undefined) ?? false,
nullableIsBool: (json['nullableIsBool'] as boolean | undefined) ?? false,
texts: (json['texts'] as unknown[]).map((e) => e as string).toList(),
textsWithDefault: (json['textsWithDefault'] as (unknown[]  | undefined))?.map((e) => e as string).toList() ?? const <String>['requiredWithDefault'],
nullableTexts: (json['nullableTexts'] as (unknown[] | undefined))?.map((e) => e as string).toList() ?? const <String>[],
map: json['map'] as Record<string, unknown>,
mapWithDefault: json['mapWithDefault'] as (Record<string, unknown> | undefined) ?? const <String, dynamic>{},
nullableMap: json['nullableMap'] as (Record<string, unknown> | undefined) ?? const <String, dynamic>{},
stringMap: (json['stringMap'] as Record<string, unknown>).map((k, v) => MapEntry(k, v as string)),
stringMapWithDefault: (json['stringMapWithDefault'] as (Record<string, unknown> | undefined))?.map((k, v) => MapEntry(k, v as string)) ?? const <String, String>{},
nullableStringMap: (json['nullableStringMap'] as (Record<string, unknown> | undefined))?.map((k, v) => MapEntry(k, v as string)) ?? const <String, String>{},
nestedMap: (json['nestedMap'] as Record<string, unknown>).map((k, v) => MapEntry(k, (v as Record<string, unknown>).map((k, v) => MapEntry(k, v as number)))),
nestedMapWithDefault: (json['nestedMapWithDefault'] as (Record<string, unknown> | undefined))?.map((k, v) => MapEntry(k, (v as Record<string, unknown>).map((k, v) => MapEntry(k, v as number)))) ?? const <String, Map<String, int>>{'requiredWithDefault' : <String, int>{}},
nullableNestedMap: (json['nullableNestedMap'] as (Record<string, unknown> | undefined))?.map((k, v) => MapEntry(k, (v as Record<string, unknown>).map((k, v) => MapEntry(k, v as number)))) ?? const <String, Map<String, int>>{},
listMap: (json['listMap'] as Record<string, unknown>).map((k, v) => MapEntry(k, (v as unknown[]).map((e) => e as number).toList())),
listMapWithDefault: (json['listMapWithDefault'] as (Record<string, unknown> | undefined))?.map((k, v) => MapEntry(k, (v as unknown[]).map((e) => e as number).toList())) ?? const <String, List<int>>{'requiredWithDefault' : <int>[]},
nullableListMap: (json['nullableListMap'] as (Record<string, unknown> | undefined))?.map((k, v) => MapEntry(k, (v as unknown[]).map((e) => e as number).toList())) ?? const <String, List<int>>{},
mapList: (json['mapList'] as unknown[]).map((e) => (e as Record<string, unknown>).map((k, v) => MapEntry(k, v as number))).toList(),
mapListWithDefault: (json['mapListWithDefault'] as (unknown[]  | undefined))?.map((e) => (e as Record<string, unknown>).map((k, v) => MapEntry(k, v as number))).toList() ?? const <Map<String, int>>[<String, int>{'requiredWithDefault' : 0}],
nullableMapList: (json['nullableMapList'] as (unknown[] | undefined))?.map((e) => (e as Record<string, unknown>).map((k, v) => MapEntry(k, v as number))).toList() ?? const <Map<String, int>>[],
geoPoint: json['geoPoint'] as GeoPoint,
geoPointWithDefault: (json['geoPointWithDefault'] as GeoPoint | undefined) ?? const GeoPoint(0, 0),
nullableGeoPoint: (json['nullableGeoPoint'] as GeoPoint | undefined) ?? const GeoPoint(0, 0),
dateTime: (json['dateTime'] as FirebaseFirestore.Timestamp).toDate(),
nullableDateTime: (json['nullableDateTime'] as FirebaseFirestore.Timestamp | undefined)?.toDate(),
timestamp: json['timestamp'] as Timestamp,
nullableTimestamp: json['nullableTimestamp'] as Timestamp | undefined,
documentReference: json['documentReference'] as DocumentReference<Object?>,
nullableDocumentReference: json['nullableDocumentReference'] as DocumentReference<Object?> | undefined,
foo: json['foo'] as Foo,
fooWithDefault: (json['fooWithDefault'] as Foo | undefined) ?? const Foo('requiredWithDefault'),
nullableFoo: json['nullableFoo'] as Foo | undefined,
nullableFooWithDefaultAnnotation: json['nullableFooWithDefaultAnnotation'] as Foo | undefined,
nullableFooWithDefaultValueInConstructor: (json['nullableFooWithDefaultValueInConstructor'] as Foo | undefined) ?? const Foo('defaultBar'),
fieldValueAllowedInt: json['fieldValueAllowedInt'] as number,
fieldValueAllowedNullableInt: json['fieldValueAllowedNullableInt'] as number | undefined,
fieldValueAllowedNullableIntWithDefaultAnnotation: json['fieldValueAllowedNullableIntWithDefaultAnnotation'] as number | undefined,
fieldValueAllowedNullableIntWithDefaultInConstructor: (json['fieldValueAllowedNullableIntWithDefaultInConstructor'] as number | undefined) ?? 0,
    })
  }


  static fromDocumentSnapshot(
    ds: FirebaseFirestore.DocumentSnapshot
  ): ReadEntity {
      const data = ds.data()!
      const cleanedData: Record<string, unknown> = {}
      for (const [key, value] of Object.entries(data)) {
          cleanedData[key] = value === null ? undefined : value
      }
      return ReadEntity.fromJson({
          ...cleanedData,
          entityId: ds.id,
          path: ds.ref.path
      })
  }

}

export class CreateEntity {
  constructor({
    text,
textWithDefault,
nullableText,
integer,
integerWithDefault,
nullableInteger,
doubleNumber,
doubleNumberWithDefault,
nullableDoubleNumber,
isBool,
isBoolWithDefault,
nullableIsBool,
texts,
textsWithDefault,
nullableTexts,
map,
mapWithDefault,
nullableMap,
stringMap,
stringMapWithDefault,
nullableStringMap,
nestedMap,
nestedMapWithDefault,
nullableNestedMap,
listMap,
listMapWithDefault,
nullableListMap,
mapList,
mapListWithDefault,
nullableMapList,
geoPoint,
geoPointWithDefault,
nullableGeoPoint,
dateTime,
nullableDateTime,
timestamp,
nullableTimestamp,
documentReference,
nullableDocumentReference,
foo,
fooWithDefault,
nullableFoo,
nullableFooWithDefaultAnnotation,
nullableFooWithDefaultValueInConstructor,
fieldValueAllowedInt,
fieldValueAllowedNullableInt,
fieldValueAllowedNullableIntWithDefaultAnnotation,
fieldValueAllowedNullableIntWithDefaultInConstructor,
  }: {
    text: string
textWithDefault: string
nullableText?: string
integer: number
integerWithDefault: number
nullableInteger?: number
doubleNumber: number
doubleNumberWithDefault: number
nullableDoubleNumber?: number
isBool: boolean
isBoolWithDefault: boolean
nullableIsBool?: boolean
texts: string[]
textsWithDefault: string[]
nullableTexts?: string[]
map: Record<string, String, dynamic>
mapWithDefault: Record<string, String, dynamic>
nullableMap?: Record<string, String, dynamic>
stringMap: Record<string, String, String>
stringMapWithDefault: Record<string, String, String>
nullableStringMap?: Record<string, String, String>
nestedMap: Record<string, String, Map<String, int>>
nestedMapWithDefault: Record<string, String, Map<String, int>>
nullableNestedMap?: Record<string, String, Map<String, int>>
listMap: Record<string, String, List<int>>
listMapWithDefault: Record<string, String, List<int>>
nullableListMap?: Record<string, String, List<int>>
mapList: Record<string, String, int>[]
mapListWithDefault: Record<string, String, int>[]
nullableMapList?: Record<string, String, int>[]
geoPoint: GeoPoint
geoPointWithDefault: GeoPoint
nullableGeoPoint?: GeoPoint
dateTime: Date
nullableDateTime?: Date
timestamp: Timestamp
nullableTimestamp?: Timestamp
documentReference: DocumentReference<Object?>
nullableDocumentReference?: DocumentReference<Object?>
foo: Foo
fooWithDefault: Foo
nullableFoo?: Foo
nullableFooWithDefaultAnnotation?: Foo
nullableFooWithDefaultValueInConstructor?: Foo
fieldValueAllowedInt: number
fieldValueAllowedNullableInt?: number
fieldValueAllowedNullableIntWithDefaultAnnotation?: number
fieldValueAllowedNullableIntWithDefaultInConstructor?: number
  }) {
    this.text = text
this.textWithDefault = textWithDefault
this.nullableText = nullableText
this.integer = integer
this.integerWithDefault = integerWithDefault
this.nullableInteger = nullableInteger
this.doubleNumber = doubleNumber
this.doubleNumberWithDefault = doubleNumberWithDefault
this.nullableDoubleNumber = nullableDoubleNumber
this.isBool = isBool
this.isBoolWithDefault = isBoolWithDefault
this.nullableIsBool = nullableIsBool
this.texts = texts
this.textsWithDefault = textsWithDefault
this.nullableTexts = nullableTexts
this.map = map
this.mapWithDefault = mapWithDefault
this.nullableMap = nullableMap
this.stringMap = stringMap
this.stringMapWithDefault = stringMapWithDefault
this.nullableStringMap = nullableStringMap
this.nestedMap = nestedMap
this.nestedMapWithDefault = nestedMapWithDefault
this.nullableNestedMap = nullableNestedMap
this.listMap = listMap
this.listMapWithDefault = listMapWithDefault
this.nullableListMap = nullableListMap
this.mapList = mapList
this.mapListWithDefault = mapListWithDefault
this.nullableMapList = nullableMapList
this.geoPoint = geoPoint
this.geoPointWithDefault = geoPointWithDefault
this.nullableGeoPoint = nullableGeoPoint
this.dateTime = dateTime
this.nullableDateTime = nullableDateTime
this.timestamp = timestamp
this.nullableTimestamp = nullableTimestamp
this.documentReference = documentReference
this.nullableDocumentReference = nullableDocumentReference
this.foo = foo
this.fooWithDefault = fooWithDefault
this.nullableFoo = nullableFoo
this.nullableFooWithDefaultAnnotation = nullableFooWithDefaultAnnotation
this.nullableFooWithDefaultValueInConstructor = nullableFooWithDefaultValueInConstructor
this.fieldValueAllowedInt = fieldValueAllowedInt
this.fieldValueAllowedNullableInt = fieldValueAllowedNullableInt
this.fieldValueAllowedNullableIntWithDefaultAnnotation = fieldValueAllowedNullableIntWithDefaultAnnotation
this.fieldValueAllowedNullableIntWithDefaultInConstructor = fieldValueAllowedNullableIntWithDefaultInConstructor
  }

  readonly text: string

readonly textWithDefault: string

readonly nullableText?: string

readonly integer: number

readonly integerWithDefault: number

readonly nullableInteger?: number

readonly doubleNumber: number

readonly doubleNumberWithDefault: number

readonly nullableDoubleNumber?: number

readonly isBool: boolean

readonly isBoolWithDefault: boolean

readonly nullableIsBool?: boolean

readonly texts: string[]

readonly textsWithDefault: string[]

readonly nullableTexts?: string[]

readonly map: Record<string, String, dynamic>

readonly mapWithDefault: Record<string, String, dynamic>

readonly nullableMap?: Record<string, String, dynamic>

readonly stringMap: Record<string, String, String>

readonly stringMapWithDefault: Record<string, String, String>

readonly nullableStringMap?: Record<string, String, String>

readonly nestedMap: Record<string, String, Map<String, int>>

readonly nestedMapWithDefault: Record<string, String, Map<String, int>>

readonly nullableNestedMap?: Record<string, String, Map<String, int>>

readonly listMap: Record<string, String, List<int>>

readonly listMapWithDefault: Record<string, String, List<int>>

readonly nullableListMap?: Record<string, String, List<int>>

readonly mapList: Record<string, String, int>[]

readonly mapListWithDefault: Record<string, String, int>[]

readonly nullableMapList?: Record<string, String, int>[]

readonly geoPoint: GeoPoint

readonly geoPointWithDefault: GeoPoint

readonly nullableGeoPoint?: GeoPoint

readonly dateTime: Date

readonly nullableDateTime?: Date

readonly timestamp: Timestamp

readonly nullableTimestamp?: Timestamp

readonly documentReference: DocumentReference<Object?>

readonly nullableDocumentReference?: DocumentReference<Object?>

readonly foo: Foo

readonly fooWithDefault: Foo

readonly nullableFoo?: Foo

readonly nullableFooWithDefaultAnnotation?: Foo

readonly nullableFooWithDefaultValueInConstructor?: Foo

readonly fieldValueAllowedInt: number

readonly fieldValueAllowedNullableInt?: number

readonly fieldValueAllowedNullableIntWithDefaultAnnotation?: number

readonly fieldValueAllowedNullableIntWithDefaultInConstructor?: number

  toJson(): Record<string, unknown> {
  return {
    text: this.text,
textWithDefault: this.textWithDefault,
nullableText: this.nullableText ?? 'createDefault',
integer: this.integer,
integerWithDefault: this.integerWithDefault,
nullableInteger: this.nullableInteger,
doubleNumber: this.doubleNumber,
doubleNumberWithDefault: this.doubleNumberWithDefault,
nullableDoubleNumber: this.nullableDoubleNumber,
isBool: this.isBool,
isBoolWithDefault: this.isBoolWithDefault,
nullableIsBool: this.nullableIsBool,
texts: this.texts,
textsWithDefault: this.textsWithDefault,
nullableTexts: this.nullableTexts,
map: this.map,
mapWithDefault: this.mapWithDefault,
nullableMap: this.nullableMap,
stringMap: this.stringMap,
stringMapWithDefault: this.stringMapWithDefault,
nullableStringMap: this.nullableStringMap,
nestedMap: this.nestedMap,
nestedMapWithDefault: this.nestedMapWithDefault,
nullableNestedMap: this.nullableNestedMap,
listMap: this.listMap,
listMapWithDefault: this.listMapWithDefault,
nullableListMap: this.nullableListMap,
mapList: this.mapList,
mapListWithDefault: this.mapListWithDefault,
nullableMapList: this.nullableMapList,
geoPoint: this.geoPoint,
geoPointWithDefault: this.geoPointWithDefault,
nullableGeoPoint: this.nullableGeoPoint,
dateTime: this.dateTime,
nullableDateTime: this.nullableDateTime,
timestamp: this.timestamp,
nullableTimestamp: this.nullableTimestamp,
documentReference: this.documentReference,
nullableDocumentReference: this.nullableDocumentReference,
'foo': _FooJsonConverter().toJson(foo),
'fooWithDefault': _FooJsonConverter().toJson(fooWithDefault),
'nullableFoo': _nullableFooJsonConverter.toJson(nullableFoo),
nullableFooWithDefaultAnnotation: nullableFooWithDefaultAnnotation == null ? const Foo('defaultBar') : _FooJsonConverter().toJson(nullableFooWithDefaultAnnotation!),
nullableFooWithDefaultValueInConstructor: nullableFooWithDefaultValueInConstructor == null ? const Foo('defaultBar') : _FooJsonConverter().toJson(nullableFooWithDefaultValueInConstructor!),
fieldValueAllowedInt: this.fieldValueAllowedInt,
fieldValueAllowedNullableInt: this.fieldValueAllowedNullableInt,
fieldValueAllowedNullableIntWithDefaultAnnotation: this.fieldValueAllowedNullableIntWithDefaultAnnotation ?? 0,
fieldValueAllowedNullableIntWithDefaultInConstructor: this.fieldValueAllowedNullableIntWithDefaultInConstructor ?? 0,
  };
}

}

export class UpdateEntity {
  constructor({
    text,
textWithDefault,
nullableText,
integer,
integerWithDefault,
nullableInteger,
doubleNumber,
doubleNumberWithDefault,
nullableDoubleNumber,
isBool,
isBoolWithDefault,
nullableIsBool,
texts,
textsWithDefault,
nullableTexts,
map,
mapWithDefault,
nullableMap,
stringMap,
stringMapWithDefault,
nullableStringMap,
nestedMap,
nestedMapWithDefault,
nullableNestedMap,
listMap,
listMapWithDefault,
nullableListMap,
mapList,
mapListWithDefault,
nullableMapList,
geoPoint,
geoPointWithDefault,
nullableGeoPoint,
dateTime,
nullableDateTime,
timestamp,
nullableTimestamp,
documentReference,
nullableDocumentReference,
foo,
fooWithDefault,
nullableFoo,
nullableFooWithDefaultAnnotation,
nullableFooWithDefaultValueInConstructor,
fieldValueAllowedInt,
fieldValueAllowedNullableInt,
fieldValueAllowedNullableIntWithDefaultAnnotation,
fieldValueAllowedNullableIntWithDefaultInConstructor,
  }: {
    text: string
textWithDefault: string
nullableText?: string
integer: number
integerWithDefault: number
nullableInteger?: number
doubleNumber: number
doubleNumberWithDefault: number
nullableDoubleNumber?: number
isBool: boolean
isBoolWithDefault: boolean
nullableIsBool?: boolean
texts: string[]
textsWithDefault: string[]
nullableTexts?: string[]
map: Record<string, String, dynamic>
mapWithDefault: Record<string, String, dynamic>
nullableMap?: Record<string, String, dynamic>
stringMap: Record<string, String, String>
stringMapWithDefault: Record<string, String, String>
nullableStringMap?: Record<string, String, String>
nestedMap: Record<string, String, Map<String, int>>
nestedMapWithDefault: Record<string, String, Map<String, int>>
nullableNestedMap?: Record<string, String, Map<String, int>>
listMap: Record<string, String, List<int>>
listMapWithDefault: Record<string, String, List<int>>
nullableListMap?: Record<string, String, List<int>>
mapList: Record<string, String, int>[]
mapListWithDefault: Record<string, String, int>[]
nullableMapList?: Record<string, String, int>[]
geoPoint: GeoPoint
geoPointWithDefault: GeoPoint
nullableGeoPoint?: GeoPoint
dateTime: Date
nullableDateTime?: Date
timestamp: Timestamp
nullableTimestamp?: Timestamp
documentReference: DocumentReference<Object?>
nullableDocumentReference?: DocumentReference<Object?>
foo: Foo
fooWithDefault: Foo
nullableFoo?: Foo
nullableFooWithDefaultAnnotation?: Foo
nullableFooWithDefaultValueInConstructor?: Foo
fieldValueAllowedInt: number
fieldValueAllowedNullableInt?: number
fieldValueAllowedNullableIntWithDefaultAnnotation?: number
fieldValueAllowedNullableIntWithDefaultInConstructor?: number
  }) {
    this.text = text
this.textWithDefault = textWithDefault
this.nullableText = nullableText
this.integer = integer
this.integerWithDefault = integerWithDefault
this.nullableInteger = nullableInteger
this.doubleNumber = doubleNumber
this.doubleNumberWithDefault = doubleNumberWithDefault
this.nullableDoubleNumber = nullableDoubleNumber
this.isBool = isBool
this.isBoolWithDefault = isBoolWithDefault
this.nullableIsBool = nullableIsBool
this.texts = texts
this.textsWithDefault = textsWithDefault
this.nullableTexts = nullableTexts
this.map = map
this.mapWithDefault = mapWithDefault
this.nullableMap = nullableMap
this.stringMap = stringMap
this.stringMapWithDefault = stringMapWithDefault
this.nullableStringMap = nullableStringMap
this.nestedMap = nestedMap
this.nestedMapWithDefault = nestedMapWithDefault
this.nullableNestedMap = nullableNestedMap
this.listMap = listMap
this.listMapWithDefault = listMapWithDefault
this.nullableListMap = nullableListMap
this.mapList = mapList
this.mapListWithDefault = mapListWithDefault
this.nullableMapList = nullableMapList
this.geoPoint = geoPoint
this.geoPointWithDefault = geoPointWithDefault
this.nullableGeoPoint = nullableGeoPoint
this.dateTime = dateTime
this.nullableDateTime = nullableDateTime
this.timestamp = timestamp
this.nullableTimestamp = nullableTimestamp
this.documentReference = documentReference
this.nullableDocumentReference = nullableDocumentReference
this.foo = foo
this.fooWithDefault = fooWithDefault
this.nullableFoo = nullableFoo
this.nullableFooWithDefaultAnnotation = nullableFooWithDefaultAnnotation
this.nullableFooWithDefaultValueInConstructor = nullableFooWithDefaultValueInConstructor
this.fieldValueAllowedInt = fieldValueAllowedInt
this.fieldValueAllowedNullableInt = fieldValueAllowedNullableInt
this.fieldValueAllowedNullableIntWithDefaultAnnotation = fieldValueAllowedNullableIntWithDefaultAnnotation
this.fieldValueAllowedNullableIntWithDefaultInConstructor = fieldValueAllowedNullableIntWithDefaultInConstructor
  }

  readonly text: string

readonly textWithDefault: string

readonly nullableText?: string

readonly integer: number

readonly integerWithDefault: number

readonly nullableInteger?: number

readonly doubleNumber: number

readonly doubleNumberWithDefault: number

readonly nullableDoubleNumber?: number

readonly isBool: boolean

readonly isBoolWithDefault: boolean

readonly nullableIsBool?: boolean

readonly texts: string[]

readonly textsWithDefault: string[]

readonly nullableTexts?: string[]

readonly map: Record<string, String, dynamic>

readonly mapWithDefault: Record<string, String, dynamic>

readonly nullableMap?: Record<string, String, dynamic>

readonly stringMap: Record<string, String, String>

readonly stringMapWithDefault: Record<string, String, String>

readonly nullableStringMap?: Record<string, String, String>

readonly nestedMap: Record<string, String, Map<String, int>>

readonly nestedMapWithDefault: Record<string, String, Map<String, int>>

readonly nullableNestedMap?: Record<string, String, Map<String, int>>

readonly listMap: Record<string, String, List<int>>

readonly listMapWithDefault: Record<string, String, List<int>>

readonly nullableListMap?: Record<string, String, List<int>>

readonly mapList: Record<string, String, int>[]

readonly mapListWithDefault: Record<string, String, int>[]

readonly nullableMapList?: Record<string, String, int>[]

readonly geoPoint: GeoPoint

readonly geoPointWithDefault: GeoPoint

readonly nullableGeoPoint?: GeoPoint

readonly dateTime: Date

readonly nullableDateTime?: Date

readonly timestamp: Timestamp

readonly nullableTimestamp?: Timestamp

readonly documentReference: DocumentReference<Object?>

readonly nullableDocumentReference?: DocumentReference<Object?>

readonly foo: Foo

readonly fooWithDefault: Foo

readonly nullableFoo?: Foo

readonly nullableFooWithDefaultAnnotation?: Foo

readonly nullableFooWithDefaultValueInConstructor?: Foo

readonly fieldValueAllowedInt: number

readonly fieldValueAllowedNullableInt?: number

readonly fieldValueAllowedNullableIntWithDefaultAnnotation?: number

readonly fieldValueAllowedNullableIntWithDefaultInConstructor?: number

  toJson(): Record<string, unknown> {
  const json: Record<string, unknown> = {}
  if (this.text != null) {
  json['text'] = this.text
}
json['textWithDefault'] = 'updateDefault'json['nullableText'] = 'updateDefault'if (this.integer != null) {
  json['integer'] = this.integer
}
if (this.integerWithDefault != null) {
  json['integerWithDefault'] = this.integerWithDefault
}
if (this.nullableInteger != null) {
  json['nullableInteger'] = this.nullableInteger
}
if (this.doubleNumber != null) {
  json['doubleNumber'] = this.doubleNumber
}
if (this.doubleNumberWithDefault != null) {
  json['doubleNumberWithDefault'] = this.doubleNumberWithDefault
}
if (this.nullableDoubleNumber != null) {
  json['nullableDoubleNumber'] = this.nullableDoubleNumber
}
if (this.isBool != null) {
  json['isBool'] = this.isBool
}
if (this.isBoolWithDefault != null) {
  json['isBoolWithDefault'] = this.isBoolWithDefault
}
if (this.nullableIsBool != null) {
  json['nullableIsBool'] = this.nullableIsBool
}
if (this.texts != null) {
  json['texts'] = this.texts
}
if (this.textsWithDefault != null) {
  json['textsWithDefault'] = this.textsWithDefault
}
if (this.nullableTexts != null) {
  json['nullableTexts'] = this.nullableTexts
}
if (this.map != null) {
  json['map'] = this.map
}
if (this.mapWithDefault != null) {
  json['mapWithDefault'] = this.mapWithDefault
}
if (this.nullableMap != null) {
  json['nullableMap'] = this.nullableMap
}
if (this.stringMap != null) {
  json['stringMap'] = this.stringMap
}
if (this.stringMapWithDefault != null) {
  json['stringMapWithDefault'] = this.stringMapWithDefault
}
if (this.nullableStringMap != null) {
  json['nullableStringMap'] = this.nullableStringMap
}
if (this.nestedMap != null) {
  json['nestedMap'] = this.nestedMap
}
if (this.nestedMapWithDefault != null) {
  json['nestedMapWithDefault'] = this.nestedMapWithDefault
}
if (this.nullableNestedMap != null) {
  json['nullableNestedMap'] = this.nullableNestedMap
}
if (this.listMap != null) {
  json['listMap'] = this.listMap
}
if (this.listMapWithDefault != null) {
  json['listMapWithDefault'] = this.listMapWithDefault
}
if (this.nullableListMap != null) {
  json['nullableListMap'] = this.nullableListMap
}
if (this.mapList != null) {
  json['mapList'] = this.mapList
}
if (this.mapListWithDefault != null) {
  json['mapListWithDefault'] = this.mapListWithDefault
}
if (this.nullableMapList != null) {
  json['nullableMapList'] = this.nullableMapList
}
if (this.geoPoint != null) {
  json['geoPoint'] = this.geoPoint
}
if (this.geoPointWithDefault != null) {
  json['geoPointWithDefault'] = this.geoPointWithDefault
}
if (this.nullableGeoPoint != null) {
  json['nullableGeoPoint'] = this.nullableGeoPoint
}
if (this.dateTime != null) {
  json['dateTime'] = this.dateTime
}
if (this.nullableDateTime != null) {
  json['nullableDateTime'] = this.nullableDateTime
}
if (this.timestamp != null) {
  json['timestamp'] = this.timestamp
}
if (this.nullableTimestamp != null) {
  json['nullableTimestamp'] = this.nullableTimestamp
}
if (this.documentReference != null) {
  json['documentReference'] = this.documentReference
}
if (this.nullableDocumentReference != null) {
  json['nullableDocumentReference'] = this.nullableDocumentReference
}
if (foo != null) foo: _FooJsonConverter().toJson(foo!),if (fooWithDefault != null) fooWithDefault: _FooJsonConverter().toJson(fooWithDefault!),if (nullableFoo != null) nullableFoo: _nullableFooJsonConverter.toJson(nullableFoo!),if (nullableFooWithDefaultAnnotation != null) nullableFooWithDefaultAnnotation: _FooJsonConverter().toJson(nullableFooWithDefaultAnnotation!),if (nullableFooWithDefaultValueInConstructor != null) nullableFooWithDefaultValueInConstructor: _FooJsonConverter().toJson(nullableFooWithDefaultValueInConstructor!),if (this.fieldValueAllowedInt != null) {
  json['fieldValueAllowedInt'] = this.fieldValueAllowedInt
}
if (this.fieldValueAllowedNullableInt != null) {
  json['fieldValueAllowedNullableInt'] = this.fieldValueAllowedNullableInt
}
if (this.fieldValueAllowedNullableIntWithDefaultAnnotation != null) {
  json['fieldValueAllowedNullableIntWithDefaultAnnotation'] = this.fieldValueAllowedNullableIntWithDefaultAnnotation
}
if (this.fieldValueAllowedNullableIntWithDefaultInConstructor != null) {
  json['fieldValueAllowedNullableIntWithDefaultInConstructor'] = this.fieldValueAllowedNullableIntWithDefaultInConstructor
}

  return json
}

}

export class DeleteEntity {}

/**
 * A Cloud Firestore object which ignores `undefined` properties.
 */
const db = admin.firestore()
db.settings({ ignoreUndefinedProperties: true })

/**
 * Provides a reference to the entities collection for reading.
 */
export const readEntityCollectionReference = 
db
.collection('entities').withConverter<ReadEntity>({
  fromFirestore: (ds: FirebaseFirestore.DocumentSnapshot): ReadEntity => {
    return ReadEntity.fromDocumentSnapshot(ds)
  },
  toFirestore: () => {
      throw new Error(`toFirestore is not implemented for ReadEntity`)
  }
})
;

/**
 * Provides a reference to a entity document for reading.
 * @param entityId - The ID of the entity document to read.
 */
export const readEntityDocumentReference = ({
  entityId
}: {
  entityId: string
}): FirebaseFirestore.DocumentReference<ReadEntity> =>
    readEntityCollectionReference.doc(entityId);


/**
 * Provides a reference to the entities collection for creating.
 */
export const createEntityCollectionReference = 
db
.collection('entities').withConverter<CreateEntity>({
  fromFirestore: () => {
    throw new Error(`fromFirestore is not implemented for CreateEntity`)
  },
  toFirestore: (obj: CreateEntity): FirebaseFirestore.DocumentData => {
      return obj.toJson()
  }
})
;

/**
 * Provides a reference to a entity document for creating.
 * @param entityId - The ID of the entity document to read.
 */
export const createEntityDocumentReference = ({
  entityId
}: {
  entityId: string
}): FirebaseFirestore.DocumentReference<CreateEntity> =>
    createEntityCollectionReference.doc(entityId);


/**
 * Provides a reference to the entities collection for updating.
 */
export const updateEntityCollectionReference = 
db
.collection('entities').withConverter<UpdateEntity>({
  fromFirestore: () => {
    throw new Error(`fromFirestore is not implemented for UpdateEntity`)
  },
  toFirestore: (obj: UpdateEntity): FirebaseFirestore.DocumentData => {
      return obj.toJson()
  }
})
;

/**
 * Provides a reference to a entity document for updating.
 * @param entityId - The ID of the entity document to read.
 */
export const updateEntityDocumentReference = ({
  entityId
}: {
  entityId: string
}): FirebaseFirestore.DocumentReference<UpdateEntity> =>
    updateEntityCollectionReference.doc(entityId);


/**
 * Provides a reference to the entities collection for deleting.
 */
export const deleteEntityCollectionReference = 
db
.collection('entities').withConverter<DeleteEntity>({
  fromFirestore: () => {
    throw new Error(`fromFirestore is not implemented for DeleteEntity`)
  },
  toFirestore: (): FirebaseFirestore.DocumentData => {
    throw new Error(`toFirestore is not implemented for DeleteEntity`)
  }
})
;

/**
 * Provides a reference to a entity document for deleting.
 * @param entityId - The ID of the entity document to read.
 */
export const deleteEntityDocumentReference = ({
  entityId
}: {
  entityId: string
}): FirebaseFirestore.DocumentReference<DeleteEntity> =>
    deleteEntityCollectionReference.doc(entityId);



/**
 * Manages queries against the entities collection.
 */
export class EntityQuery {
  /**
   * Fetches entity documents.
   * @param queryBuilder - Function to modify the query.
   * @param compare - Function to sort the results.
   */
  async fetchDocuments({
      queryBuilder,
      compare
  }: {
      queryBuilder?: (
          query: FirebaseFirestore.Query<ReadEntity>
      ) => FirebaseFirestore.Query<ReadEntity>
      compare?: (lhs: ReadEntity, rhs: ReadEntity) => number
  } = {}): Promise<ReadEntity[]> {
      let query: FirebaseFirestore.Query<ReadEntity> =
          readEntityCollectionReference
      if (queryBuilder != undefined) {
          query = queryBuilder(query)
      }
      const qs: QuerySnapshot<ReadEntity> = await query.get()
      let result = qs.docs.map((qds: QueryDocumentSnapshot<ReadEntity>) =>
          qds.data()
      )
      if (compare != undefined) {
          result = result.sort(compare)
      }
      return result
  }

  /**
   * Fetches a specific entity document.
   * @param entityId - The ID of the entity document to fetch.
   */
  async fetchDocument(entityId: string): Promise<ReadEntity | undefined> {
      const ds = await readEntityDocumentReference({ entityId }).get()
      return ds.data()
  }

  /**
   * Adds a entity document.
   * @param createEntity - The entity details to add.
   */
  async add(createEntity: CreateEntity): Promise<DocumentReference<CreateEntity>> {
      return createEntityCollectionReference.add(createEntity)
  }

  /**
   * Sets a entity document.
   * @param entityId - The ID of the entity document to set.
   * @param createEntity - The entity details to set.
   * @param options - Options for the set operation.
   */
  async set({
      entityId,
      createEntity,
      options
  }: {
      entityId: string
      createEntity: CreateEntity
      options?: FirebaseFirestore.SetOptions
  }): Promise<WriteResult> {
      if (options == undefined) {
          return createEntityDocumentReference({ entityId }).set(createEntity)
      } else {
          return createEntityDocumentReference({ entityId }).set(
              createEntity,
              options
          )
      }
  }

  /**
   * Updates a specific entity document.
   * @param entityId - The ID of the entity document to update.
   * @param updateEntity - The details for updating the entity.
   */
  async update(entityId: string, updateEntity: UpdateEntity): Promise<WriteResult> {
      return updateEntityDocumentReference({ entityId }).update(
          updateEntity.toJson()
      )
  }

  /**
   * Deletes a specific entity document.
   * @param entityId - The ID of the entity document to delete.
   */
  async delete(entityId: string): Promise<WriteResult> {
      return deleteEntityDocumentReference({ entityId }).delete()
  }
}
