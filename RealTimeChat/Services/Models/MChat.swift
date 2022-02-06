//
//  MChat.swift
//  RealTimeChat
//
//  Created by Roman Korobskoy on 31.01.2022.
//

import UIKit
import FirebaseFirestore

struct MChat: Hashable, Decodable {
    var friendUsername: String
    var friendImageString: String
    var lastMessageContent: String
    var friendId: String
    
    var representation: [String: Any] {
        var rep = ["friendUsername": friendUsername]
        rep["friendImageString"] = friendImageString
        rep["friendId"] = friendId
        rep["lastMessage"] = lastMessageContent
        return rep
    }
    
    init(friendUsername: String, friendImageString: String, lastMessageContent: String, friendId: String) {
        self.friendUsername = friendUsername
        self.friendImageString = friendImageString
        self.friendId = friendId
        self.lastMessageContent = lastMessageContent
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let friendUsername = data["friendUsername"] as? String,
              let friendImageString = data["friendImageString"] as? String,
              let friendId = data["friendId"] as? String,
              let lastMessageContent = data["lastMessage"] as? String
        else { return nil }
        
        self.friendUsername = friendUsername
        self.friendImageString = friendImageString
        self.friendId = friendId
        self.lastMessageContent = lastMessageContent
    }
    
    func hash(into hasher: inout Hasher) { // модель для Diffable data source
        hasher.combine(friendId)
    }
    
    static func == (lhs: MChat, rhs: MChat) -> Bool {
        return lhs.friendId == rhs.friendId
    }
}
