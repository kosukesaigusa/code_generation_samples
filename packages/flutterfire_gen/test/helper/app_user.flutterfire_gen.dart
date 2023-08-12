// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_user.dart';

class ReadAppUser {
  const ReadAppUser({
    required this.appUserId,
    required this.path,
    required this.name,
    required this.imageUrl,
  });

  final String appUserId;

  final String path;

  final String name;

  final String imageUrl;

  factory ReadAppUser._fromJson(Map<String, dynamic> json) {
    return ReadAppUser(
      appUserId: json['appUserId'] as String,
      path: json['path'] as String,
      name: json['name'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
    );
  }

  factory ReadAppUser.fromDocumentSnapshot(DocumentSnapshot ds) {
    final data = ds.data()! as Map<String, dynamic>;
    return ReadAppUser._fromJson(<String, dynamic>{
      ...data,
      'appUserId': ds.id,
      'path': ds.reference.path,
    });
  }
}

class CreateAppUser {
  const CreateAppUser({
    required this.name,
    required this.imageUrl,
  });

  final String name;
  final String imageUrl;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imageUrl': imageUrl,
    };
  }
}

class UpdateAppUser {
  const UpdateAppUser({
    this.name,
    this.imageUrl,
  });

  final String? name;
  final String? imageUrl;

  Map<String, dynamic> toJson() {
    return {
      if (name != null) 'name': name,
      if (imageUrl != null) 'imageUrl': imageUrl,
    };
  }
}

class DeleteAppUser {}

/// Provides a reference to the appUsers collection for reading.
final readAppUserCollectionReference = FirebaseFirestore.instance
    .collection('appUsers')
    .withConverter<ReadAppUser>(
      fromFirestore: (ds, _) => ReadAppUser.fromDocumentSnapshot(ds),
      toFirestore: (_, __) => throw UnimplementedError(),
    );

/// Provides a reference to a appUser document for reading.
DocumentReference<ReadAppUser> readAppUserDocumentReference({
  required String appUserId,
}) =>
    readAppUserCollectionReference.doc(appUserId);

/// Provides a reference to the appUsers collection for creating.
final createAppUserCollectionReference = FirebaseFirestore.instance
    .collection('appUsers')
    .withConverter<CreateAppUser>(
      fromFirestore: (_, __) => throw UnimplementedError(),
      toFirestore: (obj, _) => obj.toJson(),
    );

/// Provides a reference to a appUser document for creating.
DocumentReference<CreateAppUser> createAppUserDocumentReference({
  required String appUserId,
}) =>
    createAppUserCollectionReference.doc(appUserId);

/// Provides a reference to the appUsers collection for updating.
final updateAppUserCollectionReference = FirebaseFirestore.instance
    .collection('appUsers')
    .withConverter<UpdateAppUser>(
      fromFirestore: (_, __) => throw UnimplementedError(),
      toFirestore: (obj, _) => obj.toJson(),
    );

/// Provides a reference to a appUser document for updating.
DocumentReference<UpdateAppUser> updateAppUserDocumentReference({
  required String appUserId,
}) =>
    updateAppUserCollectionReference.doc(appUserId);

/// Provides a reference to the appUsers collection for deleting.
final deleteAppUserCollectionReference = FirebaseFirestore.instance
    .collection('appUsers')
    .withConverter<DeleteAppUser>(
      fromFirestore: (_, __) => throw UnimplementedError(),
      toFirestore: (_, __) => throw UnimplementedError(),
    );

/// Provides a reference to a appUser document for deleting.
DocumentReference<DeleteAppUser> deleteAppUserDocumentReference({
  required String appUserId,
}) =>
    deleteAppUserCollectionReference.doc(appUserId);

/// Manages queries against the appUsers collection.
class AppUserQuery {
  /// Fetches [ReadAppUser] documents.
  Future<List<ReadAppUser>> fetchDocuments({
    GetOptions? options,
    Query<ReadAppUser>? Function(Query<ReadAppUser> query)? queryBuilder,
    int Function(ReadAppUser lhs, ReadAppUser rhs)? compare,
  }) async {
    Query<ReadAppUser> query = readAppUserCollectionReference;
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

  /// Subscribes [AppUser] documents.
  Stream<List<ReadAppUser>> subscribeDocuments({
    Query<ReadAppUser>? Function(Query<ReadAppUser> query)? queryBuilder,
    int Function(ReadAppUser lhs, ReadAppUser rhs)? compare,
    bool includeMetadataChanges = false,
    bool excludePendingWrites = false,
  }) {
    Query<ReadAppUser> query = readAppUserCollectionReference;
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

  /// Fetches a specific [ReadAppUser] document.
  Future<ReadAppUser?> fetchDocument({
    required String appUserId,
    GetOptions? options,
  }) async {
    final ds = await readAppUserDocumentReference(
      appUserId: appUserId,
    ).get(options);
    return ds.data();
  }

  /// Subscribes a specific [AppUser] document.
  Stream<ReadAppUser?> subscribeDocument({
    required String appUserId,
    bool includeMetadataChanges = false,
    bool excludePendingWrites = false,
  }) {
    var streamDs = readAppUserDocumentReference(
      appUserId: appUserId,
    ).snapshots(includeMetadataChanges: includeMetadataChanges);
    if (excludePendingWrites) {
      streamDs = streamDs.where((ds) => !ds.metadata.hasPendingWrites);
    }
    return streamDs.map((ds) => ds.data());
  }

  /// Adds a [AppUser] document.
  Future<DocumentReference<CreateAppUser>> add({
    required CreateAppUser createAppUser,
  }) =>
      createAppUserCollectionReference.add(createAppUser);

  /// Sets a [AppUser] document.
  Future<void> set({
    required String appUserId,
    required CreateAppUser createAppUser,
    SetOptions? options,
  }) =>
      createAppUserDocumentReference(
        appUserId: appUserId,
      ).set(createAppUser, options);

  /// Updates a specific [AppUser] document.
  Future<void> update({
    required String appUserId,
    required UpdateAppUser updateAppUser,
  }) =>
      updateAppUserDocumentReference(
        appUserId: appUserId,
      ).update(updateAppUser.toJson());

  /// Deletes a specific [AppUser] document.
  Future<void> delete({
    required String appUserId,
  }) =>
      deleteAppUserDocumentReference(
        appUserId: appUserId,
      ).delete();
}
