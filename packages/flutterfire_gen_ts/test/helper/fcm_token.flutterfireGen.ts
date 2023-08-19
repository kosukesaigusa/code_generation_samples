import * as admin from 'firebase-admin'
import {
    DocumentReference,
    FieldValue,
    GeoPoint,
    QueryDocumentSnapshot,
    QuerySnapshot,
    WriteResult
} from 'firebase-admin/firestore'

export class ReadFcmToken {
  constructor ({
    fcmTokenId,
    path,
    tokenAndDevices,
createdAt,
  }: {
    fcmTokenId: string
    path: string
    tokenAndDevices: TokenAndDevice[]
createdAt?: Date
  }) {
    this.fcmTokenId = fcmTokenId
    this.path = path
    this.tokenAndDevices = tokenAndDevices
this.createdAt = createdAt
  }

  readonly fcmTokenId: string

  readonly path: string

  readonly tokenAndDevices: TokenAndDevice[]

readonly createdAt?: Date

  private static fromJson(json: Record<string, unknown>): ReadFcmToken {
    return new ReadFcmToken({
      fcmTokenId: json['fcmTokenId'] as string,
      path: json['path'] as string,
      tokenAndDevices: (json['tokenAndDevices'] as unknown[]).map((e) => e as TokenAndDevice),
createdAt: (json['createdAt'] as FirebaseFirestore.Timestamp | undefined)?.toDate(),
    })
  }


  static fromDocumentSnapshot(
    ds: FirebaseFirestore.DocumentSnapshot
  ): ReadFcmToken {
      const data = ds.data()!
      const cleanedData: Record<string, unknown> = {}
      for (const [key, value] of Object.entries(data)) {
          cleanedData[key] = value === null ? undefined : value
      }
      return ReadFcmToken.fromJson({
          ...cleanedData,
          fcmTokenId: ds.id,
          path: ds.ref.path
      })
  }

}

export class CreateFcmToken {
  constructor({
    tokenAndDevices,
  }: {
    tokenAndDevices: TokenAndDevice[] | FieldValue
  }) {
    this.tokenAndDevices = tokenAndDevices
  }


  readonly tokenAndDevices: TokenAndDevice[] | FieldValue

  toJson(): Record<string, unknown> {
  return {
    tokenAndDevices: this.tokenAndDevices,
'createdAt': FieldValue.serverTimestamp(),
  };
}

}

export class UpdateFcmToken {
  constructor({
    tokenAndDevices,
createdAt,
  }: {
    tokenAndDevices?: TokenAndDevice[] | FieldValue
createdAt?: Date
  }) {
    this.tokenAndDevices = tokenAndDevices
this.createdAt = createdAt
  }


  readonly tokenAndDevices?: TokenAndDevice[] | FieldValue

readonly createdAt?: Date

  // eslint-disable-next-line @typescript-eslint/no-explicit-any
toJson(): Record<string, any> {
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  const json: Record<string, any> = {}
  if (this.tokenAndDevices != undefined) {
  json['tokenAndDevices'] = this.tokenAndDevices
}
if (this.createdAt != undefined) {
  json['createdAt'] = this.createdAt
}

  return json
}

}

export class DeleteFcmToken {}

/**
 * A Cloud Firestore object which ignores `undefined` properties.
 */
const db = admin.firestore()
db.settings({ ignoreUndefinedProperties: true })

/**
 * Provides a reference to the fcmTokens collection for reading.
 */
export const readFcmTokenCollectionReference = 
db
.collection('fcmTokens').withConverter<ReadFcmToken>({
  fromFirestore: (ds: FirebaseFirestore.DocumentSnapshot): ReadFcmToken => {
    return ReadFcmToken.fromDocumentSnapshot(ds)
  },
  toFirestore: () => {
      throw new Error(`toFirestore is not implemented for ReadFcmToken`)
  }
})


/**
 * Provides a reference to a fcmToken document for reading.
 * @param fcmTokenId - The ID of the fcmToken document to read.
 */
export const readFcmTokenDocumentReference = ({
  fcmTokenId
}: {
  fcmTokenId: string
}): FirebaseFirestore.DocumentReference<ReadFcmToken> =>
    readFcmTokenCollectionReference.doc(fcmTokenId);


/**
 * Provides a reference to the fcmTokens collection for creating.
 */
export const createFcmTokenCollectionReference = 
db
.collection('fcmTokens').withConverter<CreateFcmToken>({
  fromFirestore: () => {
    throw new Error(`fromFirestore is not implemented for CreateFcmToken`)
  },
  toFirestore: (obj: CreateFcmToken): FirebaseFirestore.DocumentData => {
      return obj.toJson()
  }
})


/**
 * Provides a reference to a fcmToken document for creating.
 * @param fcmTokenId - The ID of the fcmToken document to read.
 */
export const createFcmTokenDocumentReference = ({
  fcmTokenId
}: {
  fcmTokenId: string
}): FirebaseFirestore.DocumentReference<CreateFcmToken> =>
    createFcmTokenCollectionReference.doc(fcmTokenId);


/**
 * Provides a reference to the fcmTokens collection for updating.
 */
