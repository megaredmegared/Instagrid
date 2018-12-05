//
//  ViewController.swift
//  Instagrid
//
//  Created by megared on 21/11/2018.
//  Copyright © 2018 OpenClassrooms. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var photoView: PhotosView!
    @IBOutlet weak var twoPhotosTopButton: LayoutButton!
    @IBOutlet weak var fourPhotosButton: LayoutButton!
    @IBOutlet weak var twoPhotosBottomButton: LayoutButton!
    @IBOutlet weak var twoPhotosButton: LayoutButton!
    @IBOutlet weak var colorSliders: UIView!
    @IBOutlet weak var colorPickerButton: UIButton!
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var buttonTopLeft: PhotoButton!
    @IBOutlet weak var buttonTopRight: PhotoButton!
    @IBOutlet weak var buttonBottomLeft: PhotoButton!
    @IBOutlet weak var buttonBottomRight: PhotoButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        startInstagrid()
    }
    
    /// Load photo from library in the layout
    
    let imagePicker = UIImagePickerController()
    
    /// All cases of buttons
    
    enum PhotoButtonTapped {
        case topLeftButton, topRightButton, bottomLeftButton, bottomRightButton
    }

    /// assign button tapped to a variable
    
    var photoButtonTapped: PhotoButtonTapped = .topLeftButton // lazy weak ????
    
    // TODO: Image is not corner rounded
    
    /// assign image to the button tapped
    
    func selectPhotoButton(_ selectedPhoto: PhotoButtonTapped, image: UIImage) {
        switch photoButtonTapped {
        case .topLeftButton :
            buttonTopLeft.setImage(image, for: .normal)
            buttonTopLeft.imageView?.contentMode = .scaleAspectFill
        case .topRightButton :
            buttonTopRight.setImage(image, for: .normal)
            buttonTopRight.imageView?.contentMode = .scaleAspectFill
        case .bottomLeftButton :
            buttonBottomLeft.setImage(image, for: .normal)
            buttonBottomLeft.imageView?.contentMode = .scaleAspectFill
        case .bottomRightButton :
            buttonBottomRight.setImage(image, for: .normal)
            buttonBottomRight.imageView?.contentMode = .scaleAspectFill
        }
    }
    
    /// Pick an image into the photo library
    
    func pickAnImageInLibrary() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    // TODO: Understand this function
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {

            selectPhotoButton(photoButtonTapped, image: image)
            
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
    /// Actions to import images on buttons
    
    @IBAction func didTapLoadTopLeftPhoto(_ sender: Any) {
        pickAnImageInLibrary()
        photoButtonTapped = .topLeftButton
    }
    @IBAction func didTapLoadTopRIght(_ sender: Any) {
        pickAnImageInLibrary()
        photoButtonTapped = .topRightButton
    }
    @IBAction func didTapLoadBottomLeft(_ sender: PhotoButton) {
        pickAnImageInLibrary()
        photoButtonTapped = .bottomLeftButton
    }
    @IBAction func didTapBottomRight(_ sender: Any) {
        pickAnImageInLibrary()
        photoButtonTapped = .bottomRightButton
    }
    
    /// Mark layoutButton has actived with a check mark image
    
    func activeViewButton(is layout: PhotosView.Layout) {
        
        photoView.layout = layout
        
        var button: LayoutButton
        
        switch layout {
        case .twoPhotosTop :
            button = twoPhotosTopButton
            
        case .twoPhotosBottom :
            button = twoPhotosBottomButton
            
        case .fourPhotos :
            button = fourPhotosButton
            
        case .twoPhotos :
            button = twoPhotosButton
        }
        
        let buttons = [twoPhotosTopButton, twoPhotosBottomButton, fourPhotosButton, twoPhotosButton]
        
        for i in buttons {
            if i != nil {
                i!.setImage(nil, for: .normal)
            }
        }
        
        button.setImage(#imageLiteral(resourceName: "photo check"), for: .highlighted)
        button.setImage(#imageLiteral(resourceName: "photo check"), for: .normal)
        
    }
    
    /// Buttons to choose the photo layout
    
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
    @IBAction func showColorSliders() {
        colorSliders.isHidden = false
    }
    
    /// Set background color with sliders
    
    var red: CGFloat = 4 / 255
    var green: CGFloat = 101 / 255
    var blue: CGFloat = 154 / 255
    var alpha: CGFloat = 1
    
    func setBackgroundColor() {
        photoView.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        colorPickerButton.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    @IBAction func redSlider(_ sender: UISlider) {
        red = CGFloat(sender.value) / 255
        setBackgroundColor()
    }
    @IBAction func greenSlider(_ sender: UISlider) {
        green = CGFloat(sender.value) / 255
        setBackgroundColor()
        
    }
    @IBAction func blueSlider(_ sender: UISlider) {
        blue = CGFloat(sender.value) / 255
        setBackgroundColor()
    }
    func resetBackgroundColor() {
        photoView.backgroundColor = UIColor(red: 4 / 255, green: 101 / 255, blue: 154 / 255, alpha: alpha)
        colorPickerButton.backgroundColor = UIColor(red: 4 / 255, green: 101 / 255, blue: 154 / 255, alpha: alpha)
    }
    
    // TODO: Find a way to set initial value in on area only
    
    /// Reset color sliders to there initial values
    
    @IBAction func resetColors() {
        resetBackgroundColor()
        redSlider.value = 4
        greenSlider.value = 101
        blueSlider.value = 154
    }
    
    /// Close color sliders
    
    @IBAction func closeColorSliders() {
        colorSliders.isHidden = true
    }
    
    /// Start the app
    
    private func startInstagrid() {
        activeViewButton(is: .fourPhotos)
        setBackgroundColor()
    }
}



