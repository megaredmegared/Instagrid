//
//  PhotoButton.swift
//  Instagrid
//
//  Created by megared on 30/11/2018.
//  Copyright © 2018 OpenClassrooms. All rights reserved.
//

import UIKit

class PhotoButton: UIButton {
    
//    @IBInspectable
//    var cornerRadius: CGFloat {
//                get {
//                    return layer.cornerRadius
//                }
//                set {
//                    layer.cornerRadius = 6
//            }
//   }
    
    
//    override var layer: CAShapeLayer {
//        get {
//            return super.layer as! CAShapeLayer
//        }
//    }
//    override layer.cornerRadius = 6
    
   @IBInspectable
    var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = 6
        }
    }

}
