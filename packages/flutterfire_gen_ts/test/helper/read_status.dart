import 'package:flutterfire_gen_annotation/flutterfire_gen_annotation.dart';

@FirestoreDocument(
  path: 'chatRooms/{chatRoomId}/readStatuses',
  documentName: 'readStatus',
)
class ReadStatus {
  const ReadStatus({
    this.lastReadAt,
  });

  @AlwaysUseFieldValueServerTimestampWhenCreating()
  @AlwaysUseFieldValueServerTimestampWhenUpdating()
  final DateTime? lastReadAt;
}
