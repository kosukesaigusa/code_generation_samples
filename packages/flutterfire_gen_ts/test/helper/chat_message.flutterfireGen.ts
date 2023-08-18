import * as admin from 'firebase-admin'
import {
    DocumentReference,
    FieldValue,
    QueryDocumentSnapshot,
    QuerySnapshot,
    WriteResult
} from 'firebase-admin/firestore'

export class ReadChatMessage {
  constructor ({
    chatMessageId,
    path,
    senderId,
content,
imageUrls,
isDeleted,
  }: {
    chatMessageId: string
    path: string
    senderId: string
content: string
imageUrls: string[]
isDeleted: boolean
  }) {
    this.chatMessageId = chatMessageId
    this.path = path
    this.senderId = senderId
this.content = content
this.imageUrls = imageUrls
this.isDeleted = isDeleted
  }

  readonly chatMessageId: string

  readonly path: string

  readonly senderId: string

readonly content: string

readonly imageUrls: string[]

readonly isDeleted: boolean

  private static fromJson(json: Record<string, unknown>): ReadChatMessage {
    return new ReadChatMessage({
      chatMessageId: json['chatMessageId'] as string,
      path: json['path'] as string,
      senderId: json['senderId'] as string,
content: (json['content'] as string | undefined) ?? '',
imageUrls: (json['imageUrls'] as (unknown[]  | undefined))?.map((e) => e as string).toList() ?? const <String>[],
isDeleted: (json['isDeleted'] as boolean | undefined) ?? false,
    })
  }


  static fromDocumentSnapshot(
    ds: FirebaseFirestore.DocumentSnapshot
  ): ReadChatMessage {
      const data = ds.data()!
      const cleanedData: Record<string, unknown> = {}
      for (const [key, value] of Object.entries(data)) {
          cleanedData[key] = value === null ? undefined : value
      }
      return ReadChatMessage.fromJson({
          ...cleanedData,
          chatMessageId: ds.id,
          path: ds.ref.path
      })
  }

}

export class CreateChatMessage {
  constructor({
    senderId,
content,
imageUrls,
isDeleted,
  }: {
    senderId: string
content: string
imageUrls: string[]
isDeleted: boolean
  }) {
    this.senderId = senderId
this.content = content
this.imageUrls = imageUrls
this.isDeleted = isDeleted
  }


  readonly senderId: string

readonly content: string

readonly imageUrls: string[]

readonly isDeleted: boolean

  toJson(): Record<string, unknown> {
  return {
    senderId: this.senderId,
content: this.content,
imageUrls: this.imageUrls,
isDeleted: this.isDeleted,
  };
}

}

export class UpdateChatMessage {
  constructor({
    senderId,
content,
imageUrls,
isDeleted,
  }: {
    senderId?: string
content?: string
imageUrls?: string[]
isDeleted?: boolean
  }) {
    this.senderId = senderId
this.content = content
this.imageUrls = imageUrls
this.isDeleted = isDeleted
  }


  readonly senderId?: string

readonly content?: string

readonly imageUrls?: string[]

readonly isDeleted?: boolean

  toJson(): Record<string, unknown> {
  const json: Record<string, unknown> = {}
  if (this.senderId != undefined) {
  json['senderId'] = this.senderId
}
if (this.content != undefined) {
  json['content'] = this.content
}
if (this.imageUrls != undefined) {
  json['imageUrls'] = this.imageUrls
}
if (this.isDeleted != undefined) {
  json['isDeleted'] = this.isDeleted
}

  return json
}

}

export class DeleteChatMessage {}

/**
 * A Cloud Firestore object which ignores `undefined` properties.
 */
const db = admin.firestore()
db.settings({ ignoreUndefinedProperties: true })

/**
 * Provides a reference to the chatMessages collection for reading.
 */
export const readChatMessageCollectionReference = (
  {
  chatRoomId
}: {
  chatRoomId: string
}
): FirebaseFirestore.CollectionReference<ReadChatMessage>

