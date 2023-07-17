// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_user.dart';

class ReadAppUser {
  const ReadAppUser._({
    required this.appUserId,
    required this.appUserReference,
    required this.name,
    required this.imageUrl,
  });

  final String appUserId;
  final DocumentReference<ReadAppUser> appUserReference;
  final String name;
  final String imageUrl;

  factory ReadAppUser._fromJson(Map<String, dynamic> json) {
    return ReadAppUser._(
      appUserId: json['appUserId'] as String,
      appUserReference:
          json['appUserReference'] as DocumentReference<ReadAppUser>,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String? ?? '',
    );
  }

  factory ReadAppUser.fromDocumentSnapshot(DocumentSnapshot ds) {
    final data = ds.data()! as Map<String, dynamic>;
    return ReadAppUser._fromJson(<String, dynamic>{
      ...data,
      'appUserId': ds.id,
      'appUserReference': ds.reference.parent.doc(ds.id).withConverter(
            fromFirestore: (ds, _) => ReadAppUser.fromDocumentSnapshot(ds),
            toFirestore: (obj, _) => throw UnimplementedError(),
          ),
    });
  }

  ReadAppUser copyWith({
    String? appUserId,
    DocumentReference<ReadAppUser>? appUserReference,
    String? name,
    String? imageUrl,
  }) {
    return ReadAppUser._(
      appUserId: appUserId ?? this.appUserId,
      appUserReference: appUserReference ?? this.appUserReference,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}

class CreateAppUser {
  const CreateAppUser({
    required this.name,
    this.imageUrl = '',
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

/// A [CollectionReference] to appUsers collection to read.
final readAppUserCollectionReference = FirebaseFirestore.instance
    .collection('appUsers')
    .withConverter<ReadAppUser>(
      fromFirestore: (ds, _) => ReadAppUser.fromDocumentSnapshot(ds),
      toFirestore: (obj, _) => throw UnimplementedError(),
    );

/// A [DocumentReference] to appUser document to read.
DocumentReference<ReadAppUser> readAppUserDocumentReference({
  required String appUserId,
}) =>
    readAppUserCollectionReference.doc(appUserId);

/// A [CollectionReference] to appUsers collection to create.
final createAppUserCollectionReference = FirebaseFirestore.instance
    .collection('appUsers')
    .withConverter<CreateAppUser>(
      fromFirestore: (ds, _) => throw UnimplementedError(),
      toFirestore: (obj, _) => obj.toJson(),
    );

/// A [DocumentReference] to appUser document to create.
DocumentReference<CreateAppUser> createAppUserDocumentReference({
  required String appUserId,
}) =>
    createAppUserCollectionReference.doc(appUserId);

/// A [CollectionReference] to appUsers collection to update.
final updateAppUserCollectionReference = FirebaseFirestore.instance
    .collection('appUsers')
    .withConverter<UpdateAppUser>(
      fromFirestore: (ds, _) => throw UnimplementedError(),
      toFirestore: (obj, _) => obj.toJson(),
    );

/// A [DocumentReference] to appUser document to update.
DocumentReference<UpdateAppUser> updateAppUserDocumentReference({
  required String appUserId,
}) =>
    updateAppUserCollectionReference.doc(appUserId);

/// A [CollectionReference] to appUsers collection to delete.
final deleteAppUserCollectionReference =
    FirebaseFirestore.instance.collection('appUsers');

/// A [DocumentReference] to appUser document to delete.
DocumentReference<Object?> deleteAppUserDocumentReference({
  required String appUserId,
}) =>
    deleteAppUserCollectionReference.doc(appUserId);

/// A query manager to execute query against [AppUser].
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

  /// Fetches a specified [ReadAppUser] document.
  Future<ReadAppUser?> fetchDocument({
    required String appUserId,
    GetOptions? options,
  }) async {
    final ds = await readAppUserDocumentReference(
      appUserId: appUserId,
    ).get(options);
    return ds.data();
  }

  /// Subscribes a specified [AppUser] document.
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

  /// Updates a specified [AppUser] document.
  Future<void> update({
    required String appUserId,
    required UpdateAppUser updateAppUser,
  }) =>
      updateAppUserDocumentReference(
        appUserId: appUserId,
      ).update(updateAppUser.toJson());

  /// Deletes a specified [AppUser] document.
  Future<void> delete({
    required String appUserId,
  }) =>
      deleteAppUserDocumentReference(
        appUserId: appUserId,
      ).delete();
}
