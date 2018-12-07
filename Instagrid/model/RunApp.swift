//
//  RunApp.swift
//  Instagrid
//
//  Created by megared on 30/11/2018.
//  Copyright © 2018 OpenClassrooms. All rights reserved.
//

import Foundation
import UIKit

class RunApp {

    
    enum actionOnPhotos {
        case share, trash
    }
    
    // TODO: erase this lines
    func shareImage() {
        let activityVC = UIActivityViewController(activityItems: [#imageLiteral(resourceName: "trashcan")], applicationActivities: nil)
        activityVC.present(activityVC, animated: true, completion: nil)
        //activityVC.dismiss(animated: true, completion: nil)
        print("******** It works ***********")
        
    }

}
