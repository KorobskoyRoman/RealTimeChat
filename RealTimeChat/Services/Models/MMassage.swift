//
//  MMassage.swift
//  RealTimeChat
//
//  Created by Roman Korobskoy on 06.02.2022.
//

import UIKit
import FirebaseFirestore

struct MMassage: Hashable {
    let content: String
    let senderId: String
    let senderUsername: String
    var sentDate: Date
    let id: String?
    
    init(user: MUser, content: String) {
        self.content = content
        senderId = user.id
        senderUsername = user.username
        sentDate = Date()
        id = nil
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let sentDate = data["created"] as? Timestamp else { return nil }
        guard let senderId = data["senderID"] as? String else { return nil }
        guard let senderName = data["senderName"] as? String else { return nil }
        guard let content = data["content"] as? String else { return nil }
        
        self.id = document.documentID
        self.sentDate = sentDate.dateValue()
        self.senderId = senderId
        self.senderUsername = senderName
        self.content = content
    }
    
    var representation: [String: Any] {
        let rep: [String: Any] = [
            "created": sentDate,
            "senderId": senderId,
            "senderUsername": senderUsername,
            "content": content
        ]
        return rep
    }
}