=> { return db
.collection('chatRooms').doc(chatRoomId).collection('chatMessages').withConverter<ReadChatMessage>({
  fromFirestore: (ds: FirebaseFirestore.DocumentSnapshot): ReadChatMessage => {
    return ReadChatMessage.fromDocumentSnapshot(ds)
  },
  toFirestore: () => {
      throw new Error(`toFirestore is not implemented for ReadChatMessage`)
  }
})
}

/**
 * Provides a reference to a chatMessage document for reading.
 * @param chatMessageId - The ID of the chatMessage document to read.
 */
export const readChatMessageDocumentReference = ({
  chatRoomId,
  chatMessageId,
}: {
  chatRoomId: string,
  chatMessageId: string
}): FirebaseFirestore.DocumentReference<ReadChatMessage> =>
    readChatMessageCollectionReference({
      chatRoomId
    }).doc(chatMessageId);


/**
 * Provides a reference to the chatMessages collection for creating.
 */
export const createChatMessageCollectionReference = (
  {
  chatRoomId
}: {
  chatRoomId: string
}
): FirebaseFirestore.CollectionReference<CreateChatMessage>

=> { return db
.collection('chatRooms').doc(chatRoomId).collection('chatMessages').withConverter<CreateChatMessage>({
  fromFirestore: () => {
    throw new Error(`fromFirestore is not implemented for CreateChatMessage`)
  },
  toFirestore: (obj: CreateChatMessage): FirebaseFirestore.DocumentData => {
      return obj.toJson()
  }
})
}

/**
 * Provides a reference to a chatMessage document for creating.
 * @param chatMessageId - The ID of the chatMessage document to read.
 */
export const createChatMessageDocumentReference = ({
  chatRoomId,
  chatMessageId,
}: {
  chatRoomId: string,
  chatMessageId: string
}): FirebaseFirestore.DocumentReference<CreateChatMessage> =>
    createChatMessageCollectionReference({
      chatRoomId
    }).doc(chatMessageId);


/**
 * Provides a reference to the chatMessages collection for updating.
 */
export const updateChatMessageCollectionReference = (
  {
  chatRoomId
}: {
  chatRoomId: string
}
): FirebaseFirestore.CollectionReference<UpdateChatMessage>

=> { return db
.collection('chatRooms').doc(chatRoomId).collection('chatMessages').withConverter<UpdateChatMessage>({
  fromFirestore: () => {
    throw new Error(`fromFirestore is not implemented for UpdateChatMessage`)
  },
  toFirestore: (obj: UpdateChatMessage): FirebaseFirestore.DocumentData => {
      return obj.toJson()
  }
})
}

/**
 * Provides a reference to a chatMessage document for updating.
 * @param chatMessageId - The ID of the chatMessage document to read.
 */
export const updateChatMessageDocumentReference = ({
  chatRoomId,
  chatMessageId,
}: {
  chatRoomId: string,
  chatMessageId: string
}): FirebaseFirestore.DocumentReference<UpdateChatMessage> =>
    updateChatMessageCollectionReference({
      chatRoomId
    }).doc(chatMessageId);


/**
 * Provides a reference to the chatMessages collection for deleting.
 */
export const deleteChatMessageCollectionReference = (
  {
  chatRoomId
}: {
  chatRoomId: string
}
): FirebaseFirestore.CollectionReference<DeleteChatMessage>

=> { return db
.collection('chatRooms').doc(chatRoomId).collection('chatMessages').withConverter<DeleteChatMessage>({
  fromFirestore: () => {
    throw new Error(`fromFirestore is not implemented for DeleteChatMessage`)
  },
  toFirestore: (): FirebaseFirestore.DocumentData => {
    throw new Error(`toFirestore is not implemented for DeleteChatMessage`)
  }
})
}

/**
 * Provides a reference to a chatMessage document for deleting.
 * @param chatMessageId - The ID of the chatMessage document to read.
 */
export const deleteChatMessageDocumentReference = ({
  chatRoomId,
  chatMessageId,
}: {
  chatRoomId: string,
  chatMessageId: string
}): FirebaseFirestore.DocumentReference<DeleteChatMessage> =>
    deleteChatMessageCollectionReference({
      chatRoomId
    }).doc(chatMessageId);



