import * as admin from 'firebase-admin'
import {
    DocumentReference,
    FieldValue,
    QueryDocumentSnapshot,
    QuerySnapshot,
    WriteResult
} from 'firebase-admin/firestore'

export class ReadWorker {
  constructor ({
    workerId,
    path,
    displayName,
imageUrl,
isHost,
  }: {
    workerId: string
    path: string
    displayName: string
imageUrl: string
isHost: boolean
  }) {
    this.workerId = workerId
    this.path = path
    this.displayName = displayName
this.imageUrl = imageUrl
this.isHost = isHost
  }

  readonly workerId: string

  readonly path: string

  readonly displayName: string

readonly imageUrl: string

readonly isHost: boolean

  private static fromJson(json: Record<string, unknown>): ReadWorker {
    return new ReadWorker({
      workerId: json['workerId'] as string,
      path: json['path'] as string,
      displayName: (json['displayName'] as string | undefined) ?? '',
imageUrl: (json['imageUrl'] as string | undefined) ?? '',
isHost: (json['isHost'] as boolean | undefined) ?? false,
    })
  }


  static fromDocumentSnapshot(
    ds: FirebaseFirestore.DocumentSnapshot
  ): ReadWorker {
      const data = ds.data()!
      const cleanedData: Record<string, unknown> = {}
      for (const [key, value] of Object.entries(data)) {
          cleanedData[key] = value === null ? undefined : value
      }
      return ReadWorker.fromJson({
          ...cleanedData,
          workerId: ds.id,
          path: ds.ref.path
      })
  }

}

export class CreateWorker {
  constructor({
    displayName,
imageUrl,
isHost,
  }: {
    displayName: string
imageUrl: string
isHost: boolean
  }) {
    this.displayName = displayName
this.imageUrl = imageUrl
this.isHost = isHost
  }

  readonly displayName: string

readonly imageUrl: string

readonly isHost: boolean

  toJson(): Record<string, unknown> {
  return {
    displayName: this.displayName,
imageUrl: this.imageUrl,
isHost: this.isHost,
  };
}

}

export class UpdateWorker {
  constructor({
    displayName,
imageUrl,
isHost,
  }: {
    displayName: string
imageUrl: string
isHost: boolean
  }) {
    this.displayName = displayName
this.imageUrl = imageUrl
this.isHost = isHost
  }

  readonly displayName: string

readonly imageUrl: string

readonly isHost: boolean

  toJson(): Record<string, unknown> {
  const json: Record<string, unknown> = {}
  if (this.displayName != null) {
  json['displayName'] = this.displayName
}
if (this.imageUrl != null) {
  json['imageUrl'] = this.imageUrl
}
if (this.isHost != null) {
  json['isHost'] = this.isHost
}

  return json
}

}

export class DeleteWorker {}

/**
 * A Cloud Firestore object which ignores `undefined` properties.
 */
const db = admin.firestore()
db.settings({ ignoreUndefinedProperties: true })

/**
 * Provides a reference to the workers collection for reading.
 */
export const readWorkerCollectionReference = 
db
.collection('workers').withConverter<ReadWorker>({
  fromFirestore: (ds: FirebaseFirestore.DocumentSnapshot): ReadWorker => {
    return ReadWorker.fromDocumentSnapshot(ds)
  },
  toFirestore: () => {
      throw new Error(`toFirestore is not implemented for ReadWorker`)
  }
})
;

/**
 * Provides a reference to a worker document for reading.
 * @param workerId - The ID of the worker document to read.
 */
export const readWorkerDocumentReference = ({
  workerId
}: {
  workerId: string
}): FirebaseFirestore.DocumentReference<ReadWorker> =>
    readWorkerCollectionReference.doc(workerId);


/**
 * Provides a reference to the workers collection for creating.
 */
export const createWorkerCollectionReference = 
db
.collection('workers').withConverter<CreateWorker>({
  fromFirestore: () => {
    throw new Error(`fromFirestore is not implemented for CreateWorker`)
  },
  toFirestore: (obj: CreateWorker): FirebaseFirestore.DocumentData => {
      return obj.toJson()
  }
})
;

/**
 * Provides a reference to a worker document for creating.
 * @param workerId - The ID of the worker document to read.
 */
export const createWorkerDocumentReference = ({
  workerId
}: {
  workerId: string
}): FirebaseFirestore.DocumentReference<CreateWorker> =>
    createWorkerCollectionReference.doc(workerId);


