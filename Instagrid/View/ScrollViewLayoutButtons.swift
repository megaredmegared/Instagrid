 
 import UIKit
 
 /// buttons for selecting a layout and the layout background color
 class ScrollViewLayoutButtons: UIScrollView {
    
    @IBOutlet weak var colorPickerButton: UIButton!
    @IBOutlet weak var twoPhotosTopButton: UIButton!
    @IBOutlet weak var twoPhotosBottomButton: UIButton!
    @IBOutlet weak var fourPhotosButton: UIButton!
    @IBOutlet weak var twoPhotosButton: UIButton!
    @IBOutlet weak var twoPhotosVerticalButton: UIButton!
    @IBOutlet weak var twoPhotosLeftButton: UIButton!
    @IBOutlet weak var twoPhotosRightButton: UIButton!
    @IBOutlet weak var onePhotoButton: UIButton!
    
    /// slider could work even if we are touching a button
    override func touchesShouldCancel(in view: UIView) -> Bool {
        if view is UIControl
            && !(view is UITextInput)
            && !(view is UISlider)
            && !(view is UISwitch) {
            return true
        }
        return super.touchesShouldCancel(in: view)
    }
    
    /// sync photo layout and the corresponding button
    func setLayoutButton(view: PhotosView, layout: Layout) {
        
        view.layout = layout
        
        let layoutButtons: [Layout: UIButton] = [.twoPhotosTop: twoPhotosTopButton, .twoPhotosBottom: twoPhotosBottomButton, .fourPhotos: fourPhotosButton, .twoPhotos: twoPhotosButton, .twoPhotosVertical: twoPhotosVerticalButton, .twoPhotoLeft: twoPhotosLeftButton, .twoPhotoRight: twoPhotosRightButton, .onePhoto: onePhotoButton]
        
        var button: UIButton = layoutButtons[.twoPhotoLeft]!
        
        if layoutButtons[layout] != nil {
            button = layoutButtons[layout]!
        }
        
        /// reset all buttons checkmarks images
        for i in layoutButtons.values {
            i.setImage(nil, for: .normal)
        }
        
        /// set the button selected with a checkmark
        button.setImage(#imageLiteral(resourceName: "photo check"), for: .highlighted)
        button.setImage(#imageLiteral(resourceName: "photo check"), for: .normal)
    }
 }
