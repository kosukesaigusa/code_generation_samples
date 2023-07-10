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

/// A [CollectionReference] to appUsers collection to read.
final readAppUserCollectionReference =
    FirebaseFirestore.instance.collection('appUsers').withConverter(
          fromFirestore: (ds, _) => ReadAppUser.fromDocumentSnapshot(ds),
          toFirestore: (obj, _) => throw UnimplementedError(),
        );

/// A [DocumentReference] to appUser document to read.
DocumentReference<ReadAppUser> readAppUserDocumentReference({
  required String appUserId,
}) =>
    readAppUserCollectionReference.doc(appUserId);

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

  /// Fetches [ReadAppUser] document.
  Future<ReadAppUser?> fetchDocument({
    required String appUserId,
    GetOptions? options,
  }) async {
    final ds = await readAppUserDocumentReference(
      appUserId: appUserId,
    ).get(options);
    return ds.data();
  }

  /// Subscribes [AppUser] document.
  Future<Stream<ReadAppUser?>> subscribeDocument({
    required String appUserId,
    bool includeMetadataChanges = false,
    bool excludePendingWrites = false,
  }) async {
    var streamDs = readAppUserDocumentReference(
      appUserId: appUserId,
    ).snapshots(includeMetadataChanges: includeMetadataChanges);
    if (excludePendingWrites) {
      streamDs = streamDs.where((ds) => !ds.metadata.hasPendingWrites);
    }
    return streamDs.map((ds) => ds.data());
  }
}