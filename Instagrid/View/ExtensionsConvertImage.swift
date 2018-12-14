//
//  File.swift
//  Instagrid
//
//  Created by megared on 07/12/2018.
//  Copyright © 2018 OpenClassrooms. All rights reserved.
//

import UIKit

extension UIImage {
    
    
    // TODO: Check if still needed
    /// resize UIView
    
//    convenience init(view: UIView) {
//        UIGraphicsBeginImageContext(view.frame.size)
//        view.layer.render(in:UIGraphicsGetCurrentContext()!)
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        self.init(cgImage: image!.cgImage!)
//    }
    
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
