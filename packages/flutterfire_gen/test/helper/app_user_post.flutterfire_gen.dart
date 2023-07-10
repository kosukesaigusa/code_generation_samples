// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_user_post.dart';

class ReadAppUserPost {
  const ReadAppUserPost._({
    required this.appUserPostId,
    required this.appUserPostReference,
    required this.content,
    required this.numbers,
    required this.updatedAt,
  });

  final String appUserPostId;
  final DocumentReference<ReadAppUserPost> appUserPostReference;
  final String content;
  final List<int> numbers;
  final DateTime? updatedAt;

  factory ReadAppUserPost._fromJson(Map<String, dynamic> json) {
    return ReadAppUserPost._(
      appUserPostId: json['appUserPostId'] as String,
      appUserPostReference:
          json['appUserPostReference'] as DocumentReference<ReadAppUserPost>,
      content: json['content'] as String? ?? '',
      numbers:
          (json['numbers'] as List<dynamic>?)?.map((e) => e as int).toList() ??
              const <int>[],
      updatedAt: (json['updatedAt'] as Timestamp?)?.toDate(),
    );
  }

  factory ReadAppUserPost.fromDocumentSnapshot(DocumentSnapshot ds) {
    final data = ds.data()! as Map<String, dynamic>;
    return ReadAppUserPost._fromJson(<String, dynamic>{
      ...data,
      'appUserPostId': ds.id,
      'appUserPostReference': ds.reference.parent.doc(ds.id).withConverter(
            fromFirestore: (ds, _) => ReadAppUserPost.fromDocumentSnapshot(ds),
            toFirestore: (obj, _) => throw UnimplementedError(),
          ),
    });
  }

  ReadAppUserPost copyWith({
    String? appUserPostId,
    DocumentReference<ReadAppUserPost>? appUserPostReference,
    String? content,
    List<int>? numbers,
    DateTime? updatedAt,
  }) {
    return ReadAppUserPost._(
      appUserPostId: appUserPostId ?? this.appUserPostId,
      appUserPostReference: appUserPostReference ?? this.appUserPostReference,
      content: content ?? this.content,
      numbers: numbers ?? this.numbers,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class CreateAppUserPost {
  const CreateAppUserPost({
    this.content = '',
    this.numbers = const <int>[],
    this.updatedAt,
  });

  final String content;
  final List<int> numbers;
  final DateTime? updatedAt;

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'numbers': numbers,
      'updatedAt': updatedAt,
    };
  }
}

/// A [CollectionReference] to appUserPosts collection to read.
CollectionReference<ReadAppUserPost> readAppUserPostCollectionReference({
  required String appUserId,
}) =>
    FirebaseFirestore.instance
        .collection('appUsers')
        .doc(appUserId)
        .collection('appUserPosts')
        .withConverter(
          fromFirestore: (ds, _) => ReadAppUserPost.fromDocumentSnapshot(ds),
          toFirestore: (obj, _) => throw UnimplementedError(),
        );

/// A [DocumentReference] to appUserPost document to read.
DocumentReference<ReadAppUserPost> readAppUserPostDocumentReference({
  required String appUserId,
  required String appUserPostId,
}) =>
    readAppUserPostCollectionReference(appUserId: appUserId).doc(appUserPostId);

/// A query manager to execute query against [AppUserPost].
class AppUserPostQuery {
  /// Fetches [ReadAppUserPost] documents.
  Future<List<ReadAppUserPost>> fetchDocuments({
    required String appUserId,
    GetOptions? options,
    Query<ReadAppUserPost>? Function(Query<ReadAppUserPost> query)?
        queryBuilder,
    int Function(ReadAppUserPost lhs, ReadAppUserPost rhs)? compare,
  }) async {
    Query<ReadAppUserPost> query =
        readAppUserPostCollectionReference(appUserId: appUserId);
    if (queryBuilder != null) {
      query = queryBuilder(query)!;
    }
    final qs = await query.get(options);
    final result = qs.docs.map((qds) => qds.data()).toList();
    if (compare != null) {
      result.sort(compare);
    }
    return result;
  }

  /// Subscribes [AppUserPost] documents.
  Stream<List<ReadAppUserPost>> subscribeDocuments({
    required String appUserId,
    Query<ReadAppUserPost>? Function(Query<ReadAppUserPost> query)?
        queryBuilder,
    int Function(ReadAppUserPost lhs, ReadAppUserPost rhs)? compare,
    bool includeMetadataChanges = false,
    bool excludePendingWrites = false,
  }) {
    Query<ReadAppUserPost> query =
        readAppUserPostCollectionReference(appUserId: appUserId);
    if (queryBuilder != null) {
      query = queryBuilder(query)!;
    }
    var streamQs =
        query.snapshots(includeMetadataChanges: includeMetadataChanges);
    if (excludePendingWrites) {
      streamQs = streamQs.where((qs) => !qs.metadata.hasPendingWrites);
    }
    return streamQs.map((qs) {
      final result = qs.docs.map((qds) => qds.data()).toList();
      if (compare != null) {
        result.sort(compare);
      }
      return result;
    });
  }

  /// Fetches [ReadAppUserPost] document.
  Future<ReadAppUserPost?> fetchDocument({
    required String appUserId,
    required String appUserPostId,
    GetOptions? options,
  }) async {
    final ds = await readAppUserPostDocumentReference(
      appUserId: appUserId,
      appUserPostId: appUserPostId,
    ).get(options);
    return ds.data();
  }

  /// Subscribes [AppUserPost] document.
  Future<Stream<ReadAppUserPost?>> subscribeDocument({
    required String appUserId,
    required String appUserPostId,
    bool includeMetadataChanges = false,
    bool excludePendingWrites = false,
  }) async {
    var streamDs = readAppUserPostDocumentReference(
      appUserId: appUserId,
      appUserPostId: appUserPostId,
    ).snapshots(includeMetadataChanges: includeMetadataChanges);
    if (excludePendingWrites) {
      streamDs = streamDs.where((ds) => !ds.metadata.hasPendingWrites);
    }
    return streamDs.map((ds) => ds.data());
  }
}
