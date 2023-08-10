import * as admin from 'firebase-admin'
import {
    DocumentReference,
    FieldValue,
    QueryDocumentSnapshot,
    QuerySnapshot,
    WriteResult
} from 'firebase-admin/firestore'

export class ReadAppUserPostLike {
  constructor ({
    appUserPostLikeId,
    path,
    likedByAppUserId,
stringWithDefaultValue,
nullableString,
nullableStringWithDefaultValue,
likedAt,
  }: {
    appUserPostLikeId: string
    path: string
    likedByAppUserId: string
stringWithDefaultValue: string
nullableString?: string
nullableStringWithDefaultValue?: string
likedAt?: Date
  }) {
    this.appUserPostLikeId = appUserPostLikeId
    this.path = path
    this.likedByAppUserId = likedByAppUserId
this.stringWithDefaultValue = stringWithDefaultValue
this.nullableString = nullableString
this.nullableStringWithDefaultValue = nullableStringWithDefaultValue
this.likedAt = likedAt
  }

  readonly appUserPostLikeId: string

  readonly path: string

  readonly likedByAppUserId: string

readonly stringWithDefaultValue: string

readonly nullableString?: string

readonly nullableStringWithDefaultValue?: string

readonly likedAt?: Date

  private static fromJson(json: Record<string, unknown>): ReadAppUserPostLike {
    return new ReadAppUserPostLike({
      appUserPostLikeId: json['appUserPostLikeId'] as string,
      path: json['path'] as string,
      likedByAppUserId: json['likedByAppUserId'] as string,
stringWithDefaultValue: (json['stringWithDefaultValue'] as string | undefined) ?? 'defaultText',
nullableString: json['nullableString'] as string | undefined,
nullableStringWithDefaultValue: (json['nullableStringWithDefaultValue'] as string | undefined) ?? 'defaultText',
likedAt: (json['likedAt'] as FirebaseFirestore.Timestamp | undefined)?.toDate(),
    })
  }


  static fromDocumentSnapshot(
    ds: FirebaseFirestore.DocumentSnapshot
  ): ReadAppUserPostLike {
      const data = ds.data()!
      const cleanedData: Record<string, unknown> = {}
      for (const [key, value] of Object.entries(data)) {
          cleanedData[key] = value === null ? undefined : value
      }
      return ReadAppUserPostLike.fromJson({
          ...cleanedData,
          appUserPostLikeId: ds.id,
          path: ds.ref.path
      })
  }

}

export class CreateAppUserPostLike {
  constructor({
    likedByAppUserId,
stringWithDefaultValue,
nullableString,
nullableStringWithDefaultValue,
likedAt,
  }: {
    likedByAppUserId: string
stringWithDefaultValue: string
nullableString?: string
nullableStringWithDefaultValue?: string
likedAt?: Date
  }) {
    this.likedByAppUserId = likedByAppUserId
this.stringWithDefaultValue = stringWithDefaultValue
this.nullableString = nullableString
this.nullableStringWithDefaultValue = nullableStringWithDefaultValue
this.likedAt = likedAt
  }

  readonly likedByAppUserId: string

readonly stringWithDefaultValue: string

readonly nullableString?: string

readonly nullableStringWithDefaultValue?: string

readonly likedAt?: Date

  toJson(): Record<string, unknown> {
  return {
    likedByAppUserId: this.likedByAppUserId,
stringWithDefaultValue: this.stringWithDefaultValue,
nullableString: this.nullableString,
nullableStringWithDefaultValue: this.nullableStringWithDefaultValue,
likedAt: this.likedAt,
  };
}

}

export class UpdateAppUserPostLike {
  constructor({
    likedByAppUserId,
stringWithDefaultValue,
nullableString,
nullableStringWithDefaultValue,
likedAt,
  }: {
    likedByAppUserId: string
stringWithDefaultValue: string
nullableString?: string
nullableStringWithDefaultValue?: string
likedAt?: Date
  }) {
    this.likedByAppUserId = likedByAppUserId
this.stringWithDefaultValue = stringWithDefaultValue
this.nullableString = nullableString
this.nullableStringWithDefaultValue = nullableStringWithDefaultValue
this.likedAt = likedAt
  }

  readonly likedByAppUserId: string

readonly stringWithDefaultValue: string

readonly nullableString?: string

readonly nullableStringWithDefaultValue?: string

readonly likedAt?: Date

