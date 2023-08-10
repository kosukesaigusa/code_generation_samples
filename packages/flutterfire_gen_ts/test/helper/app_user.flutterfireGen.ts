import * as admin from 'firebase-admin'
import {
    DocumentReference,
    FieldValue,
    QueryDocumentSnapshot,
    QuerySnapshot,
    WriteResult
} from 'firebase-admin/firestore'

export class ReadAppUser {
  constructor ({
    appUserId,
    path,
    name,
imageUrl,
  }: {
    appUserId: string
    path: string
    name: string
imageUrl: string
  }) {
    this.appUserId = appUserId
    this.path = path
    this.name = name
this.imageUrl = imageUrl
  }

  readonly appUserId: string

  readonly path: string

  readonly name: string

readonly imageUrl: string

  private static fromJson(json: Record<string, unknown>): ReadAppUser {
    return new ReadAppUser({
      appUserId: json['appUserId'] as string,
      path: json['path'] as string,
      name: json['name'] as string,
imageUrl: (json['imageUrl'] as string | undefined) ?? '',
    })
  }


  static fromDocumentSnapshot(
    ds: FirebaseFirestore.DocumentSnapshot
  ): ReadAppUser {
      const data = ds.data()!
      const cleanedData: Record<string, unknown> = {}
      for (const [key, value] of Object.entries(data)) {
          cleanedData[key] = value === null ? undefined : value
      }
      return ReadAppUser.fromJson({
          ...cleanedData,
          appUserId: ds.id,
          path: ds.ref.path
      })
  }

}

export class CreateAppUser {
  constructor({
    name,
imageUrl,
  }: {
    name: string
imageUrl: string
  }) {
    this.name = name
this.imageUrl = imageUrl
  }

  readonly name: string

readonly imageUrl: string

  toJson(): Record<string, unknown> {
  return {
    name: this.name,
imageUrl: this.imageUrl,
  };
}

}

export class UpdateAppUser {
  constructor({
    name,
imageUrl,
  }: {
    name: string
imageUrl: string
  }) {
    this.name = name
this.imageUrl = imageUrl
  }

  readonly name: string

readonly imageUrl: string

  toJson(): Record<string, unknown> {
  const json: Record<string, unknown> = {}
  if (this.name != null) {
  json['name'] = this.name
}
if (this.imageUrl != null) {
  json['imageUrl'] = this.imageUrl
}

  return json
}

}

export class DeleteAppUser {}

/**
 * A Cloud Firestore object which ignores `undefined` properties.
 */
const db = admin.firestore()
db.settings({ ignoreUndefinedProperties: true })

/**
 * Provides a reference to the appUsers collection for reading.
 */
export const readAppUserCollectionReference = 
db
.collection('appUsers').withConverter<ReadAppUser>({
  fromFirestore: (ds: FirebaseFirestore.DocumentSnapshot): ReadAppUser => {
    return ReadAppUser.fromDocumentSnapshot(ds)
  },
  toFirestore: () => {
      throw new Error(`toFirestore is not implemented for ReadAppUser`)
  }
})
;

/**
 * Provides a reference to a appUser document for reading.
 * @param appUserId - The ID of the appUser document to read.
 */
export const readAppUserDocumentReference = ({
  appUserId
}: {
  appUserId: string
}): FirebaseFirestore.DocumentReference<ReadAppUser> =>
    readAppUserCollectionReference.doc(appUserId);


/**
 * Provides a reference to the appUsers collection for creating.
 */
export const createAppUserCollectionReference = 
db
.collection('appUsers').withConverter<CreateAppUser>({
  fromFirestore: () => {
    throw new Error(`fromFirestore is not implemented for CreateAppUser`)
  },
  toFirestore: (obj: CreateAppUser): FirebaseFirestore.DocumentData => {
      return obj.toJson()
  }
})
;

/**
 * Provides a reference to a appUser document for creating.
 * @param appUserId - The ID of the appUser document to read.
 */
export const createAppUserDocumentReference = ({
  appUserId
}: {
  appUserId: string
}): FirebaseFirestore.DocumentReference<CreateAppUser> =>
    createAppUserCollectionReference.doc(appUserId);


/**
 * Provides a reference to the appUsers collection for updating.
 */
