//
//  FirestoreService.swift
//  RealTimeChat
//
//  Created by Roman Korobskoy on 04.02.2022.
//

import Firebase
import FirebaseFirestore

class FirestoreService {
    
    static let shared = FirestoreService()
    
    let db = Firestore.firestore()
    
    private var usersRef: CollectionReference {
        return db.collection("users") //ссылка на нашу коллекцию из БД
    }
    
    private var waitingChatsRef: CollectionReference {
        return db.collection(["users", currentUser.id, "waitingChats"].joined(separator: "/"))
    }
    var currentUser: MUser!
    
    func getUserData(user: User, completion: @escaping (Result<MUser, Error>) -> Void) {
        let docRef = usersRef.document(user.uid)
        docRef.getDocument { document, error in
            if let document = document, document.exists {
                guard let muser = MUser(document: document) else {
                    completion(.failure(UserError.cantUnwrapToMUser))
                    return
                }
                self.currentUser = muser
                completion(.success(muser))
            } else {
                completion(.failure(UserError.cantGetUserInfo))
            }
        }
    }
    
    func saveProfileWith(id: String, email: String, username: String?, avatarImage: UIImage?, description: String?, sex: String?, completion: @escaping (Result<MUser, Error>) -> Void) {
        
        guard Validators.isFilled(username: username, description: description, sex: sex) else {
            completion(.failure(UserError.notFilled))
            return
        }
        
        guard avatarImage != #imageLiteral(resourceName: "avatar") else {
            completion(.failure(UserError.photoNotExist))
            return
        }
        
        var muser = MUser(username: username!,
                          email: email,
                          userImageString: "not exist",
                          description: description!,
                          sex: sex!,
                          id: id)
        StorageService.shared.upload(photo: avatarImage!) { (result) in
            switch result {
                
            case .success(let url):
                muser.userImageString = url.absoluteString
                self.usersRef.document(muser.id).setData(muser.representation) { (error) in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(muser))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func createWaitingChat(message: String, receiver: MUser, completion: @escaping (Result<Void, Error>) -> Void) {
        // создаем ссылки на документы в БД
        let reference = db.collection(["users", receiver.id, "waitingChats"].joined(separator: "/"))
        let messageRef = reference.document(self.currentUser.id).collection("messages")
        
        let message = MMassage(user: currentUser, content: message)
        let chat = MChat(friendUsername: currentUser.username,
                         friendImageString: currentUser.userImageString,
                         lastMessageContent: message.content,
                         friendId: currentUser.id)
        
        // создаем новый документ с id пользователя
        reference.document(currentUser.id).setData(chat.representation) { error in
            if let error = error {
                completion(.failure(error))
                return
            }
            messageRef.addDocument(data: message.representation) { error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                completion(.success(Void()))
            }
        }
    }
    func deleteWaitingChat(chat: MChat, completion: @escaping (Result<Void, Error>) -> Void) {
        waitingChatsRef.document(chat.friendId).delete { error in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(Void()))
            self.deleteMessages(chat: chat, completion: completion)
        }
    }
     
    func deleteMessages(chat: MChat, completion: @escaping (Result<Void, Error>) -> Void) {
        let referece = waitingChatsRef.document(chat.friendId).collection("messages")
        
        getWaitingChatMessages(chat: chat) { result in
            switch result {
            case .success(let messages):
                for message in messages {
                    guard let documentId = message.id else { return }
                    let messageRef = referece.document(documentId)
                    messageRef.delete { error in
                        if let error = error {
                            completion(.failure(error))
                            return
                        }
                        completion(.success(Void()))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getWaitingChatMessages(chat: MChat, completion: @escaping (Result<[MMassage], Error>) -> Void) {
        let referece = waitingChatsRef.document(chat.friendId).collection("messages")
        var messages = [MMassage]()
        referece.getDocuments { querySnapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            for document in querySnapshot!.documents {
                guard let message = MMassage(document: document) else { return }
                messages.append(message)
            }
            completion(.success(messages))
        }
    }
}
