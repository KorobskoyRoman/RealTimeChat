//
//  SelfConfiguringCell.swift
//  RealTimeChat
//
//  Created by Roman Korobskoy on 31.01.2022.
//

import UIKit

protocol SelfConfiguringCell {
    static var reuseId: String { get }
    func configure<U: Hashable>(with value: U)
}
