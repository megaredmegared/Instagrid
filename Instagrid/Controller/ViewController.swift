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
    @IBOutlet weak var twoPhotosVerticalButton: LayoutButton!
    @IBOutlet weak var twoPhotosLeftButton: LayoutButton!
    @IBOutlet weak var twoPhotosRightButton: LayoutButton!
    @IBOutlet weak var onePhotosButton: LayoutButton!
    @IBOutlet weak var colorSliders: UIView!
    @IBOutlet weak var colorPickerButton: UIButton!
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        startInstagrid()
    }
    
    
    var runApp = RunApp()
    
    /// Load photo from library in the layout
    
    let imagePicker = UIImagePickerController()
    
    /// All cases of buttons
    
    enum PhotoButtonTapped {
        case topLeftButton, topRightButton, bottomLeftButton, bottomRightButton
    }
    
    /// assign button tapped to a variable
    
    var photoButtonTapped: PhotoButtonTapped = .topLeftButton // lazy weak ????
    
    /// assign image to the button tapped
    
    func selectPhotoButton(_ selectedPhoto: PhotoButtonTapped, image: UIImage) {
        
        let cornerRadius: CGFloat = 6
        
        switch photoButtonTapped {
        case .topLeftButton :
            photoView.buttonTopLeft.setImage(image, for: .normal)
            photoView.buttonTopLeft.imageView?.contentMode = .scaleAspectFill
            photoView.buttonTopLeft.imageView?.layer.cornerRadius = cornerRadius
        case .topRightButton :
            photoView.buttonTopRight.setImage(image, for: .normal)
            photoView.buttonTopRight.imageView?.contentMode = .scaleAspectFill
            photoView.buttonTopRight.imageView?.layer.cornerRadius = cornerRadius
        case .bottomLeftButton :
            photoView.buttonBottomLeft.setImage(image, for: .normal)
            photoView.buttonBottomLeft.imageView?.contentMode = .scaleAspectFill
            photoView.buttonBottomLeft.imageView?.layer.cornerRadius = cornerRadius
        case .bottomRightButton :
            photoView.buttonBottomRight.setImage(image, for: .normal)
            photoView.buttonBottomRight.imageView?.contentMode = .scaleAspectFill
            photoView.buttonBottomRight.imageView?.layer.cornerRadius = cornerRadius
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
    @IBAction func didTapLoadBottomLeft(_ sender: Any) {
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
            
        case .twoPhotosVertical :
            button = twoPhotosVerticalButton
            
        case .twoPhotoLeft :
            button = twoPhotosLeftButton
            
        case .twoPhotoRight :
            button = twoPhotosRightButton
            
        case .onePhoto :
            button = onePhotosButton
            
        case .twoPhotos :
            button = twoPhotosButton
        }
        
        let buttons = [twoPhotosTopButton, twoPhotosBottomButton, fourPhotosButton, twoPhotosButton, twoPhotosVerticalButton, twoPhotosLeftButton, twoPhotosRightButton, onePhotosButton]
        
        for i in buttons {
            if i != nil {
                i?.setImage(nil, for: .normal)
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
    
    @IBAction func didTapTwoPhotosVerticalButton() {
        activeViewButton(is: .twoPhotosVertical)
    }
    
    @IBAction func didTapTwoPhotosLeftButton() {
        activeViewButton(is: .twoPhotoLeft)
    }
    
    @IBAction func didTapTwoPhotosRightButton() {
        activeViewButton(is: .twoPhotoRight)
    }
    
    @IBAction func didTapOnePhotoButton() {
        activeViewButton(is: .onePhoto)
    }
    
    
    
    @IBAction func showColorSliders() {
        colorSliders.isHidden = false
    }
    
    /// Set background color with sliders -----------------------------------------------------------------------
    
    // TODO: set variable to default value
    
    var red: CGFloat = 4 / 255
    var green: CGFloat = 101 / 255
    var blue: CGFloat = 154 / 255
    var alpha: CGFloat = 1
    
    /// Default values for the layout background
    
    let redDefault: CGFloat = 4 / 255
    let greenDefault: CGFloat = 101 / 255
    let blueDefault: CGFloat = 154 / 255
    let aplhaDefault: CGFloat = 1
    
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
    
    /// reset layout background color to default values
    
    func resetBackgroundColor() {
        photoView.backgroundColor = UIColor(red: redDefault, green: greenDefault, blue: blueDefault, alpha: aplhaDefault)
        colorPickerButton.backgroundColor = UIColor(red: redDefault, green: greenDefault, blue: blueDefault, alpha: aplhaDefault)
    }
    
    /// Reset color sliders to there initial values
    
    @IBAction func resetColors() {
        resetBackgroundColor()
        redSlider.value = Float(redDefault * 255)
        greenSlider.value = Float(greenDefault * 255)
        blueSlider.value = Float(blueDefault * 255)
    }
    
    /// Close color sliders
    
    @IBAction func closeColorSliders() {
        colorSliders.isHidden = true
    }
    
    /// Drag photoview to send the photos or trash them -------------------------------------------------
    
    @IBAction func dragPhotoView(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began, .changed:
            // if photos charged
            transformPhotoView(gesture: sender)
        case .cancelled, .ended:
            sendOrTrashPhotoView()
        default:
            break
        }
    }
    
    private func transformPhotoView(gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translation(in: photoView)
        var translationTransform: CGAffineTransform
        let screenHight = UIScreen.main.bounds.height
        let screenWidth = UIScreen.main.bounds.width
        
        func resetPhotosImported() {
            photoView.buttonTopLeft.setImage(#imageLiteral(resourceName: "plusSign"), for: .normal)
            photoView.buttonTopRight.setImage(#imageLiteral(resourceName: "plusSign"), for: .normal)
            photoView.buttonBottomLeft.setImage(#imageLiteral(resourceName: "plusSign"), for: .normal)
            photoView.buttonBottomRight.setImage(#imageLiteral(resourceName: "plusSign"), for: .normal)
        }
        
        /// detect device orientation for gesture direction
        
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            
            translationTransform = CGAffineTransform(translationX: translation.x, y: 0)
            
            photoView.transform = translationTransform
            
            /// landscape mode
            if translation.x > 150 {
                // erase
                translationTransform = CGAffineTransform(translationX: screenWidth, y: 0)
                resetPhotosImported()
                
                
                
            } else if translation.x > -150 {
                
                translationTransform = CGAffineTransform(translationX: -screenWidth, y: 0)
                // send photo
                
            }
            /// portrait mode
        } else {
            translationTransform = CGAffineTransform(translationX: 0, y: translation.y)
            photoView.transform = translationTransform
            if translation.y > 150 {
                // erase
                translationTransform = CGAffineTransform(translationX: 0, y: screenHight)
                resetPhotosImported()
                
                
            } else if translation.y > -150 {
                
                translationTransform = CGAffineTransform(translationX: 0, y: -screenHight)
                // send photo
                // sharePhoto()
                
            }
        }
        
    }
    

    
    
   
    
    func sharePhoto() {
        // convert UIView
        let imageToShare: UIImage = UIImage(view: photoView)
        
        let activityVC = UIActivityViewController(activityItems: [imageToShare], applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
        print("******** It works ***********")
    }
    
    private func sendOrTrashPhotoView() {
        
        photoView.transform = .identity
        
    }
    
    
    
    
    
    /// Start the app -----------------------------------------------------------------------
    
    private func startInstagrid() {
        activeViewButton(is: .twoPhotosTop)
        setBackgroundColor()
    }
}



