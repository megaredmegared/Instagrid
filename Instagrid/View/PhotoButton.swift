//
//  PhotoButton.swift
//  Instagrid
//
//  Created by megared on 30/11/2018.
//  Copyright © 2018 OpenClassrooms. All rights reserved.


import UIKit

class PhotoButton: UIButton {
    
    /// Rounded corner for the photos
    
    override func layoutSubviews() {
        super.layoutSubviews()
        super.layer.cornerRadius = 6
    }
}
