//
//  File.swift
//  Instagrid
//
//  Created by megared on 07/12/2018.
//  Copyright © 2018 OpenClassrooms. All rights reserved.
//

import UIKit

extension UIImage {
    
    /// resize image in relation to his smallest side
    
    class func resizeImage(image: UIImage, newMinSideSize: CGFloat) -> UIImage {
        
        if image.size.height < image.size.width {
            let newHeight = newMinSideSize
            let scale = newHeight / image.size.height
            let newWidth = image.size.width * scale
            UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
            image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        } else {
            let newWidth = newMinSideSize
            let scale = newWidth / image.size.width
            let newHeight = image.size.height * scale
            UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
            image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        }
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
