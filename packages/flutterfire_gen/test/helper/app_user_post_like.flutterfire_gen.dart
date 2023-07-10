// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_user_post_like.dart';

class ReadAppUserPostLike {
  const ReadAppUserPostLike._({
    required this.appUserPostLikeId,
    required this.appUserPostLikeReference,
    required this.likedByAppUserId,
    required this.likedAt,
  });

  final String appUserPostLikeId;
  final DocumentReference<ReadAppUserPostLike> appUserPostLikeReference;
  final String likedByAppUserId;
  final DateTime? likedAt;

  factory ReadAppUserPostLike._fromJson(Map<String, dynamic> json) {
    return ReadAppUserPostLike._(
      appUserPostLikeId: json['appUserPostLikeId'] as String,
      appUserPostLikeReference: json['appUserPostLikeReference']
          as DocumentReference<ReadAppUserPostLike>,
      likedByAppUserId: json['likedByAppUserId'] as String,
      likedAt: (json['likedAt'] as Timestamp?)?.toDate(),
    );
  }

  factory ReadAppUserPostLike.fromDocumentSnapshot(DocumentSnapshot ds) {
    final data = ds.data()! as Map<String, dynamic>;
    return ReadAppUserPostLike._fromJson(<String, dynamic>{
      ...data,
      'appUserPostLikeId': ds.id,
      'appUserPostLikeReference': ds.reference.parent.doc(ds.id).withConverter(
            fromFirestore: (ds, _) =>
                ReadAppUserPostLike.fromDocumentSnapshot(ds),
            toFirestore: (obj, _) => throw UnimplementedError(),
          ),
    });
  }

  ReadAppUserPostLike copyWith({
    String? appUserPostLikeId,
    DocumentReference<ReadAppUserPostLike>? appUserPostLikeReference,
    String? likedByAppUserId,
    DateTime? likedAt,
  }) {
    return ReadAppUserPostLike._(
      appUserPostLikeId: appUserPostLikeId ?? this.appUserPostLikeId,
      appUserPostLikeReference:
          appUserPostLikeReference ?? this.appUserPostLikeReference,
      likedByAppUserId: likedByAppUserId ?? this.likedByAppUserId,
      likedAt: likedAt ?? this.likedAt,
    );
  }
}

class CreateAppUserPostLike {
  const CreateAppUserPostLike({
    required this.likedByAppUserId,
    this.likedAt,
  });

  final String likedByAppUserId;
  final DateTime? likedAt;

  Map<String, dynamic> toJson() {
    return {
      'likedByAppUserId': likedByAppUserId,
      'likedAt': likedAt,
    };
  }
}

/// A [CollectionReference] to appUserPostLikes collection to read.
CollectionReference<ReadAppUserPostLike>
    readAppUserPostLikeCollectionReference({
  required String appUserId,
  required String appUserPostId,
}) =>
        FirebaseFirestore.instance
            .collection('appUsers')
            .doc(appUserId)
            .collection('appUserPosts')
            .doc(appUserPostId)
            .collection('appUserPostLikes')
            .withConverter<ReadAppUserPostLike>(
              fromFirestore: (ds, _) =>
                  ReadAppUserPostLike.fromDocumentSnapshot(ds),
              toFirestore: (obj, _) => throw UnimplementedError(),
            );

/// A [DocumentReference] to appUserPostLike document to read.
DocumentReference<ReadAppUserPostLike> readAppUserPostLikeDocumentReference({
  required String appUserId,
  required String appUserPostId,
  required String appUserPostLikeId,
}) =>
    readAppUserPostLikeCollectionReference(
            appUserId: appUserId, appUserPostId: appUserPostId)
        .doc(appUserPostLikeId);

/// A [CollectionReference] to appUserPostLikes collection to create.
CollectionReference<CreateAppUserPostLike>
    createAppUserPostLikeCollectionReference({
  required String appUserId,
  required String appUserPostId,
}) =>
        FirebaseFirestore.instance
            .collection('appUsers')
            .doc(appUserId)
            .collection('appUserPosts')
            .doc(appUserPostId)
            .collection('appUserPostLikes')
            .withConverter<CreateAppUserPostLike>(
              fromFirestore: (ds, _) => throw UnimplementedError(),
              toFirestore: (obj, _) => obj.toJson(),
            );

/// A [DocumentReference] to appUserPostLike document to create.
DocumentReference<CreateAppUserPostLike>
    createAppUserPostLikeDocumentReference({
  required String appUserId,
  required String appUserPostId,
  required String appUserPostLikeId,
}) =>
        createAppUserPostLikeCollectionReference(
                appUserId: appUserId, appUserPostId: appUserPostId)
            .doc(appUserPostLikeId);

/// A query manager to execute query against [AppUserPostLike].
class AppUserPostLikeQuery {
  /// Fetches [ReadAppUserPostLike] documents.
  Future<List<ReadAppUserPostLike>> fetchDocuments({
    required String appUserId,
    required String appUserPostId,
    GetOptions? options,
    Query<ReadAppUserPostLike>? Function(Query<ReadAppUserPostLike> query)?
        queryBuilder,
    int Function(ReadAppUserPostLike lhs, ReadAppUserPostLike rhs)? compare,
  }) async {
    Query<ReadAppUserPostLike> query = readAppUserPostLikeCollectionReference(
        appUserId: appUserId, appUserPostId: appUserPostId);
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

  /// Subscribes [AppUserPostLike] documents.
  Stream<List<ReadAppUserPostLike>> subscribeDocuments({
    required String appUserId,
    required String appUserPostId,
    Query<ReadAppUserPostLike>? Function(Query<ReadAppUserPostLike> query)?
        queryBuilder,
    int Function(ReadAppUserPostLike lhs, ReadAppUserPostLike rhs)? compare,
    bool includeMetadataChanges = false,
    bool excludePendingWrites = false,
  }) {
    Query<ReadAppUserPostLike> query = readAppUserPostLikeCollectionReference(
        appUserId: appUserId, appUserPostId: appUserPostId);
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

  /// Fetches [ReadAppUserPostLike] document.
  Future<ReadAppUserPostLike?> fetchDocument({
    required String appUserId,
    required String appUserPostId,
    required String appUserPostLikeId,
    GetOptions? options,
  }) async {
    final ds = await readAppUserPostLikeDocumentReference(
      appUserId: appUserId,
      appUserPostId: appUserPostId,
      appUserPostLikeId: appUserPostLikeId,
    ).get(options);
    return ds.data();
  }

  /// Subscribes [AppUserPostLike] document.
  Future<Stream<ReadAppUserPostLike?>> subscribeDocument({
    required String appUserId,
    required String appUserPostId,
    required String appUserPostLikeId,
    bool includeMetadataChanges = false,
    bool excludePendingWrites = false,
  }) async {
    var streamDs = readAppUserPostLikeDocumentReference(
      appUserId: appUserId,
      appUserPostId: appUserPostId,
      appUserPostLikeId: appUserPostLikeId,
    ).snapshots(includeMetadataChanges: includeMetadataChanges);
    if (excludePendingWrites) {
      streamDs = streamDs.where((ds) => !ds.metadata.hasPendingWrites);
    }
    return streamDs.map((ds) => ds.data());
  }
}
