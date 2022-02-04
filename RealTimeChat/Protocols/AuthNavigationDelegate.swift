//
//  AuthNavigationDelegate.swift
//  RealTimeChat
//
//  Created by Roman Korobskoy on 04.02.2022.
//

import Foundation

protocol AuthNavigationDelegate: AnyObject {
    func toLoginVC()
    func toSignUpVC()
}
