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
geoPoint: InvalidType
geoPointWithDefault: InvalidType
nullableGeoPoint: InvalidType
dateTime: Date
nullableDateTime?: Date
timestamp: InvalidType
nullableTimestamp: InvalidType
documentReference: InvalidType
nullableDocumentReference: InvalidType
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

readonly geoPoint: InvalidType

readonly geoPointWithDefault: InvalidType

readonly nullableGeoPoint: InvalidType

readonly dateTime: Date

readonly nullableDateTime?: Date

readonly timestamp: InvalidType

readonly nullableTimestamp: InvalidType

readonly documentReference: InvalidType

readonly nullableDocumentReference: InvalidType

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
geoPoint: json['geoPoint'] as InvalidType,
geoPointWithDefault: (json['geoPointWithDefault'] as InvalidType | undefined) ?? const GeoPoint(0, 0),
nullableGeoPoint: (json['nullableGeoPoint'] as InvalidType | undefined) ?? const GeoPoint(0, 0),
dateTime: (json['dateTime'] as FirebaseFirestore.Timestamp).toDate(),
nullableDateTime: (json['nullableDateTime'] as FirebaseFirestore.Timestamp | undefined)?.toDate(),
timestamp: json['timestamp'] as InvalidType,
nullableTimestamp: json['nullableTimestamp'] as InvalidType,
documentReference: json['documentReference'] as InvalidType,
nullableDocumentReference: json['nullableDocumentReference'] as InvalidType,
foo: json['foo'] as Foo,
fooWithDefault: (json['fooWithDefault'] as Foo | undefined) ?? const Foo('requiredWithDefault'),
nullableFoo: json['nullableFoo'] as Foo | undefined,
nullableFooWithDefaultAnnotation: json['nullableFooWithDefaultAnnotation'] as Foo | undefined,
nullableFooWithDefaultValueInConstructor: json['nullableFooWithDefaultValueInConstructor'] as Foo | undefined,
fieldValueAllowedInt: json['fieldValueAllowedInt'] as number,
fieldValueAllowedNullableInt: json['fieldValueAllowedNullableInt'] as number | undefined,
fieldValueAllowedNullableIntWithDefaultAnnotation: json['fieldValueAllowedNullableIntWithDefaultAnnotation'] as number | undefined,
fieldValueAllowedNullableIntWithDefaultInConstructor: json['fieldValueAllowedNullableIntWithDefaultInConstructor'] as number | undefined,
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
geoPoint: InvalidType
geoPointWithDefault: InvalidType
nullableGeoPoint: InvalidType
dateTime: Date
nullableDateTime?: Date
timestamp: InvalidType
nullableTimestamp: InvalidType
documentReference: InvalidType
nullableDocumentReference: InvalidType
foo: Foo
fooWithDefault: Foo
nullableFoo?: Foo
nullableFooWithDefaultAnnotation?: Foo
nullableFooWithDefaultValueInConstructor?: Foo
fieldValueAllowedInt: number | FieldValue
fieldValueAllowedNullableInt?: number | FieldValue
fieldValueAllowedNullableIntWithDefaultAnnotation?: number | FieldValue
fieldValueAllowedNullableIntWithDefaultInConstructor?: number | FieldValue
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

readonly geoPoint: InvalidType

readonly geoPointWithDefault: InvalidType

readonly nullableGeoPoint: InvalidType

readonly dateTime: Date

readonly nullableDateTime?: Date

readonly timestamp: InvalidType

readonly nullableTimestamp: InvalidType

readonly documentReference: InvalidType

readonly nullableDocumentReference: InvalidType

readonly foo: Foo

readonly fooWithDefault: Foo

readonly nullableFoo?: Foo

readonly nullableFooWithDefaultAnnotation?: Foo

readonly nullableFooWithDefaultValueInConstructor?: Foo

readonly fieldValueAllowedInt: number | FieldValue

readonly fieldValueAllowedNullableInt?: number | FieldValue

readonly fieldValueAllowedNullableIntWithDefaultAnnotation?: number | FieldValue

