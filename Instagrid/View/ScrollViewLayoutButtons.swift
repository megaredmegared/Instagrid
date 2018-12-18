 
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
        
        let layoutButtons: [UIButton] = [twoPhotosTopButton, twoPhotosBottomButton, fourPhotosButton, twoPhotosButton, twoPhotosVerticalButton, twoPhotosLeftButton, twoPhotosRightButton, onePhotoButton]
        
        var button: UIButton {
            switch layout {
            case .twoPhotosTop :
                return layoutButtons[0]
            case .twoPhotosBottom :
                return layoutButtons[1]
            case .fourPhotos :
                return layoutButtons[2]
            case .twoPhotos :
                return layoutButtons[3]
            case .twoPhotosVertical :
                return layoutButtons[4]
            case .twoPhotoLeft :
                return layoutButtons[5]
            case .twoPhotoRight :
                return layoutButtons[6]
            case .onePhoto :
                return layoutButtons[7]
            }
        }
        
        /// reset all buttons checkmark image
        for i in layoutButtons {
            i.setImage(nil, for: .normal)
        }
        
        /// set the button selected with a checkmark
        button.setImage(#imageLiteral(resourceName: "photo check"), for: .highlighted)
        button.setImage(#imageLiteral(resourceName: "photo check"), for: .normal)
    }
    
 }
