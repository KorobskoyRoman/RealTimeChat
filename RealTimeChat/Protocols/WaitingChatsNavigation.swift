//
//  WaitingChatsNavigation.swift
//  RealTimeChat
//
//  Created by Roman Korobskoy on 06.02.2022.
//

import Foundation

protocol WaitingChatsNavigation: AnyObject {
    func removeWaitingChat(chat: MChat)
    func changeToActive(chat: MChat)
}