  toJson(): Record<string, unknown> {
  const json: Record<string, unknown> = {}
  if (this.likedByAppUserId != null) {
  json['likedByAppUserId'] = this.likedByAppUserId
}
if (this.stringWithDefaultValue != null) {
  json['stringWithDefaultValue'] = this.stringWithDefaultValue
}
if (this.nullableString != null) {
  json['nullableString'] = this.nullableString
}
if (this.nullableStringWithDefaultValue != null) {
  json['nullableStringWithDefaultValue'] = this.nullableStringWithDefaultValue
}
if (this.likedAt != null) {
  json['likedAt'] = this.likedAt
}

  return json
}

}

export class DeleteAppUserPostLike {}

/**
 * A Cloud Firestore object which ignores `undefined` properties.
 */
const db = admin.firestore()
db.settings({ ignoreUndefinedProperties: true })

/**
 * Provides a reference to the appUserPostLikes collection for reading.
 */
CollectionReference<ReadAppUserPostLike> readAppUserPostLikeCollectionReference ({
  required String appUserId,
required String appUserPostId,
}) =>

db
.collection('appUsers').doc(appUserId).collection('appUserPosts').doc(appUserPostId).collection('appUserPostLikes').withConverter<ReadAppUserPostLike>({
  fromFirestore: (ds: FirebaseFirestore.DocumentSnapshot): ReadAppUserPostLike => {
    return ReadAppUserPostLike.fromDocumentSnapshot(ds)
  },
  toFirestore: () => {
      throw new Error(`toFirestore is not implemented for ReadAppUserPostLike`)
  }
})
;

/**
 * Provides a reference to a appUserPostLike document for reading.
 * @param appUserPostLikeId - The ID of the appUserPostLike document to read.
 */
export const readAppUserPostLikeDocumentReference = ({
  "appUserId,
appUserPostId,,"
  appUserPostLikeId,
}: {
  "appUserId: string
appUserPostId: string,"
  appUserPostLikeId: string
}): FirebaseFirestore.DocumentReference<ReadAppUserPostLike> =>
    readAppUserPostLikeCollectionReference(
      appUserId: appUserId,
appUserPostId: appUserPostId
    ).doc(appUserPostLikeId);


/**
 * Provides a reference to the appUserPostLikes collection for creating.
 */
CollectionReference<CreateAppUserPostLike> createAppUserPostLikeCollectionReference ({
  required String appUserId,
required String appUserPostId,
}) =>

db
.collection('appUsers').doc(appUserId).collection('appUserPosts').doc(appUserPostId).collection('appUserPostLikes').withConverter<CreateAppUserPostLike>({
  fromFirestore: () => {
    throw new Error(`fromFirestore is not implemented for CreateAppUserPostLike`)
  },
  toFirestore: (obj: CreateAppUserPostLike): FirebaseFirestore.DocumentData => {
      return obj.toJson()
  }
})
;

/**
 * Provides a reference to a appUserPostLike document for creating.
 * @param appUserPostLikeId - The ID of the appUserPostLike document to read.
 */
export const createAppUserPostLikeDocumentReference = ({
  "appUserId,
appUserPostId,,"
  appUserPostLikeId,
}: {
  "appUserId: string
appUserPostId: string,"
  appUserPostLikeId: string
}): FirebaseFirestore.DocumentReference<CreateAppUserPostLike> =>
    createAppUserPostLikeCollectionReference(
      appUserId: appUserId,
appUserPostId: appUserPostId
    ).doc(appUserPostLikeId);


/**
 * Provides a reference to the appUserPostLikes collection for updating.
 */
CollectionReference<UpdateAppUserPostLike> updateAppUserPostLikeCollectionReference ({
  required String appUserId,
required String appUserPostId,
}) =>

db
.collection('appUsers').doc(appUserId).collection('appUserPosts').doc(appUserPostId).collection('appUserPostLikes').withConverter<UpdateAppUserPostLike>({
  fromFirestore: () => {
    throw new Error(`fromFirestore is not implemented for UpdateAppUserPostLike`)
  },
  toFirestore: (obj: UpdateAppUserPostLike): FirebaseFirestore.DocumentData => {
      return obj.toJson()
  }
})
;

/**
 * Provides a reference to a appUserPostLike document for updating.
 * @param appUserPostLikeId - The ID of the appUserPostLike document to read.
 */
export const updateAppUserPostLikeDocumentReference = ({
  "appUserId,
appUserPostId,,"
  appUserPostLikeId,
}: {
  "appUserId: string
appUserPostId: string,"
  appUserPostLikeId: string
}): FirebaseFirestore.DocumentReference<UpdateAppUserPostLike> =>
    updateAppUserPostLikeCollectionReference(
      appUserId: appUserId,
appUserPostId: appUserPostId
    ).doc(appUserPostLikeId);


/**
 * Provides a reference to the appUserPostLikes collection for deleting.
 */
CollectionReference<DeleteAppUserPostLike> deleteAppUserPostLikeCollectionReference ({
  required String appUserId,
required String appUserPostId,
}) =>