export const updateAppUserCollectionReference = 
db
.collection('appUsers').withConverter<UpdateAppUser>({
  fromFirestore: () => {
    throw new Error(`fromFirestore is not implemented for UpdateAppUser`)
  },
  toFirestore: (obj: UpdateAppUser): FirebaseFirestore.DocumentData => {
      return obj.toJson()
  }
})
;

/**
 * Provides a reference to a appUser document for updating.
 * @param appUserId - The ID of the appUser document to read.
 */
export const updateAppUserDocumentReference = ({
  appUserId
}: {
  appUserId: string
}): FirebaseFirestore.DocumentReference<UpdateAppUser> =>
    updateAppUserCollectionReference.doc(appUserId);


/**
 * Provides a reference to the appUsers collection for deleting.
 */
export const deleteAppUserCollectionReference = 
db
.collection('appUsers').withConverter<DeleteAppUser>({
  fromFirestore: () => {
    throw new Error(`fromFirestore is not implemented for DeleteAppUser`)
  },
  toFirestore: (): FirebaseFirestore.DocumentData => {
    throw new Error(`toFirestore is not implemented for DeleteAppUser`)
  }
})
;

/**
 * Provides a reference to a appUser document for deleting.
 * @param appUserId - The ID of the appUser document to read.
 */
export const deleteAppUserDocumentReference = ({
  appUserId
}: {
  appUserId: string
}): FirebaseFirestore.DocumentReference<DeleteAppUser> =>
    deleteAppUserCollectionReference.doc(appUserId);



/**
 * Manages queries against the appUsers collection.
 */
export class AppUserQuery {
  /**
   * Fetches appUser documents.
   * @param queryBuilder - Function to modify the query.
   * @param compare - Function to sort the results.
   */
  async fetchDocuments({
      queryBuilder,
      compare
  }: {
      queryBuilder?: (
          query: FirebaseFirestore.Query<ReadAppUser>
      ) => FirebaseFirestore.Query<ReadAppUser>
      compare?: (lhs: ReadAppUser, rhs: ReadAppUser) => number
  } = {}): Promise<ReadAppUser[]> {
      let query: FirebaseFirestore.Query<ReadAppUser> =
          readAppUserCollectionReference
      if (queryBuilder != undefined) {
          query = queryBuilder(query)
      }
      const qs: QuerySnapshot<ReadAppUser> = await query.get()
      let result = qs.docs.map((qds: QueryDocumentSnapshot<ReadAppUser>) =>
          qds.data()
      )
      if (compare != undefined) {
          result = result.sort(compare)
      }
      return result
  }

  /**
   * Fetches a specific appUser document.
   * @param appUserId - The ID of the appUser document to fetch.
   */
  async fetchDocument(appUserId: string): Promise<ReadAppUser | undefined> {
      const ds = await readAppUserDocumentReference({ appUserId }).get()
      return ds.data()
  }

  /**
   * Adds a appUser document.
   * @param createAppUser - The appUser details to add.
   */
  async add(createAppUser: CreateAppUser): Promise<DocumentReference<CreateAppUser>> {
      return createAppUserCollectionReference.add(createAppUser)
  }

  /**
   * Sets a appUser document.
   * @param appUserId - The ID of the appUser document to set.
   * @param createAppUser - The appUser details to set.
   * @param options - Options for the set operation.
   */
  async set({
      appUserId,
      createAppUser,
      options
  }: {
      appUserId: string
      createAppUser: CreateAppUser
      options?: FirebaseFirestore.SetOptions
  }): Promise<WriteResult> {
      if (options == undefined) {
          return createAppUserDocumentReference({ appUserId }).set(createAppUser)
      } else {
          return createAppUserDocumentReference({ appUserId }).set(
              createAppUser,
              options
          )
      }
  }

  /**
   * Updates a specific appUser document.
   * @param appUserId - The ID of the appUser document to update.
   * @param updateAppUser - The details for updating the appUser.
   */
  async update(appUserId: string, updateAppUser: UpdateAppUser): Promise<WriteResult> {
      return updateAppUserDocumentReference({ appUserId }).update(
          updateAppUser.toJson()
      )
  }

  /**
   * Deletes a specific appUser document.
   * @param appUserId - The ID of the appUser document to delete.
   */
  async delete(appUserId: string): Promise<WriteResult> {
      return deleteAppUserDocumentReference({ appUserId }).delete()
  }
}
