import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

/// # CreateFoo クラス生成の方針整理
///
/// ## 基本
///
/// - ドキュメント ID や Reference などは readOnly なので指定不要
/// - 必須フィールドは、必須指定
/// - 任意フィールドは、任意指定しながらインスタンス化できるようにする
/// - 任意フィールドは、値が与えられていない場合、書き込み時のデフォルト値が
/// 指定されていれば、そのデフォルト値で差し替える（必須フィールドにデフォルト値を
/// 指定することもできるが、無意味になる。エラー or 警告を出すこともできるけど）
/// - JsonConverter が指定されているフィールドは、その toJson を使用する
/// - 書き込み時のデフォルト値と JsonConverter がどちらも指定されている場合は、
/// 値が与えられていない場合はその書き込み時のデフォルト値を使用しつつ、与えられて
/// いる場合は JsonConverter の toJson を使用する？
///
/// ## その他
///
/// いくつか FieldValue 関係で注意が必要な型が存在する。
///
/// - num 型（int, double 型など？内部実装を確認する必要がある）: FieldValue.increment
/// - List<T> 型: FieldValue.arrayUnion, FieldValue.arrayRemove
/// - DateTime, Timestamp 型: FieldValue.serverTimestamp
/// - 他には...？（update 時のみ FieldValue.delete というのがある）
///
/// つまりそのような型に関しては sealed クラスなどで、本来の型 or FieldValue みたいな
/// 入力口を与える必要がある？？
///
/// → それもアノテーションで決めれば良さそう。つまり、使う側に端から
/// FieldValue.increment を指定するつもりもない int, double などのフィールドにも
/// 一律で FieldValue も入力できるようにラップする必要はない。オプションという認識
///
class CreateAppUserPost {
  const CreateAppUserPost({
    required this.text,
    this.nullableText,
    this.nullableTextWithDefault,
    required this.number,
    required this.fieldValueAllowedNumber,
    required this.texts,
    required this.fieldValueAllowedTexts,
    this.nullableTextsWithDefault,
    this.fieldValueAllowedNullableTextsWithDefault,
    this.nullableDateTime,
    this.fieldValueAllowedNullableDateTime,
    this.nullableDateTimeWithJsonConverter,
  });

  final String text;

  final String? nullableText;

  // @CreateDefault('defaultText')
  final String? nullableTextWithDefault;

  final int number;

  // @AllowFieldValue
  final FirestoreData<int> fieldValueAllowedNumber;

  final List<String> texts;

  // @AllowFieldValue
  final FirestoreData<List<String>> fieldValueAllowedTexts;

  // @CreateDefault(<String>[])
  final List<String>? nullableTextsWithDefault;

  // @CreateDefault(<String>[])
  // @AllowFieldValue
  final FirestoreData<List<String>>? fieldValueAllowedNullableTextsWithDefault;

  final DateTime? nullableDateTime;

  // @AllowFieldValue
  final FirestoreData<DateTime>? fieldValueAllowedNullableDateTime;

  // @_AutoServerTimestampJsonConverter()
  final DateTime? nullableDateTimeWithJsonConverter;

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'nullableText': nullableText,
      'nullableTextWithDefault': nullableTextWithDefault ?? 'defaultText',
      'number': number,
      'fieldValueAllowedNumber': fieldValueAllowedNumber.value,
      'texts': texts,
      'fieldValueAllowedTexts': fieldValueAllowedTexts.value,
      'nullableTextsWithDefault': nullableTextsWithDefault ?? <String>[],
      'fieldValueAllowedNullableTextsWithDefault':
          fieldValueAllowedNullableTextsWithDefault?.value ?? <String>[],
      'nullableDateTime': nullableDateTime,
      'fieldValueAllowedDateTime': fieldValueAllowedNullableDateTime?.value,
      'nullableDateTimeWithJsonConverter':
          const _AutoServerTimestampJsonConverter()
              .toJson(nullableDateTimeWithJsonConverter),
    };
  }
}

sealed class FirestoreData<T> {
  const FirestoreData();

  dynamic get value {
    return switch (this) {
      FieldValueData(fieldValue: final fieldValue) => fieldValue,
      ActualValue(value: final value) => value,
    };
  }
}

final class FieldValueData<T> extends FirestoreData<T> {
  const FieldValueData(this.fieldValue);

  final FieldValue fieldValue;
}

final class ActualValue<T> extends FirestoreData<T> {
  const ActualValue(this.value);

  @override
  final T value;
}

class _AutoServerTimestampJsonConverter
    implements JsonConverter<DateTime?, Object> {
  const _AutoServerTimestampJsonConverter();

  @override
  DateTime fromJson(Object json) {
    final timestamp = json as Timestamp;
    return timestamp.toDate();
  }

  @override
  Object toJson(DateTime? dateTime) {
    if (dateTime == null) {
      return FieldValue.serverTimestamp();
    }
    return Timestamp.fromDate(dateTime);
  }
}
