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
    @IBOutlet weak var twoPhotosTopButton: UIButton!
    @IBOutlet weak var fourPhotosButton: UIButton!
    @IBOutlet weak var twoPhotosBottomButton: UIButton!
    @IBOutlet weak var twoPhotosButton: UIButton!
    @IBOutlet weak var twoPhotosVerticalButton: UIButton!
    @IBOutlet weak var twoPhotosLeftButton: UIButton!
    @IBOutlet weak var twoPhotosRightButton: UIButton!
    @IBOutlet weak var onePhotosButton: UIButton!
    @IBOutlet weak var colorSliders: UIView!
    @IBOutlet weak var colorPickerButton: UIButton!
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startInstagrid()
    }
    
    // MARK: - LOAD PHOTO FROM LIBRARY IN THE LAYOUT ------
    
    /// photo button that is tapped
    
    var photoButtonTapped: PhotoButtonTapped = .topLeftButton //TODO: lazy weak ????
    
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
    
    /// Picked image from the photo library
    
    let imagePicker = UIImagePickerController()
    
    /// Pick an image from the photo library
    
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
    
    
    /// import image from the library in the layout for the tapped button
    
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
    
    // MARK: - ASSIGN CHECKMARK TO THE CORRESPONDING ACTIVE LAYOUT ------
    
    /// Mark layoutButton has actived with a checkmark image
    
    func activeViewButton(is layout: Layout) {
        
        photoView.layout = layout
        
        var button: UIButton
        
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
        
        /// reset all buttons checkmark image
        for i in buttons {
            if i != nil {
                i?.setImage(nil, for: .normal)
            }
        }
        
        /// set the button selected with a checkmark
        button.setImage(#imageLiteral(resourceName: "photo check"), for: .highlighted)
        button.setImage(#imageLiteral(resourceName: "photo check"), for: .normal)
        
    }
    @IBAction func didTapTwoPhotosTopButton() {
        activeViewButton(is: .twoPhotosTop)
    }
    @IBAction func didTapTwoPhotosBottomButton() {
        activeViewButton(is: .twoPhotosBottom)
    }
    @IBAction func didTapFourPhotosButton() {
        activeViewButton(is: .fourPhotos)
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
    
    
    
    // MARK: - SET THE BACKGROUND COLOR WITH SLIDERS ------
    
    /// Default values for the layout background
    
    let redDefault: CGFloat = 4 / 255
    let greenDefault: CGFloat = 101 / 255
    let blueDefault: CGFloat = 154 / 255
    let aplhaDefault: CGFloat = 1
    
    // TODO: set variable to default value ????
    
    var red: CGFloat = 4 / 255
    var green: CGFloat = 101 / 255
    var blue: CGFloat = 154 / 255
    var alpha: CGFloat = 1
    
    /// set and sync the background color RGB values with the sliders values
    
    func setBackgroundColor() {
        photoView.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        colorPickerButton.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /// sliders for RGB values
    
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
    
    /// Reset color sliders and background color to there initial values
    
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
    
    /// show color sliders
    
    @IBAction func didTapColorPickerButton() {
        colorSliders.isHidden = false
    }
    
    
    // MARK: - DRAG PHOTOVIEW TO SHARE THE PHOTOS OR TRASH THEM ------
    
    /// drag photo view and share or trash them
    
    @IBAction func dragPhotoView(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began, .changed:
            transformPhotoView(gesture: sender)
        case .cancelled, .ended:
            shareOrTrashPhotoView()
        default:
            break
        }
    }
    
    /// asked action on photo layout
    
    var actionOnPhotos: ActionOnPhotos = .inPlace
    
    /// track the gesture to move the photoView
    
    private func transformPhotoView(gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translation(in: photoView)
        var translationTransform: CGAffineTransform
        
        /// detect device orientation for gesture direction
        
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            
            /// landscape mode
            translationTransform = CGAffineTransform(translationX: translation.x, y: 0)
            photoView.transform = translationTransform
            
            /// drag right
            if translation.x > 150 {
                actionOnPhotos = .trash
                /// drag left
            } else if translation.x < -150 {
                actionOnPhotos = .share
            }
            
        } else {
            /// portrait mode
            translationTransform = CGAffineTransform(translationX: 0, y: translation.y)
            photoView.transform = translationTransform
            /// drag down
            if translation.y > 150 {
                actionOnPhotos = .trash
                /// drag up
            } else if translation.y < -150 {
                actionOnPhotos = .share
                /// not enought dragging to trigger something
            } else if translation.y < 150 || translation.y > -150 {
                actionOnPhotos = .inPlace
            }
            
        }
    }
    
    /// sharing photo service
    
    func sharePhoto() {
        
        /// check that the layout is full of photo
        if (photoView.buttonTopLeft.currentImage != UIImage(imageLiteralResourceName: "plusSign") || photoView.buttonTopLeft.isHidden == true) && (photoView.buttonTopRight.currentImage != UIImage(imageLiteralResourceName: "plusSign") || photoView.buttonTopRight.isHidden == true) && (photoView.buttonBottomLeft.currentImage != UIImage(imageLiteralResourceName: "plusSign") || photoView.buttonBottomLeft.isHidden == true) && (photoView.buttonBottomRight.currentImage != UIImage(imageLiteralResourceName: "plusSign") || photoView.buttonBottomRight.isHidden == true) {
            
            /// construct the image to share
            let imageToShare: UIImage = UIImage(view: photoView)
            
            let activityVC = UIActivityViewController(activityItems: [imageToShare], applicationActivities: nil)
            self.present(activityVC, animated: true, completion: nil)
            print("******** It works ***********")
        } else {
            /// alert if photos are missing
            let alert = UIAlertController(title: "Not ready for sharing", message: "photos are missing", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                switch action.style{
                case .default:
                    print("default")
                    
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                }}))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    /// reset photo in layout
    
    func resetPhotosImported() {
        photoView.buttonTopLeft.setImage(#imageLiteral(resourceName: "plusSign"), for: .normal)
        photoView.buttonTopRight.setImage(#imageLiteral(resourceName: "plusSign"), for: .normal)
        photoView.buttonBottomLeft.setImage(#imageLiteral(resourceName: "plusSign"), for: .normal)
        photoView.buttonBottomRight.setImage(#imageLiteral(resourceName: "plusSign"), for: .normal)
    }
    
    
    
    
    let screenHight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    
    
    
    private func shareOrTrashPhotoView() {
        var translationTransform: CGAffineTransform
        
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            /// landscape mode
            if actionOnPhotos == .share {
                translationTransform = CGAffineTransform(translationX: -screenWidth, y: 0)
                print("test UP")
                UIView.animate(withDuration: 0.3, animations: {
                    self.photoView.transform = translationTransform
                }) { (success) in
                    if success {
                        self.sharePhoto()
                        self.showPhotoView()
                    }
                }
                
            } else if actionOnPhotos == .trash {
                translationTransform = CGAffineTransform(translationX: screenWidth, y: 0)
                print("test DOWN")
                UIView.animate(withDuration: 0.3, animations: {
                    self.photoView.transform = translationTransform
                }) { (success) in
                    if success {
                        self.resetPhotosImported()
                        self.showPhotoView()
                    }
                }
            } else if actionOnPhotos == .inPlace {
                translationTransform = CGAffineTransform(translationX: 0, y: 0)
                print("test nothing")
                UIView.animate(withDuration: 0.3, animations: {
                    self.photoView.transform = translationTransform
                })
            }
        } else {
            if actionOnPhotos == .share {
                translationTransform = CGAffineTransform(translationX: 0, y: -screenHight)
                print("test UP")
                UIView.animate(withDuration: 0.3, animations: {
                    self.photoView.transform = translationTransform
                }) { (success) in
                    if success {
                        self.sharePhoto()
                        self.showPhotoView()
                    }
                }
                
            } else if actionOnPhotos == .trash {
                translationTransform = CGAffineTransform(translationX: 0, y: screenHight)
                print("test DOWN")
                UIView.animate(withDuration: 0.3, animations: {
                    self.photoView.transform = translationTransform
                }) { (success) in
                    if success {
                        self.resetPhotosImported()
                        self.showPhotoView()
                    }
                }
            } else if actionOnPhotos == .inPlace {
                translationTransform = CGAffineTransform(translationX: 0, y: 0)
                print("test nothing")
                UIView.animate(withDuration: 0.3, animations: {                    self.photoView.transform = translationTransform
                })
            }
        }
    }
    
    private func showPhotoView() {
        photoView.transform = .identity
        photoView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.photoView.transform = .identity
        }, completion: nil)
    }
    
    // MARK: - START THE APP ------
    
    private func startInstagrid() {
        activeViewButton(is: .twoPhotosTop)
        setBackgroundColor()
    }
}



