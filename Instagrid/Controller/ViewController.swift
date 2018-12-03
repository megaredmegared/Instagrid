//
//  ViewController.swift
//  Instagrid
//
//  Created by megared on 21/11/2018.
//  Copyright © 2018 OpenClassrooms. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    @IBOutlet weak var photoView: PhotosView!
    @IBOutlet weak var twoPhotosTopButton: LayoutButton!
    @IBOutlet weak var fourPhotosButton: LayoutButton!
    @IBOutlet weak var twoPhotosBottomButton: LayoutButton!
    @IBOutlet weak var twoPhotosButton: LayoutButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        startInstagrid()
        
        
    }
    
    /// Mark layoutButton has actived with a check mark image
    
    func activeViewButton(is layout: PhotosView.Layout) {
        photoView.layout = layout
        switch layout {
        case .twoPhotosTop :
            twoPhotosTopButton.setImage(#imageLiteral(resourceName: "photo check"), for: .normal)
            fourPhotosButton.setImage(nil, for: .normal)
            twoPhotosBottomButton.setImage(nil, for: .normal)
            twoPhotosButton.setImage(nil, for: .normal)
            
            twoPhotosTopButton.setImage(#imageLiteral(resourceName: "photo check"), for: .highlighted)
            
        case .twoPhotosBottom :
            twoPhotosTopButton.setImage(nil, for: .normal)
            fourPhotosButton.setImage(nil, for: .normal)
            twoPhotosBottomButton.setImage(#imageLiteral(resourceName: "photo check"), for: .normal)
            twoPhotosButton.setImage(nil, for: .normal)
            
            twoPhotosBottomButton.setImage(#imageLiteral(resourceName: "photo check"), for: .highlighted)
            
        case .fourPhotos :
            twoPhotosTopButton.setImage(nil, for: .normal)
            fourPhotosButton.setImage(#imageLiteral(resourceName: "photo check"), for: .normal)
            twoPhotosBottomButton.setImage(nil, for: .normal)
            twoPhotosButton.setImage(nil, for: .normal)
            
            fourPhotosButton.setImage(#imageLiteral(resourceName: "photo check"), for: .highlighted)
            
        case .twoPhotos :
            twoPhotosTopButton.setImage(nil, for: .normal)
            fourPhotosButton.setImage(nil, for: .normal)
            twoPhotosBottomButton.setImage(nil, for: .normal)
            twoPhotosButton.setImage(#imageLiteral(resourceName: "photo check"), for: .normal)
            
            twoPhotosButton.setImage(#imageLiteral(resourceName: "photo check"), for: .highlighted)
        }
        
        
    }
    
    @IBAction func didTapTwoPhotosTopButton() {
        activeViewButton(is: .twoPhotosTop)
    }
    
    
    @IBAction func didTapFourPhotosButton() {
        activeViewButton(is: .fourPhotos)
    }
    
    @IBAction func didTapTwoPhotosBottomButton() {
        activeViewButton(is: .twoPhotosBottom)
    }
    
    @IBAction func didTapTwoPhotosButton() {
        activeViewButton(is: .twoPhotos)
    }
    
    private func startInstagrid() {
        activeViewButton(is: .twoPhotosTop)
        photoView.backgroundColor = #colorLiteral(red: 0.01577522606, green: 0.3959292471, blue: 0.6036854386, alpha: 1)
    }
}