export const updateFcmTokenCollectionReference = 
db
.collection('fcmTokens').withConverter<UpdateFcmToken>({
  fromFirestore: () => {
    throw new Error(`fromFirestore is not implemented for UpdateFcmToken`)
  },
  toFirestore: (obj: UpdateFcmToken): FirebaseFirestore.DocumentData => {
      return obj.toJson()
  }
})


/**
 * Provides a reference to a fcmToken document for updating.
 * @param fcmTokenId - The ID of the fcmToken document to read.
 */
export const updateFcmTokenDocumentReference = ({
  fcmTokenId
}: {
  fcmTokenId: string
}): FirebaseFirestore.DocumentReference<UpdateFcmToken> =>
    updateFcmTokenCollectionReference.doc(fcmTokenId);


/**
 * Provides a reference to the fcmTokens collection for deleting.
 */
export const deleteFcmTokenCollectionReference = 
db
.collection('fcmTokens').withConverter<DeleteFcmToken>({
  fromFirestore: () => {
    throw new Error(`fromFirestore is not implemented for DeleteFcmToken`)
  },
  toFirestore: (): FirebaseFirestore.DocumentData => {
    throw new Error(`toFirestore is not implemented for DeleteFcmToken`)
  }
})


/**
 * Provides a reference to a fcmToken document for deleting.
 * @param fcmTokenId - The ID of the fcmToken document to read.
 */
export const deleteFcmTokenDocumentReference = ({
  fcmTokenId
}: {
  fcmTokenId: string
}): FirebaseFirestore.DocumentReference<DeleteFcmToken> =>
    deleteFcmTokenCollectionReference.doc(fcmTokenId);



/**
 * Manages queries against the fcmTokens collection.
 */
export class FcmTokenQuery {
  /**
   * Fetches fcmToken documents.
   * @param queryBuilder - Function to modify the query.
   * @param compare - Function to sort the results.
   */
  async fetchDocuments({
      
      queryBuilder,
      compare
  }: {
      
      queryBuilder?: (
          query: FirebaseFirestore.Query<ReadFcmToken>
      ) => FirebaseFirestore.Query<ReadFcmToken>
      compare?: (lhs: ReadFcmToken, rhs: ReadFcmToken) => number
  }): Promise<ReadFcmToken[]> {
      let query: FirebaseFirestore.Query<ReadFcmToken> =
          readFcmTokenCollectionReference
      if (queryBuilder != undefined) {
          query = queryBuilder(query)
      }
      const qs: QuerySnapshot<ReadFcmToken> = await query.get()
      let result = qs.docs.map((qds: QueryDocumentSnapshot<ReadFcmToken>) =>
          qds.data()
      )
      if (compare != undefined) {
          result = result.sort(compare)
      }
      return result
  }

  /**
   * Fetches a specific fcmToken document.
   * @param fcmTokenId - The ID of the fcmToken document to fetch.
   */
  async fetchDocument({
    
    fcmTokenId
  }: {
    
    fcmTokenId: string
  }): Promise<ReadFcmToken | undefined> {
    const ds = await readFcmTokenDocumentReference({
      
      fcmTokenId
    }).get()
    return ds.data()
  }

  /**
   * Adds a fcmToken document.
   * @param createFcmToken - The fcmToken details to add.
   */
  async add({
    
    createFcmToken
  }: {
    
    createFcmToken: CreateFcmToken
  }): Promise<DocumentReference<CreateFcmToken>> {
    return createFcmTokenCollectionReference.add(createFcmToken)
  }

  /**
   * Sets a fcmToken document.
   * @param fcmTokenId - The ID of the fcmToken document to set.
   * @param createFcmToken - The fcmToken details to set.
   * @param options - Options for the set operation.
   */
  async set({
      
      fcmTokenId,
      createFcmToken,
      options
  }: {
      
      fcmTokenId: string
      createFcmToken: CreateFcmToken
      options?: FirebaseFirestore.SetOptions
  }): Promise<WriteResult> {
      if (options == undefined) {
          return createFcmTokenDocumentReference({
            
            fcmTokenId
          }).set(createFcmToken)
      } else {
          return createFcmTokenDocumentReference({ 
            
            fcmTokenId 
            }).set(createFcmToken, options)
      }
  }

  /**
   * Updates a specific fcmToken document.
   * @param fcmTokenId - The ID of the fcmToken document to update.
   * @param updateFcmToken - The details for updating the fcmToken.
   */
  async update({
    
    fcmTokenId,
    updateFcmToken
  }: {
    
    fcmTokenId: string
    updateFcmToken: UpdateFcmToken
  }): Promise<WriteResult> {
      return updateFcmTokenDocumentReference({ 
        
        fcmTokenId 
      }).update(updateFcmToken.toJson())
  }

  /**
   * Deletes a specific fcmToken document.
   * @param fcmTokenId - The ID of the fcmToken document to delete.
   */
  async delete({
    
    fcmTokenId
  }: {
    
    fcmTokenId: string
  }): Promise<WriteResult> {
      return deleteFcmTokenDocumentReference({ 
        
        fcmTokenId 
      }).delete()
  }
}
