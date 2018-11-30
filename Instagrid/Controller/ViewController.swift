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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        startInstagrid()
        
        
    }
    
    @IBAction func didTapTwoPhotosTopButton() {
        photoView.layout = .twoPhotosTop
        
        twoPhotosTopButton.setImage(#imageLiteral(resourceName: "photo check"), for: .selected)
        twoPhotosTopButton.setImage(#imageLiteral(resourceName: "photo check"), for: .highlighted)
    }
    
    
    @IBAction func didTapFourPhotosButton() {
        photoView.layout = .fourPhotos
    }
    
    @IBAction func didTapTwoPhotosBottomButton() {
        photoView.layout = .twoPhotosBottom
    }
    
    @IBAction func didTapTwoPhotosButton() {
        photoView.layout = .twoPhotos
    }
    
    private func startInstagrid() {
        photoView.layout = .twoPhotosTop
        photoView.backgroundColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        twoPhotosTopButton.setTitle("test", for: .normal)
        
    }
}



