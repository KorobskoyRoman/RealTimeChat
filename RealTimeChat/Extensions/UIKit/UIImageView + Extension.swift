//
//  UIImageView + Extension.swift
//  RealTimeChat
//
//  Created by Roman Korobskoy on 24.01.2022.
//

import UIKit

extension UIImageView {
    
    convenience init(image: UIImage?, contentMode: UIView.ContentMode) {
        self.init()
        
        self.image = image
        self.contentMode = contentMode
    }
}

extension UIImageView {
    func setupColor(color: UIColor) {
        let tempImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = tempImage
        self.tintColor = color
    }
}
