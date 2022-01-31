//
//  MUser.swift
//  RealTimeChat
//
//  Created by Roman Korobskoy on 31.01.2022.
//

import UIKit

struct MUser: Hashable, Decodable {
    var username: String
    var userImageString: String
    var id: Int
    
    func hash(into hasher: inout Hasher) { // модель для Diffable data source
        hasher.combine(id)
    }
    
    static func == (lhs: MUser, rhs: MUser) -> Bool {
        return lhs.id == rhs.id
    }
}
