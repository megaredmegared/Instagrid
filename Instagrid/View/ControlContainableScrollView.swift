//
//  File.swift
//  Instagrid
//
//  Created by megared on 04/12/2018.
//  Copyright © 2018 OpenClassrooms. All rights reserved.
//

import UIKit

final class ControlContainableScrollView: UIScrollView {
    
    /// slider could work even if we are touching a button
    
    override func touchesShouldCancel(in view: UIView) -> Bool {
        if view is UIControl
            && !(view is UITextInput)
            && !(view is UISlider)
            && !(view is UISwitch) {
            return true
        }
        return super.touchesShouldCancel(in: view)
    }
    
}
