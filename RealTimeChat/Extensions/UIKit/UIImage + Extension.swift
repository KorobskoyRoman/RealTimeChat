//
//  UIImage + Extension.swift
//  RealTimeChat
//
//  Created by Roman Korobskoy on 06.02.2022.
//

import UIKit

// для сжатия изображений (из Stackoverflow)
extension UIImage {
    
    var scaledToSafeUploadSize: UIImage? {
        let maxImageSideLength: CGFloat = 480
        
        let largerSize: CGFloat = max(size.width, size.height)
        let ratioScale: CGFloat = largerSize > maxImageSideLength ? largerSize / maxImageSideLength : 1
        let newImageSize = CGSize(width: size.width / ratioScale, height: size.height / ratioScale)
        
        return image(scaledTo: newImageSize)
    }
    
    func image(scaledTo size: CGSize) -> UIImage? {
        defer {
            UIGraphicsEndImageContext()
        }
        
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        draw(in: CGRect(origin: .zero, size: size))
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