db
.collection('appUsers').doc(appUserId).collection('appUserPosts').doc(appUserPostId).collection('appUserPostLikes').withConverter<DeleteAppUserPostLike>({
  fromFirestore: () => {
    throw new Error(`fromFirestore is not implemented for DeleteAppUserPostLike`)
  },
  toFirestore: (): FirebaseFirestore.DocumentData => {
    throw new Error(`toFirestore is not implemented for DeleteAppUserPostLike`)
  }
})
;

/**
 * Provides a reference to a appUserPostLike document for deleting.
 * @param appUserPostLikeId - The ID of the appUserPostLike document to read.
 */
export const deleteAppUserPostLikeDocumentReference = ({
  "appUserId,
appUserPostId,,"
  appUserPostLikeId,
}: {
  "appUserId: string
appUserPostId: string,"
  appUserPostLikeId: string
}): FirebaseFirestore.DocumentReference<DeleteAppUserPostLike> =>
    deleteAppUserPostLikeCollectionReference(
      appUserId: appUserId,
appUserPostId: appUserPostId
    ).doc(appUserPostLikeId);



/**
 * Manages queries against the appUserPostLikes collection.
 */
export class AppUserPostLikeQuery {
  /**
   * Fetches appUserPostLike documents.
   * @param queryBuilder - Function to modify the query.
   * @param compare - Function to sort the results.
   */
  async fetchDocuments({
      queryBuilder,
      compare
  }: {
      queryBuilder?: (
          query: FirebaseFirestore.Query<ReadAppUserPostLike>
      ) => FirebaseFirestore.Query<ReadAppUserPostLike>
      compare?: (lhs: ReadAppUserPostLike, rhs: ReadAppUserPostLike) => number
  } = {}): Promise<ReadAppUserPostLike[]> {
      let query: FirebaseFirestore.Query<ReadAppUserPostLike> =
          readAppUserPostLikeCollectionReference
      if (queryBuilder != undefined) {
          query = queryBuilder(query)
      }
      const qs: QuerySnapshot<ReadAppUserPostLike> = await query.get()
      let result = qs.docs.map((qds: QueryDocumentSnapshot<ReadAppUserPostLike>) =>
          qds.data()
      )
      if (compare != undefined) {
          result = result.sort(compare)
      }
      return result
  }

  /**
   * Fetches a specific appUserPostLike document.
   * @param appUserPostLikeId - The ID of the appUserPostLike document to fetch.
   */
  async fetchDocument(appUserPostLikeId: string): Promise<ReadAppUserPostLike | undefined> {
      const ds = await readAppUserPostLikeDocumentReference({ appUserPostLikeId }).get()
      return ds.data()
  }

  /**
   * Adds a appUserPostLike document.
   * @param createAppUserPostLike - The appUserPostLike details to add.
   */
  async add(createAppUserPostLike: CreateAppUserPostLike): Promise<DocumentReference<CreateAppUserPostLike>> {
      return createAppUserPostLikeCollectionReference.add(createAppUserPostLike)
  }

  /**
   * Sets a appUserPostLike document.
   * @param appUserPostLikeId - The ID of the appUserPostLike document to set.
   * @param createAppUserPostLike - The appUserPostLike details to set.
   * @param options - Options for the set operation.
   */
  async set({
      appUserPostLikeId,
      createAppUserPostLike,
      options
  }: {
      appUserPostLikeId: string
      createAppUserPostLike: CreateAppUserPostLike
      options?: FirebaseFirestore.SetOptions
  }): Promise<WriteResult> {
      if (options == undefined) {
          return createAppUserPostLikeDocumentReference({ appUserPostLikeId }).set(createAppUserPostLike)
      } else {
          return createAppUserPostLikeDocumentReference({ appUserPostLikeId }).set(
              createAppUserPostLike,
              options
          )
      }
  }

  /**
   * Updates a specific appUserPostLike document.
   * @param appUserPostLikeId - The ID of the appUserPostLike document to update.
   * @param updateAppUserPostLike - The details for updating the appUserPostLike.
   */
  async update(appUserPostLikeId: string, updateAppUserPostLike: UpdateAppUserPostLike): Promise<WriteResult> {
      return updateAppUserPostLikeDocumentReference({ appUserPostLikeId }).update(
          updateAppUserPostLike.toJson()
      )
  }

  /**
   * Deletes a specific appUserPostLike document.
   * @param appUserPostLikeId - The ID of the appUserPostLike document to delete.
   */
  async delete(appUserPostLikeId: string): Promise<WriteResult> {
      return deleteAppUserPostLikeDocumentReference({ appUserPostLikeId }).delete()
  }
}