readonly fieldValueAllowedNullableIntWithDefaultInConstructor?: number | FieldValue

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
foo: this.foo,
fooWithDefault: this.fooWithDefault,
nullableFoo: this.nullableFoo,
nullableFooWithDefaultAnnotation: this.nullableFooWithDefaultAnnotation ?? const Foo('defaultBar'),
nullableFooWithDefaultValueInConstructor: this.nullableFooWithDefaultValueInConstructor,
fieldValueAllowedInt: this.fieldValueAllowedInt,
fieldValueAllowedNullableInt: this.fieldValueAllowedNullableInt,
fieldValueAllowedNullableIntWithDefaultAnnotation: this.fieldValueAllowedNullableIntWithDefaultAnnotation ?? 0,
fieldValueAllowedNullableIntWithDefaultInConstructor: this.fieldValueAllowedNullableIntWithDefaultInConstructor,
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
    text?: string
textWithDefault?: string
nullableText?: string
integer?: number
integerWithDefault?: number
nullableInteger?: number
doubleNumber?: number
doubleNumberWithDefault?: number
nullableDoubleNumber?: number
isBool?: boolean
isBoolWithDefault?: boolean
nullableIsBool?: boolean
texts?: string[]
textsWithDefault?: string[]
nullableTexts?: string[]
map?: Record<string, String, dynamic>
mapWithDefault?: Record<string, String, dynamic>
nullableMap?: Record<string, String, dynamic>
stringMap?: Record<string, String, String>
stringMapWithDefault?: Record<string, String, String>
nullableStringMap?: Record<string, String, String>
nestedMap?: Record<string, String, Map<String, int>>
nestedMapWithDefault?: Record<string, String, Map<String, int>>
nullableNestedMap?: Record<string, String, Map<String, int>>
listMap?: Record<string, String, List<int>>
listMapWithDefault?: Record<string, String, List<int>>
nullableListMap?: Record<string, String, List<int>>
mapList?: Record<string, String, int>[]
mapListWithDefault?: Record<string, String, int>[]
nullableMapList?: Record<string, String, int>[]
geoPoint?: InvalidType
geoPointWithDefault?: InvalidType
nullableGeoPoint?: InvalidType
dateTime?: Date
nullableDateTime?: Date
timestamp?: InvalidType
nullableTimestamp?: InvalidType
documentReference?: InvalidType
nullableDocumentReference?: InvalidType
foo?: Foo
fooWithDefault?: Foo
nullableFoo?: Foo
nullableFooWithDefaultAnnotation?: Foo
nullableFooWithDefaultValueInConstructor?: Foo
fieldValueAllowedInt?: number | FieldValue
fieldValueAllowedNullableInt?: number | FieldValue
fieldValueAllowedNullableIntWithDefaultAnnotation?: number | FieldValue
fieldValueAllowedNullableIntWithDefaultInConstructor?: number | FieldValue
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


  readonly text?: string

readonly textWithDefault?: string

readonly nullableText?: string

readonly integer?: number

readonly integerWithDefault?: number

readonly nullableInteger?: number

readonly doubleNumber?: number

readonly doubleNumberWithDefault?: number

readonly nullableDoubleNumber?: number

readonly isBool?: boolean

readonly isBoolWithDefault?: boolean

readonly nullableIsBool?: boolean

readonly texts?: string[]

readonly textsWithDefault?: string[]

readonly nullableTexts?: string[]

readonly map?: Record<string, String, dynamic>

readonly mapWithDefault?: Record<string, String, dynamic>

readonly nullableMap?: Record<string, String, dynamic>

readonly stringMap?: Record<string, String, String>

readonly stringMapWithDefault?: Record<string, String, String>

readonly nullableStringMap?: Record<string, String, String>

readonly nestedMap?: Record<string, String, Map<String, int>>

readonly nestedMapWithDefault?: Record<string, String, Map<String, int>>

readonly nullableNestedMap?: Record<string, String, Map<String, int>>

readonly listMap?: Record<string, String, List<int>>

readonly listMapWithDefault?: Record<string, String, List<int>>

readonly nullableListMap?: Record<string, String, List<int>>

readonly mapList?: Record<string, String, int>[]

