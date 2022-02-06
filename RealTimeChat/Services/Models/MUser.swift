//
//  MUser.swift
//  RealTimeChat
//
//  Created by Roman Korobskoy on 31.01.2022.
//

import UIKit
import FirebaseFirestore

struct MUser: Hashable, Decodable {
    var username: String
    var email: String
    var userImageString: String
    var description: String
    var sex: String
    var id: String
    
    init(username: String, email: String, userImageString: String, description: String, sex: String, id: String) {
        self.username = username
        self.email = email
        self.userImageString = userImageString
        self.description = description
        self.sex = sex
        self.id = id
    }
    
    init?(document: DocumentSnapshot) {
        guard let data = document.data() else { return nil }
        guard let username = data["username"] as? String,
              let email = data["email"] as? String,
              let userImageString = data["userImageString"] as? String,
              let description = data["description"] as? String,
              let sex = data["sex"] as? String,
              let id = data["uid"] as? String
        else { return nil }
        
        self.username = username
        self.email = email
        self.userImageString = userImageString
        self.description = description
        self.sex = sex
        self.id = id
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let username = data["username"] as? String,
              let email = data["email"] as? String,
              let userImageString = data["userImageString"] as? String,
              let description = data["description"] as? String,
              let sex = data["sex"] as? String,
              let id = data["uid"] as? String
        else { return nil }
        
        self.username = username
        self.email = email
        self.userImageString = userImageString
        self.description = description
        self.sex = sex
        self.id = id
    }
    
    var representation: [String: Any] {
        var rep = ["username": username]
        rep["sex"] = sex
        rep["email"] = email
        rep["userImageString"] = userImageString
        rep["description"] = description
        rep["uid"] = id
        return rep
    }
    
    func hash(into hasher: inout Hasher) { // модель для Diffable data source
        hasher.combine(id)
    }
    
    static func == (lhs: MUser, rhs: MUser) -> Bool {
        return lhs.id == rhs.id
    }
    
    func contains(filter: String?) -> Bool {
        guard let filter = filter else { return true }
        if filter.isEmpty { return true }
        let lowercasedFilter = filter.lowercased()
        return username.lowercased().contains(lowercasedFilter)
    }
}
