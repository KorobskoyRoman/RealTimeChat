//
//  BundleDecodable.swift
//  RealTimeChat
//
//  Created by Roman Korobskoy on 26.01.2022.
//

import Foundation
import UIKit

extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("File not exist \(file)")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("failed load \(file)")
        }
        
        let decoder = JSONDecoder()
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("fail to decode \(file)")
        }
        return loaded
    }
}
