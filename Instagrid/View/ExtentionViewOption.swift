//
//  LaunchScreenGradient.swift
//  Instagrid
//
//  Created by megared on 22/11/2018.
//  Copyright © 2018 OpenClassrooms. All rights reserved.
//

import UIKit

// Improve the UI toolkit of Interface Builder

// Make change appear at design time

@IBDesignable
class DesignableView: UIView {

}

@IBDesignable
class DesignableButton: UIButton {
}

@IBDesignable
class DesignableLabel: UILabel {

}

@IBDesignable
class DesignableImageView: UIImageView {
    @IBInspectable var Rotation: Double = 0 {
        didSet {
            rotateLabel(labelRotation: Rotation)
            self.layoutIfNeeded()
        }
    }
    
    //*********** verify is divide correct ? *****************
    
    func rotateLabel(labelRotation: Double)  {
        self.transform = CGAffineTransform(rotationAngle: CGFloat(labelRotation * Double.pi / 180))
    }
}

// Add UI Options Tabs for Interface Builder

extension UIView {

    
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}
