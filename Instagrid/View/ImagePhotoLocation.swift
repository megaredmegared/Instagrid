//
//  ImagePhotoLocation.swift
//  Instagrid
//
//  Created by megared on 22/11/2018.
//  Copyright © 2018 OpenClassrooms. All rights reserved.
//

import UIKit

/// Set the images locations all with the same UI properties

class ImagePhotoLocation: DesignableImageView {
    // FIXME: try a shorter code for overriding ?
    override var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = 6
        }
    }
}