/**
 * Provides a reference to the workers collection for updating.
 */
export const updateWorkerCollectionReference = 
db
.collection('workers').withConverter<UpdateWorker>({
  fromFirestore: () => {
    throw new Error(`fromFirestore is not implemented for UpdateWorker`)
  },
  toFirestore: (obj: UpdateWorker): FirebaseFirestore.DocumentData => {
      return obj.toJson()
  }
})
;

/**
 * Provides a reference to a worker document for updating.
 * @param workerId - The ID of the worker document to read.
 */
export const updateWorkerDocumentReference = ({
  workerId
}: {
  workerId: string
}): FirebaseFirestore.DocumentReference<UpdateWorker> =>
    updateWorkerCollectionReference.doc(workerId);


/**
 * Provides a reference to the workers collection for deleting.
 */
export const deleteWorkerCollectionReference = 
db
.collection('workers').withConverter<DeleteWorker>({
  fromFirestore: () => {
    throw new Error(`fromFirestore is not implemented for DeleteWorker`)
  },
  toFirestore: (): FirebaseFirestore.DocumentData => {
    throw new Error(`toFirestore is not implemented for DeleteWorker`)
  }
})
;

/**
 * Provides a reference to a worker document for deleting.
 * @param workerId - The ID of the worker document to read.
 */
export const deleteWorkerDocumentReference = ({
  workerId
}: {
  workerId: string
}): FirebaseFirestore.DocumentReference<DeleteWorker> =>
    deleteWorkerCollectionReference.doc(workerId);



/**
 * Manages queries against the workers collection.
 */
export class WorkerQuery {
  /**
   * Fetches worker documents.
   * @param queryBuilder - Function to modify the query.
   * @param compare - Function to sort the results.
   */
  async fetchDocuments({
      queryBuilder,
      compare
  }: {
      queryBuilder?: (
          query: FirebaseFirestore.Query<ReadWorker>
      ) => FirebaseFirestore.Query<ReadWorker>
      compare?: (lhs: ReadWorker, rhs: ReadWorker) => number
  } = {}): Promise<ReadWorker[]> {
      let query: FirebaseFirestore.Query<ReadWorker> =
          readWorkerCollectionReference
      if (queryBuilder != undefined) {
          query = queryBuilder(query)
      }
      const qs: QuerySnapshot<ReadWorker> = await query.get()
      let result = qs.docs.map((qds: QueryDocumentSnapshot<ReadWorker>) =>
          qds.data()
      )
      if (compare != undefined) {
          result = result.sort(compare)
      }
      return result
  }

  /**
   * Fetches a specific worker document.
   * @param workerId - The ID of the worker document to fetch.
   */
  async fetchDocument(workerId: string): Promise<ReadWorker | undefined> {
      const ds = await readWorkerDocumentReference({ workerId }).get()
      return ds.data()
  }

  /**
   * Adds a worker document.
   * @param createWorker - The worker details to add.
   */
  async add(createWorker: CreateWorker): Promise<DocumentReference<CreateWorker>> {
      return createWorkerCollectionReference.add(createWorker)
  }

  /**
   * Sets a worker document.
   * @param workerId - The ID of the worker document to set.
   * @param createWorker - The worker details to set.
   * @param options - Options for the set operation.
   */
  async set({
      workerId,
      createWorker,
      options
  }: {
      workerId: string
      createWorker: CreateWorker
      options?: FirebaseFirestore.SetOptions
  }): Promise<WriteResult> {
      if (options == undefined) {
          return createWorkerDocumentReference({ workerId }).set(createWorker)
      } else {
          return createWorkerDocumentReference({ workerId }).set(
              createWorker,
              options
          )
      }
  }

  /**
   * Updates a specific worker document.
   * @param workerId - The ID of the worker document to update.
   * @param updateWorker - The details for updating the worker.
   */
  async update(workerId: string, updateWorker: UpdateWorker): Promise<WriteResult> {
      return updateWorkerDocumentReference({ workerId }).update(
          updateWorker.toJson()
      )
  }

  /**
   * Deletes a specific worker document.
   * @param workerId - The ID of the worker document to delete.
   */
  async delete(workerId: string): Promise<WriteResult> {
      return deleteWorkerDocumentReference({ workerId }).delete()
  }
}
