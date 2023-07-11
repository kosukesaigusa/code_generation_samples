// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:json_annotation/json_annotation.dart';

// /// # UpdateFoo クラス生成の方針整理
// ///
// /// ## 基本
// ///
// /// - ドキュメント ID や Reference などは readOnly なので指定不要
// /// - すべてのフィールドは任意指定
// /// - デフォルト値を与えることができる
// /// - FieldValue の取り扱いは Create と同じ
// /// - JsonConverter が指定されているフィールドは、その toJson を使用する
// /// - 書き込み時のデフォルト値と JsonConverter がどちらも指定されている場合は、
// /// 値が与えられていない場合はその書き込み時のデフォルト値を使用しつつ、与えられて
// /// いる場合は JsonConverter の toJson を使用する？
// ///
// class UpdateAppUserPost {
//   const UpdateAppUserPost({
//     this.text,
//     this.textWithDefault,
//     this.number,
//     this.fieldValueAllowedNumber,
//     this.fieldValueAllowedNumberWithDefault,
//     this.nullableDateTime,
//     this.fieldValueAllowedNullableDateTime,
//     this.dateTimeWithJsonConverter,
//     this.foo,
//   });

//   final String? text;

//   // @UpdateDefault('defaultText')
//   final String? textWithDefault;

//   final int? number;

//   // @AllowFieldValue
//   final FirestoreData<int>? fieldValueAllowedNumber;

//   // @AllowFieldValue
//   // @UpdateDefault(0)
//   final FirestoreData<int>? fieldValueAllowedNumberWithDefault;

//   final DateTime? nullableDateTime;

//   // @AllowFieldValue
//   final FirestoreData<DateTime>? fieldValueAllowedNullableDateTime;

//   // @_AutoServerTimestampJsonConverter()
//   final DateTime? dateTimeWithJsonConverter;

//   // UpdateDefault(const Foo('bar'))
//   final Foo? foo;

//   Map<String, dynamic> toJson() {
//     return {
//       if (text != null) 'text': text,
//       'textWithDefault': textWithDefault ?? 'defaultText',
//       'number': number,
//       if (fieldValueAllowedNumber != null)
//         'fieldValueAllowedNumber': fieldValueAllowedNumber!.value,
//       'fieldValueAllowedNumberWithDefault':
//           fieldValueAllowedNumberWithDefault?.value ?? 0,
//       if (nullableDateTime != null) 'nullableDateTime': nullableDateTime,
//       if (fieldValueAllowedNullableDateTime != null)
//         'fieldValueAllowedNullableDateTime':
//             fieldValueAllowedNullableDateTime!.value,
//       if (dateTimeWithJsonConverter != null)
//         'nullableDateTimeWithJsonConverter':
//             const _AutoServerTimestampJsonConverter()
//                 .toJson(dateTimeWithJsonConverter),
//       'foo': foo == null
//           ? const Foo('bar')
//           : const _FooJsonConverter().toJson(foo!),
//     };
//   }
// }

// sealed class FirestoreData<T> {
//   const FirestoreData();

//   dynamic get value {
//     return switch (this) {
//       FieldValueData(fieldValue: final fieldValue) => fieldValue,
//       ActualValue(value: final value) => value,
//     };
//   }
// }

// final class FieldValueData<T> extends FirestoreData<T> {
//   const FieldValueData(this.fieldValue);

//   final FieldValue fieldValue;
// }

// final class ActualValue<T> extends FirestoreData<T> {
//   const ActualValue(this.value);

//   @override
//   final T value;
// }

// class _AutoServerTimestampJsonConverter
//     implements JsonConverter<DateTime?, Object> {
//   const _AutoServerTimestampJsonConverter();

//   @override
//   DateTime fromJson(Object json) {
//     final timestamp = json as Timestamp;
//     return timestamp.toDate();
//   }

//   @override
//   Object toJson(DateTime? dateTime) {
//     if (dateTime == null) {
//       return FieldValue.serverTimestamp();
//     }
//     return Timestamp.fromDate(dateTime);
//   }
// }

// class Foo {
//   const Foo(this.bar);

//   final String bar;
// }

// class _FooJsonConverter implements JsonConverter<Foo, Map<String, dynamic>> {
//   const _FooJsonConverter();

//   @override
//   Foo fromJson(Map<String, dynamic> json) {
//     final bar = json['bar'] as String;
//     return Foo(bar);
//   }

//   @override
//   Map<String, dynamic> toJson(Foo foo) {
//     return <String, dynamic>{'bar': foo.bar};
//   }
// }
