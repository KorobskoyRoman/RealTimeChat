//
//  AuthError.swift
//  RealTimeChat
//
//  Created by Roman Korobskoy on 02.02.2022.
//

import Foundation

enum AuthError {
    case notFilled
    case invalidEmail
    case passwordNotMatched
    case unknownError
    case serverError
}

extension AuthError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFilled:
            return NSLocalizedString("Fill all fields!", comment: "")
        case .invalidEmail:
            return NSLocalizedString("Fill correct email!", comment: "")
        case .passwordNotMatched:
            return NSLocalizedString("Passwords are not the same!", comment: "")
        case .unknownError:
            return NSLocalizedString("Unknown error", comment: "")
        case .serverError:
            return NSLocalizedString("Server return error!", comment: "")
        }
    }
}
