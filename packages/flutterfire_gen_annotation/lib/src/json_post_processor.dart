// ignore_for_file: lines_longer_than_80_chars

/// An abstract class for post-processing JSON serialization and
/// deserialization.
///
/// This class defines two methods, [fromJson] and [toJson], which are intended
/// to be overridden in subclasses to perform custom logic after the usual JSON
/// conversion process. The [toJson] method returns a Record containing the key
/// and value that will be used to modify the final serialized JSON.
///
/// ## Example
///
/// ```dart
/// class _UserIdRefPostProcessor
///     implements JsonPostProcessor<String, DocumentReference> {
///   const _UserIdRefPostProcessor();
///
///   @override
///   String fromJson(Map<String, dynamic> json) {
///     final appUserId = json['appUserId'] as String?;
///     if (appUserId != null) {
///       return appUserId;
///     }
///     final appUserRef = json['appUserRef'] as DocumentReference;
///     return appUserRef.id;
///   }
///
///   @override
///   ({String key, DocumentReference value}) toJson(Map<String, dynamic> json) {
///     final userId = json['userId'] as String;
///     return {
///       key: 'userRef',
///       value: FirebaseFirestore.instance.collection('users').doc(userId)
///     };
///   }
/// }
/// ```
abstract class JsonPostProcessor<D, F> {
  /// Creates a JsonPostProcessor.
  const JsonPostProcessor();

  /// Post-processes the deserialization of JSON data.
  ///
  /// This method should be overridden to include any additional logic that
  /// needs to be performed after deserializing a JSON object into a Dart object
  ///  of type [D].
  ///
  /// [json] is the Map representation of the JSON data.
  ///
  /// Returns the processed Dart object of type [D].
  D fromJson(Map<String, dynamic> json);

  /// Post-processes the serialization of JSON data.
  ///
  /// This method should be overridden to include any additional logic that
  /// needs to be performed after serializing a Dart object into a JSON object.
  ///
  /// [json] is the Map representation of the Dart object.
  ///
  /// Returns a Record containing the key and value that will be used to update
  /// the final serialized JSON object. The type of value is [F].
  ({String key, F value}) toJson(Map<String, dynamic> json);
}
