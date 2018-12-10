//
//  PhotoButton.swift
//  Instagrid
//
//  Created by megared on 30/11/2018.
//  Copyright © 2018 OpenClassrooms. All rights reserved.
//

import UIKit

class PhotoButton: UIButton {
    
    /// Round corner for the photos
    
    override func layoutSubviews() {
        super.layoutSubviews()
        super.layer.cornerRadius = 6
    }
//    var translationTransform: CGAffineTransform = CGAffineTransform.init(scaleX: 20, y: 20)
//    func animeButton() {
//        UIButton.animate(withDuration: 1) {
//            self.transform = self.translationTransform
//        }
//    }
   


}
