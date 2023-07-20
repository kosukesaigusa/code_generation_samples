// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_user_post.dart';

class ReadAppUserPost {
  const ReadAppUserPost({
    required this.appUserPostId,
    required this.path,
    required this.content,
    required this.numbers,
    required this.updatedAt,
  });

  final String appUserPostId;

  final String path;

  final String content;

  final List<int> numbers;

  final DateTime? updatedAt;

  factory ReadAppUserPost._fromJson(Map<String, dynamic> json) {
    return ReadAppUserPost(
      appUserPostId: json['appUserPostId'] as String,
      path: json['path'] as String,
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
      'path': ds.reference.path,
    });
  }
}

class CreateAppUserPost {
  const CreateAppUserPost({
    required this.content,
    required this.numbers,
    this.updatedAt,
  });

  final String content;
  final FirestoreData<List<int>> numbers;
  final DateTime? updatedAt;

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'numbers': numbers.value,
      'updatedAt': updatedAt,
    };
  }
}

class UpdateAppUserPost {
  const UpdateAppUserPost({
    this.content,
    this.numbers,
    this.updatedAt,
  });

  final String? content;
  final FirestoreData<List<int>>? numbers;
  final DateTime? updatedAt;

  Map<String, dynamic> toJson() {
    return {
      if (content != null) 'content': content,
      if (numbers != null) 'numbers': numbers!.value,
      if (updatedAt != null) 'updatedAt': updatedAt,
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
        .withConverter<ReadAppUserPost>(
          fromFirestore: (ds, _) => ReadAppUserPost.fromDocumentSnapshot(ds),
          toFirestore: (obj, _) => throw UnimplementedError(),
        );

/// A [DocumentReference] to appUserPost document to read.
DocumentReference<ReadAppUserPost> readAppUserPostDocumentReference({
  required String appUserId,
  required String appUserPostId,
}) =>
    readAppUserPostCollectionReference(appUserId: appUserId).doc(appUserPostId);

/// A [CollectionReference] to appUserPosts collection to create.
CollectionReference<CreateAppUserPost> createAppUserPostCollectionReference({
  required String appUserId,
}) =>
    FirebaseFirestore.instance
        .collection('appUsers')
        .doc(appUserId)
        .collection('appUserPosts')
        .withConverter<CreateAppUserPost>(
          fromFirestore: (ds, _) => throw UnimplementedError(),
          toFirestore: (obj, _) => obj.toJson(),
        );

/// A [DocumentReference] to appUserPost document to create.
DocumentReference<CreateAppUserPost> createAppUserPostDocumentReference({
  required String appUserId,
  required String appUserPostId,
}) =>
    createAppUserPostCollectionReference(appUserId: appUserId)
        .doc(appUserPostId);

/// A [CollectionReference] to appUserPosts collection to update.
CollectionReference<UpdateAppUserPost> updateAppUserPostCollectionReference({
  required String appUserId,
}) =>
    FirebaseFirestore.instance
        .collection('appUsers')
        .doc(appUserId)
        .collection('appUserPosts')
        .withConverter<UpdateAppUserPost>(
          fromFirestore: (ds, _) => throw UnimplementedError(),
          toFirestore: (obj, _) => obj.toJson(),
        );

/// A [DocumentReference] to appUserPost document to update.
DocumentReference<UpdateAppUserPost> updateAppUserPostDocumentReference({
  required String appUserId,
  required String appUserPostId,
}) =>
    updateAppUserPostCollectionReference(appUserId: appUserId)
        .doc(appUserPostId);

/// A [CollectionReference] to appUserPosts collection to delete.
CollectionReference<Object?> deleteAppUserPostCollectionReference({
  required String appUserId,
}) =>
    FirebaseFirestore.instance
        .collection('appUsers')
        .doc(appUserId)
        .collection('appUserPosts');

/// A [DocumentReference] to appUserPost document to delete.
DocumentReference<Object?> deleteAppUserPostDocumentReference({
  required String appUserId,
  required String appUserPostId,
}) =>
    deleteAppUserPostCollectionReference(appUserId: appUserId)
        .doc(appUserPostId);

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

  /// Fetches a specified [ReadAppUserPost] document.
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

  /// Subscribes a specified [AppUserPost] document.
  Stream<ReadAppUserPost?> subscribeDocument({
    required String appUserId,
    required String appUserPostId,
    bool includeMetadataChanges = false,
    bool excludePendingWrites = false,
  }) {
    var streamDs = readAppUserPostDocumentReference(
      appUserId: appUserId,
      appUserPostId: appUserPostId,
    ).snapshots(includeMetadataChanges: includeMetadataChanges);
    if (excludePendingWrites) {
      streamDs = streamDs.where((ds) => !ds.metadata.hasPendingWrites);
    }
    return streamDs.map((ds) => ds.data());
  }

  /// Adds a [AppUserPost] document.
  Future<DocumentReference<CreateAppUserPost>> add({
    required String appUserId,
    required CreateAppUserPost createAppUserPost,
  }) =>
      createAppUserPostCollectionReference(appUserId: appUserId)
          .add(createAppUserPost);

  /// Sets a [AppUserPost] document.
  Future<void> set({
    required String appUserId,
    required String appUserPostId,
    required CreateAppUserPost createAppUserPost,
    SetOptions? options,
  }) =>
      createAppUserPostDocumentReference(
        appUserId: appUserId,
        appUserPostId: appUserPostId,
      ).set(createAppUserPost, options);

  /// Updates a specified [AppUserPost] document.
  Future<void> update({
    required String appUserId,
    required String appUserPostId,
    required UpdateAppUserPost updateAppUserPost,
  }) =>
      updateAppUserPostDocumentReference(
        appUserId: appUserId,
        appUserPostId: appUserPostId,
      ).update(updateAppUserPost.toJson());

  /// Deletes a specified [AppUserPost] document.
  Future<void> delete({
    required String appUserId,
    required String appUserPostId,
  }) =>
      deleteAppUserPostDocumentReference(
        appUserId: appUserId,
        appUserPostId: appUserPostId,
      ).delete();
}
