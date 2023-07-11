import 'package:cloud_firestore/cloud_firestore.dart';

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

/// An annotation to accept Cloud Firestore FieldValue input when creating or
/// updating document.
class AllowFieldValue {
  ///
  const AllowFieldValue();
}
