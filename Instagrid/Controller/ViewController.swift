//
//  ViewController.swift
//  Instagrid
//
//  Created by megared on 21/11/2018.
//  Copyright © 2018 OpenClassrooms. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var photosView: PhotosView!
    @IBOutlet weak var twoPhotosTopButton: UIButton!
    @IBOutlet weak var fourPhotosButton: UIButton!
    @IBOutlet weak var twoPhotosBottomButton: UIButton!
    @IBOutlet weak var twoPhotosButton: UIButton!
    @IBOutlet weak var twoPhotosVerticalButton: UIButton!
    @IBOutlet weak var twoPhotosLeftButton: UIButton!
    @IBOutlet weak var twoPhotosRightButton: UIButton!
    @IBOutlet weak var onePhotosButton: UIButton!

    @IBOutlet weak var colorPickerButton: UIButton!
    @IBOutlet weak var colorSliders: UIView!
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!

    
    
    @IBOutlet weak var layoutButtons: ControlContainableScrollView!
    
    /// Color picker instance
    
    var colorPicker = ColorPicker()
    
    /// image size for imported and shared images
    
    private var imageSizeImportedOrShared: CGFloat = 2048
    
    /// photo button that is tapped
    
    private var photoButtonTapped: PhotoButtonTapped = .topLeftButton
    
    /// Picked image from the photo library
    
    private let imagePicker = UIImagePickerController()
    
    /// Default values for the layout background color
    
    let redDefault: CGFloat = 4 / 255
    let greenDefault: CGFloat = 101 / 255
    let blueDefault: CGFloat = 154 / 255
    let aplhaDefault: CGFloat = 1
    
    // starting values for the layout background color
    
    lazy var red: CGFloat = redDefault
    lazy var green: CGFloat = greenDefault
    lazy var blue: CGFloat = blueDefault
    lazy var alpha: CGFloat = aplhaDefault
    
    /// asked action on photo layout
    
    private var actionOnPhotos: ActionOnPhotos = .inPlace
    
    private let screenHight = UIScreen.main.bounds.height
    private let screenWidth = UIScreen.main.bounds.width
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startInstagrid()
    }
    
    // MARK: - LOAD PHOTO FROM LIBRARY IN THE LAYOUT ------
    
    /// assign image to the button tapped
    
    private func selectPhotoButton(_ selectedPhoto: PhotoButtonTapped, image: UIImage) {
        
        let imageResized = UIImage.resizeImage(image: image, newMinSideSize: imageSizeImportedOrShared)
        
        let cornerRadius: CGFloat = 6
        
        switch photoButtonTapped {
        case .topLeftButton :
            photosView.buttonTopLeft.setImage(imageResized, for: .normal)
            photosView.buttonTopLeft.imageView?.contentMode = .scaleAspectFill
            photosView.buttonTopLeft.imageView?.layer.cornerRadius = cornerRadius
        case .topRightButton :
            photosView.buttonTopRight.setImage(imageResized, for: .normal)
            photosView.buttonTopRight.imageView?.contentMode = .scaleAspectFill
            photosView.buttonTopRight.imageView?.layer.cornerRadius = cornerRadius
        case .bottomLeftButton :
            photosView.buttonBottomLeft.setImage(imageResized, for: .normal)
            photosView.buttonBottomLeft.imageView?.contentMode = .scaleAspectFill
            photosView.buttonBottomLeft.imageView?.layer.cornerRadius = cornerRadius
        case .bottomRightButton :
            photosView.buttonBottomRight.setImage(imageResized, for: .normal)
            photosView.buttonBottomRight.imageView?.contentMode = .scaleAspectFill
            photosView.buttonBottomRight.imageView?.layer.cornerRadius = cornerRadius
        }
    }
    
    /// Pick an image from the photo library
    
    private func pickAnImageInLibrary() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    // TODO: Understand this function why no more use of authorization message
    
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
    
    private func activeViewButton(is layout: Layout) {
        
        photosView.layout = layout
        
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
    
    /// layout buttons tapped
    
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
    
    /// sliders for RGB values
    
    @IBAction func redSlider(_ sender: UISlider) {
        colorPicker.red = CGFloat(sender.value) / 255
        colorPicker.setBackgroundColor(view: photosView, button: colorPickerButton)
    }
    @IBAction func greenSlider(_ sender: UISlider) {
        colorPicker.green = CGFloat(sender.value) / 255
        colorPicker.setBackgroundColor(view: photosView, button: colorPickerButton)
        
    }
    @IBAction func blueSlider(_ sender: UISlider) {
        colorPicker.blue = CGFloat(sender.value) / 255
        colorPicker.setBackgroundColor(view: photosView, button: colorPickerButton)
    }
    
    /// Reset color sliders and background color to there initial values
    
    @IBAction func resetColors() {
        colorPicker.resetBackgroundColor(view: photosView, button: colorPickerButton)
        redSlider.value = Float(colorPicker.redDefault * 255)
        greenSlider.value = Float(colorPicker.greenDefault * 255)
        blueSlider.value = Float(colorPicker.blueDefault * 255)
    }
    
    /// Close color sliders
    
    @IBAction func closeColorSliders() {
        colorSliders.isHidden = true
    }
    
    /// show color sliders
    
    @IBAction func didTapColorPickerButton() {
        colorSliders.isHidden = false
    }
    
    // MARK: - DRAG photosView TO SHARE THE PHOTOS OR TRASH THEM ------
    
    /// set the layout buttons on the back to make the photosView pass over them
    
    private func layoutButtonsZPosition() {
        layoutButtons.layer.zPosition = -1
    }
    
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
    
    /// track the gesture to move the photosView
    
    private func transformPhotoView(gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translation(in: photosView)
        var translationTransform: CGAffineTransform
        let slideLenght: CGFloat = 50
        
        /// detect device orientation for gesture direction
        
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            
            /// landscape mode
            translationTransform = CGAffineTransform(translationX: translation.x, y: 0)
            photosView.transform = translationTransform
            
            /// drag right
            if translation.x > slideLenght {
                actionOnPhotos = .trash
                /// drag left
            } else if translation.x < -slideLenght {
                actionOnPhotos = .share
                /// not enought dragging to trigger something
            } else if translation.x < slideLenght || translation.x > -slideLenght {
                actionOnPhotos = .inPlace
            }
            
        } else {
            /// portrait mode
            translationTransform = CGAffineTransform(translationX: 0, y: translation.y)
            photosView.transform = translationTransform
            /// drag down
            if translation.y > slideLenght {
                actionOnPhotos = .trash
                /// drag up
            } else if translation.y < -slideLenght {
                actionOnPhotos = .share
                /// not enought dragging to trigger something
            } else if translation.y < slideLenght || translation.y > -slideLenght {
                actionOnPhotos = .inPlace
            }
            
        }
    }
  
    /// transform a view in image with a specific width
    
    func image(with view: UIView, scaledWidthTo width: CGFloat) -> UIImage? {
        let scale = width / view.bounds.width
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, scale)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            view.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }
    
    /// sharing photo service
    
    private func sharePhoto() {
        
        /// check that the layout is full of photo
        if (photosView.buttonTopLeft.currentImage != UIImage(imageLiteralResourceName: "plusSign") || photosView.buttonTopLeft.isHidden == true) && (photosView.buttonTopRight.currentImage != UIImage(imageLiteralResourceName: "plusSign") || photosView.buttonTopRight.isHidden == true) && (photosView.buttonBottomLeft.currentImage != UIImage(imageLiteralResourceName: "plusSign") || photosView.buttonBottomLeft.isHidden == true) && (photosView.buttonBottomRight.currentImage != UIImage(imageLiteralResourceName: "plusSign") || photosView.buttonBottomRight.isHidden == true) {
            
            if self.image(with: photosView, scaledWidthTo: imageSizeImportedOrShared) != nil {
                // construct the image to share
                let imageToShare = self.image(with: photosView, scaledWidthTo: imageSizeImportedOrShared)!
                /// share the image
                let activityVC = UIActivityViewController(activityItems: [imageToShare], applicationActivities: nil)
                self.present(activityVC, animated: true, completion: nil)
            }
            
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
    
    private func resetPhotosImported() {
        photosView.buttonTopLeft.setImage(#imageLiteral(resourceName: "plusSign"), for: .normal)
        photosView.buttonTopRight.setImage(#imageLiteral(resourceName: "plusSign"), for: .normal)
        photosView.buttonBottomLeft.setImage(#imageLiteral(resourceName: "plusSign"), for: .normal)
        photosView.buttonBottomRight.setImage(#imageLiteral(resourceName: "plusSign"), for: .normal)
    }
    
    /// animation when sharing
    
    private func shareAnimation(translationX: CGFloat , y: CGFloat) {
        let translationTransform: CGAffineTransform
        translationTransform = CGAffineTransform(translationX: translationX, y: y)
        UIView.animate(withDuration: 0.3, animations: {
            self.photosView.transform = translationTransform
        }) { (success) in
            if success {
                self.sharePhoto()
                self.showPhotoView()
            }
        }
    }
    
    /// animation when reseting the layout photos
    
    private func trashAnimation(translationX: CGFloat , y: CGFloat) {
        let translationTransform = CGAffineTransform(translationX: translationX, y: y)
        UIView.animate(withDuration: 0.3, animations: {
            self.photosView.transform = translationTransform
        }) { (success) in
            if success {
                self.resetPhotosImported()
                self.showPhotoView()
            }
        }
    }
    
    /// animation when not enought dragging to trigger an action
    
    private func inPlaceAnimation() {
        let translationTransform = CGAffineTransform(translationX: 0, y: 0)
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.photosView.transform = translationTransform
        })
    }
    
    /// share the photo layout dragging it one way or reset the layout if dragging it the other way
    
    private func shareOrTrashPhotoView() {
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            /// landscape mode
            switch actionOnPhotos {
            case .share:
                shareAnimation(translationX: -screenWidth, y: 0)
            case .trash:
                trashAnimation(translationX: screenWidth, y: 0)
            case .inPlace:
                 inPlaceAnimation()
            }
            /// Portrait mode
        } else {
            switch actionOnPhotos {
            case .share:
                 shareAnimation(translationX: 0, y: -screenHight)
            case .trash:
                trashAnimation(translationX: 0, y: screenHight)
            case .inPlace:
                inPlaceAnimation()
            }
        }
    }
    
    /// show the photo view with an animation
    
    private func showPhotoView() {
        photosView.transform = .identity
        photosView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.photosView.transform = .identity
        }, completion: nil)
    }
    
    // MARK: - START THE APP ------
    
    private func startInstagrid() {
        activeViewButton(is: .twoPhotosTop)
        colorPicker.setBackgroundColor(view: photosView, button: colorPickerButton)
        layoutButtonsZPosition()
    }
}
