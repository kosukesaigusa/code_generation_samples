import 'package:cloud_firestore/cloud_firestore.dart';

/// A class that represents an actual value or `FieldValue` that can be stored
/// in Firestore.
sealed class FirestoreData<T> {
  /// Creates a [FirestoreData].
  const FirestoreData();

  /// Creates a [FirestoreData] from a [FieldValue].
  FieldValue get fieldValue {
    return switch (this) {
      FieldValueData(fieldValue: final fieldValue) => fieldValue,
      ActualValue<T>(actualValue: final _) => throw UnimplementedError(),
    };
  }

  /// Creates a [FirestoreData] from an actual value.
  T get actualValue {
    return switch (this) {
      FieldValueData(fieldValue: final _) => throw UnimplementedError(),
      ActualValue<T>(actualValue: final actualValue) => actualValue,
    };
  }

  /// Creates a [FirestoreData] from a [FieldValue] or an actual value.
  dynamic get value {
    return switch (this) {
      FieldValueData(fieldValue: final fieldValue) => fieldValue,
      ActualValue<T>(actualValue: final actualValue) => actualValue,
    };
  }
}

/// A class that represents a `FieldValue` that can be stored in Firestore.
final class FieldValueData<T> extends FirestoreData<T> {
  /// Creates a [FieldValueData].
  const FieldValueData(this.fieldValue);

  @override
  final FieldValue fieldValue;
}

/// A class that represents an actual value that can be stored in Firestore.
final class ActualValue<T> extends FirestoreData<T> {
  /// Creates an [ActualValue].
  const ActualValue(this.actualValue);

  @override
  final T actualValue;
}