/**
 * Manages queries against the chatMessages collection.
 */
export class ChatMessageQuery {
  /**
   * Fetches chatMessage documents.
   * @param queryBuilder - Function to modify the query.
   * @param compare - Function to sort the results.
   */
  async fetchDocuments({
      chatRoomId,
      queryBuilder,
      compare
  }: {
      chatRoomId: string,
      queryBuilder?: (
          query: FirebaseFirestore.Query<ReadChatMessage>
      ) => FirebaseFirestore.Query<ReadChatMessage>
      compare?: (lhs: ReadChatMessage, rhs: ReadChatMessage) => number
  }): Promise<ReadChatMessage[]> {
      let query: FirebaseFirestore.Query<ReadChatMessage> =
          readChatMessageCollectionReference({chatRoomId})
      if (queryBuilder != undefined) {
          query = queryBuilder(query)
      }
      const qs: QuerySnapshot<ReadChatMessage> = await query.get()
      let result = qs.docs.map((qds: QueryDocumentSnapshot<ReadChatMessage>) =>
          qds.data()
      )
      if (compare != undefined) {
          result = result.sort(compare)
      }
      return result
  }

  /**
   * Fetches a specific chatMessage document.
   * @param chatMessageId - The ID of the chatMessage document to fetch.
   */
  async fetchDocument({
    chatRoomId,
    chatMessageId
  }: {
    chatRoomId: string,
    chatMessageId: string
  }): Promise<ReadChatMessage | undefined> {
    const ds = await readChatMessageDocumentReference({
      chatRoomId,
      chatMessageId
    }).get()
    return ds.data()
  }

  /**
   * Adds a chatMessage document.
   * @param CreateChatMessage - The chatMessage details to add.
   */
  async add({
    chatRoomId,
    CreateChatMessage
  }: {
    chatRoomId: string,
    CreateChatMessage: CreateChatMessage
  }): Promise<DocumentReference<CreateChatMessage>> {
    return createChatMessageCollectionReference({chatRoomId}).add(CreateChatMessage)
  }

  /**
   * Sets a chatMessage document.
   * @param chatMessageId - The ID of the chatMessage document to set.
   * @param CreateChatMessage - The chatMessage details to set.
   * @param options - Options for the set operation.
   */
  async set({
      chatRoomId,
      chatMessageId,
      CreateChatMessage,
      options
  }: {
      chatRoomId: string,
      chatMessageId: string
      CreateChatMessage: CreateChatMessage
      options?: FirebaseFirestore.SetOptions
  }): Promise<WriteResult> {
      if (options == undefined) {
          return createChatMessageDocumentReference({
            chatRoomId,
            chatMessageId
          }).set(CreateChatMessage)
      } else {
          return createChatMessageDocumentReference({ 
            chatRoomId,
            chatMessageId 
            }).set(CreateChatMessage, options)
      }
  }

  /**
   * Updates a specific chatMessage document.
   * @param chatMessageId - The ID of the chatMessage document to update.
   * @param UpdateChatMessage - The details for updating the chatMessage.
   */
  async update({
    chatRoomId,
    chatMessageId,
    UpdateChatMessage
  }: {
    chatRoomId: string,
    chatMessageId: string
    UpdateChatMessage: UpdateChatMessage
  }): Promise<WriteResult> {
      return updateChatMessageDocumentReference({ 
        chatRoomId,
        chatMessageId 
      }).update(UpdateChatMessage.toJson())
  }

  /**
   * Deletes a specific chatMessage document.
   * @param chatMessageId - The ID of the chatMessage document to delete.
   */
  async delete({
    chatRoomId,
    chatMessageId
  }: {
    chatRoomId: string,
    chatMessageId: string
  }): Promise<WriteResult> {
      return deleteChatMessageDocumentReference({ 
        chatRoomId,
        chatMessageId 
      }).delete()
  }
}
