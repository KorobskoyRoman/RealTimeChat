//
//  UserError.swift
//  RealTimeChat
//
//  Created by Roman Korobskoy on 04.02.2022.
//

import Foundation

enum UserError {
    case notFilled
    case photoNotExist
    case cantGetUserInfo
    case cantUnwrapToMUser
}

extension UserError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFilled:
            return NSLocalizedString("Fill all fields!", comment: "")
        case .photoNotExist:
            return NSLocalizedString("Fill photo!", comment: "")
        case .cantGetUserInfo:
            return NSLocalizedString("Can't load user info from firebase!", comment: "")
        case .cantUnwrapToMUser:
            return NSLocalizedString("Can't Unwrap To MUser!", comment: "")
        }
    }
}
