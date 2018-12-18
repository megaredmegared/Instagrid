//
//  ViewController.swift
//  Instagrid
//
//  Created by megared on 21/11/2018.
//  Copyright © 2018 OpenClassrooms. All rights reserved.

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var photosView: PhotosView!
    @IBOutlet weak var colorPickerSlider: ColorPickerSlider!
    @IBOutlet weak var scrollViewLayoutButtons: ScrollViewLayoutButtons!
    
    /// image size for imported and shared images
    private var imageSizeImportedOrShared: CGFloat = 2048
    
    /// photo button that is tapped
    private var photoButtonTapped: PhotoButtonTapped = .topLeftButton
    
    /// Picked image from the photo library
    private let imagePicker = UIImagePickerController()
    
    /// asked action on photo layout
    private var actionOnPhotos: ActionOnPhotos = .inPlace
    
    // MARK: - VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        startInstagrid()
    }
    
    // MARK: - LOAD PHOTO FROM LIBRARY IN THE LAYOUT
    /// assign image to the button tapped
    private func selectPhotoButton(_ selectedPhoto: PhotoButtonTapped, image: UIImage) {
        
        let imageResized = UIImage.resizeImage(image: image, newMinSideSize: imageSizeImportedOrShared)
        
        let cornerRadius: CGFloat = 6
        
        var button: UIButton {
            switch photoButtonTapped {
            case .topLeftButton :
                return photosView.buttonTopLeft
            case .topRightButton :
                return photosView.buttonTopRight
            case .bottomLeftButton :
                return photosView.buttonBottomLeft
            case .bottomRightButton :
                return photosView.buttonBottomRight
            }
        }
        button.setImage(imageResized, for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.imageView?.layer.cornerRadius = cornerRadius
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
    
    // MARK: - ASSIGN CHECKMARK TO THE CORRESPONDING ACTIVE LAYOUT
    /// layout buttons tapped
    @IBAction func didTapTwoPhotosTopButton() {
        scrollViewLayoutButtons.setLayoutButton(view: photosView, layout: .twoPhotosTop)
    }
    @IBAction func didTapTwoPhotosBottomButton() {
        scrollViewLayoutButtons.setLayoutButton(view: photosView, layout: .twoPhotosBottom)
    }
    @IBAction func didTapFourPhotosButton() {
        scrollViewLayoutButtons.setLayoutButton(view: photosView, layout: .fourPhotos)
    }
    @IBAction func didTapTwoPhotosButton() {
        scrollViewLayoutButtons.setLayoutButton(view: photosView, layout: .twoPhotos)
    }
    @IBAction func didTapTwoPhotosVerticalButton() {
        scrollViewLayoutButtons.setLayoutButton(view: photosView, layout: .twoPhotosVertical)
    }
    @IBAction func didTapTwoPhotosLeftButton() {
        scrollViewLayoutButtons.setLayoutButton(view: photosView, layout: .twoPhotoLeft)
    }
    @IBAction func didTapTwoPhotosRightButton() {
        scrollViewLayoutButtons.setLayoutButton(view: photosView, layout: .twoPhotoRight)
    }
    @IBAction func didTapOnePhotoButton() {
        scrollViewLayoutButtons.setLayoutButton(view: photosView, layout: .onePhoto)
    }
    
    // MARK: - SET THE BACKGROUND COLOR WITH SLIDERS
    /// sliders for RGB values
    @IBAction func didTapRedSlider(_ sender: UISlider) {
        colorPickerSlider.red = CGFloat(sender.value) / 255
        colorPickerSlider.setBackgroundColor(view: photosView, button: scrollViewLayoutButtons.colorPickerButton)
    }
    @IBAction func didTapGreenSlider(_ sender: UISlider) {
        colorPickerSlider.green = CGFloat(sender.value) / 255
        colorPickerSlider.setBackgroundColor(view: photosView, button: scrollViewLayoutButtons.colorPickerButton)
        
    }
    @IBAction func didTapBlueSlider(_ sender: UISlider) {
        colorPickerSlider.blue = CGFloat(sender.value) / 255
        colorPickerSlider.setBackgroundColor(view: photosView, button: scrollViewLayoutButtons.colorPickerButton)
    }
    
    /// Reset color sliders and background color to there initial values
    @IBAction func didTapResetColors() {
        colorPickerSlider.resetBackgroundColor(view: photosView, button: scrollViewLayoutButtons.colorPickerButton)
        colorPickerSlider.redSlider.value = Float(colorPickerSlider.redDefault * 255)
        colorPickerSlider.greenSlider.value = Float(colorPickerSlider.greenDefault * 255)
        colorPickerSlider.blueSlider.value = Float(colorPickerSlider.blueDefault * 255)
    }
    
    /// Close color sliders
    @IBAction func didTapCloseColorSliders() {
        colorPickerSlider.isHidden = true
    }
    
    /// show color sliders
    @IBAction func didTapColorPickerButton() {
        colorPickerSlider.isHidden = false
    }
    
    // MARK: - DRAG PHOTOSVIEW TO SHARE THE PHOTOS OR TRASH THEM
    /// set the layout buttons on the back to make the photosView pass over them
    private func layoutButtonsZPosition() {
        scrollViewLayoutButtons.layer.zPosition = -1
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
        let screenHight = UIScreen.main.bounds.height
        let screenWidth = UIScreen.main.bounds.width
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
    
    // MARK: - START THE APP
    private func startInstagrid() {
        scrollViewLayoutButtons.setLayoutButton(view: photosView, layout: .twoPhotosTop)
        colorPickerSlider.setBackgroundColor(view: photosView, button: scrollViewLayoutButtons.colorPickerButton)
        layoutButtonsZPosition()
    }
}