readonly mapListWithDefault?: Record<string, String, int>[]

readonly nullableMapList?: Record<string, String, int>[]

readonly geoPoint?: InvalidType

readonly geoPointWithDefault?: InvalidType

readonly nullableGeoPoint?: InvalidType

readonly dateTime?: Date

readonly nullableDateTime?: Date

readonly timestamp?: InvalidType

readonly nullableTimestamp?: InvalidType

readonly documentReference?: InvalidType

readonly nullableDocumentReference?: InvalidType

readonly foo?: Foo

readonly fooWithDefault?: Foo

readonly nullableFoo?: Foo

readonly nullableFooWithDefaultAnnotation?: Foo

readonly nullableFooWithDefaultValueInConstructor?: Foo

readonly fieldValueAllowedInt?: number | FieldValue

readonly fieldValueAllowedNullableInt?: number | FieldValue

readonly fieldValueAllowedNullableIntWithDefaultAnnotation?: number | FieldValue

readonly fieldValueAllowedNullableIntWithDefaultInConstructor?: number | FieldValue

  toJson(): Record<string, unknown> {
  const json: Record<string, unknown> = {}
  if (this.text != undefined) {
  json['text'] = this.text
}
json['textWithDefault'] = 'updateDefault'json['nullableText'] = 'updateDefault'if (this.integer != undefined) {
  json['integer'] = this.integer
}
if (this.integerWithDefault != undefined) {
  json['integerWithDefault'] = this.integerWithDefault
}
if (this.nullableInteger != undefined) {
  json['nullableInteger'] = this.nullableInteger
}
if (this.doubleNumber != undefined) {
  json['doubleNumber'] = this.doubleNumber
}
if (this.doubleNumberWithDefault != undefined) {
  json['doubleNumberWithDefault'] = this.doubleNumberWithDefault
}
if (this.nullableDoubleNumber != undefined) {
  json['nullableDoubleNumber'] = this.nullableDoubleNumber
}
if (this.isBool != undefined) {
  json['isBool'] = this.isBool
}
if (this.isBoolWithDefault != undefined) {
  json['isBoolWithDefault'] = this.isBoolWithDefault
}
if (this.nullableIsBool != undefined) {
  json['nullableIsBool'] = this.nullableIsBool
}
if (this.texts != undefined) {
  json['texts'] = this.texts
}
if (this.textsWithDefault != undefined) {
  json['textsWithDefault'] = this.textsWithDefault
}
if (this.nullableTexts != undefined) {
  json['nullableTexts'] = this.nullableTexts
}
if (this.map != undefined) {
  json['map'] = this.map
}
if (this.mapWithDefault != undefined) {
  json['mapWithDefault'] = this.mapWithDefault
}
if (this.nullableMap != undefined) {
  json['nullableMap'] = this.nullableMap
}
if (this.stringMap != undefined) {
  json['stringMap'] = this.stringMap
}
if (this.stringMapWithDefault != undefined) {
  json['stringMapWithDefault'] = this.stringMapWithDefault
}
if (this.nullableStringMap != undefined) {
  json['nullableStringMap'] = this.nullableStringMap
}
if (this.nestedMap != undefined) {
  json['nestedMap'] = this.nestedMap
}
if (this.nestedMapWithDefault != undefined) {
  json['nestedMapWithDefault'] = this.nestedMapWithDefault
}
if (this.nullableNestedMap != undefined) {
  json['nullableNestedMap'] = this.nullableNestedMap
}
if (this.listMap != undefined) {
  json['listMap'] = this.listMap
}
if (this.listMapWithDefault != undefined) {
  json['listMapWithDefault'] = this.listMapWithDefault
}
if (this.nullableListMap != undefined) {
  json['nullableListMap'] = this.nullableListMap
}
if (this.mapList != undefined) {
  json['mapList'] = this.mapList
}
if (this.mapListWithDefault != undefined) {
  json['mapListWithDefault'] = this.mapListWithDefault
}
if (this.nullableMapList != undefined) {
  json['nullableMapList'] = this.nullableMapList
}
if (this.geoPoint != undefined) {
  json['geoPoint'] = this.geoPoint
}
if (this.geoPointWithDefault != undefined) {
  json['geoPointWithDefault'] = this.geoPointWithDefault
}
if (this.nullableGeoPoint != undefined) {
  json['nullableGeoPoint'] = this.nullableGeoPoint
}
if (this.dateTime != undefined) {
  json['dateTime'] = this.dateTime
}
if (this.nullableDateTime != undefined) {
  json['nullableDateTime'] = this.nullableDateTime
}
if (this.timestamp != undefined) {
  json['timestamp'] = this.timestamp
}
if (this.nullableTimestamp != undefined) {
  json['nullableTimestamp'] = this.nullableTimestamp
}
if (this.documentReference != undefined) {
  json['documentReference'] = this.documentReference
}
if (this.nullableDocumentReference != undefined) {
  json['nullableDocumentReference'] = this.nullableDocumentReference
}
if (this.foo != undefined) {
  json['foo'] = this.foo
}
if (this.fooWithDefault != undefined) {
  json['fooWithDefault'] = this.fooWithDefault
}
if (this.nullableFoo != undefined) {
  json['nullableFoo'] = this.nullableFoo
}
if (this.nullableFooWithDefaultAnnotation != undefined) {
  json['nullableFooWithDefaultAnnotation'] = this.nullableFooWithDefaultAnnotation
}
if (this.nullableFooWithDefaultValueInConstructor != undefined) {
  json['nullableFooWithDefaultValueInConstructor'] = this.nullableFooWithDefaultValueInConstructor
}
if (this.fieldValueAllowedInt != undefined) {
  json['fieldValueAllowedInt'] = this.fieldValueAllowedInt
}
if (this.fieldValueAllowedNullableInt != undefined) {
  json['fieldValueAllowedNullableInt'] = this.fieldValueAllowedNullableInt
}
if (this.fieldValueAllowedNullableIntWithDefaultAnnotation != undefined) {
  json['fieldValueAllowedNullableIntWithDefaultAnnotation'] = this.fieldValueAllowedNullableIntWithDefaultAnnotation
}
if (this.fieldValueAllowedNullableIntWithDefaultInConstructor != undefined) {
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
  }): Promise<ReadEntity[]> {
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
  async fetchDocument({
    
    entityId
  }: {
    
    entityId: string
  }): Promise<ReadEntity | undefined> {
    const ds = await readEntityDocumentReference({
      
      entityId
    }).get()
    return ds.data()
  }

  /**
   * Adds a entity document.
   * @param CreateEntity - The entity details to add.
   */
  async add({
    
    CreateEntity
  }: {
    
    CreateEntity: CreateEntity
  }): Promise<DocumentReference<CreateEntity>> {
    return createEntityCollectionReference.add(CreateEntity)
  }

  /**
   * Sets a entity document.
   * @param entityId - The ID of the entity document to set.
   * @param CreateEntity - The entity details to set.
   * @param options - Options for the set operation.
   */
  async set({
      
      entityId,
      CreateEntity,
      options
  }: {
      
      entityId: string
      CreateEntity: CreateEntity
      options?: FirebaseFirestore.SetOptions
  }): Promise<WriteResult> {
      if (options == undefined) {
          return createEntityDocumentReference({
            
            entityId
          }).set(CreateEntity)
      } else {
          return createEntityDocumentReference({ 
            
            entityId 
            }).set(CreateEntity, options)
      }
  }

  /**
   * Updates a specific entity document.
   * @param entityId - The ID of the entity document to update.
   * @param UpdateEntity - The details for updating the entity.
   */
  async update({
    
    entityId,
    UpdateEntity
  }: {
    
    entityId: string
    UpdateEntity: UpdateEntity
  }): Promise<WriteResult> {
      return updateEntityDocumentReference({ 
        
        entityId 
      }).update(UpdateEntity.toJson())
  }

  /**
   * Deletes a specific entity document.
   * @param entityId - The ID of the entity document to delete.
   */
  async delete({
    
    entityId
  }: {
    
    entityId: string
  }): Promise<WriteResult> {
      return deleteEntityDocumentReference({ 
        
        entityId 
      }).delete()
  }
}
