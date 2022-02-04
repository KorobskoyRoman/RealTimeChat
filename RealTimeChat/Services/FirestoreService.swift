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
    
    func getUserData(user: User, completion: @escaping (Result<MUser, Error>) -> Void) {
        let docRef = usersRef.document(user.uid)
        docRef.getDocument { document, error in
            if let document = document, document.exists {
                guard let muser = MUser(document: document) else {
                    completion(.failure(UserError.cantUnwrapToMUser))
                    return
                }
                completion(.success(muser))
            } else {
                completion(.failure(UserError.cantGetUserInfo))
            }
        }
    }
    
    func saveProfileWith(id: String, email: String, username: String?, avatarImage: String, description: String?, sex: String?, completion: @escaping (Result<MUser, Error>) -> Void) {
        
        guard Validators.isFilled(username: username, description: description, sex: sex) else {
            completion(.failure(UserError.notFilled))
            return
        }
        let muser = MUser(username: username!,
                          email: email,
                          userImageString: "not exist",
                          description: description!,
                          sex: sex!,
                          id: id)
        self.usersRef.document(muser.id).setData(muser.representation) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(muser))
            }
        }
    }
}
