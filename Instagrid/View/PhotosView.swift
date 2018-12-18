
import UIKit

/// Settings for the layouts of photos

class PhotosView: UIView {
    
    @IBOutlet var buttonTopLeft: PhotoButton!
    @IBOutlet var buttonTopRight: PhotoButton!
    @IBOutlet var buttonBottomLeft: PhotoButton!
    @IBOutlet var buttonBottomRight: PhotoButton!
    @IBOutlet private var maintStackView: UIStackView!
    @IBOutlet private var firstSubStackView: UIStackView!
    @IBOutlet private var secondSubStackView: UIStackView!
    
    var layout: Layout = .twoPhotosTop {
        didSet {
            setLayout(layout)
        }
    }
    
    // MARK: - Shadow under the frame of the photo layout
    
    /// Shadow under the frame of the photo layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        super.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        super.layer.shadowOpacity = 0.5
        super.layer.shadowOffset = CGSize(width: 0, height: 2)
        super.layer.shadowRadius = 4
        super.layer.zPosition = 1
    }
    
    // MARK: - Layouts settings
    
    /// Layouts settings
    
    private func setLayout(_ layout: Layout) {
        switch layout {
        case .twoPhotosTop :
            buttonTopRight.isHidden = false
            buttonBottomRight.isHidden = true
            buttonBottomLeft.isHidden = false
            maintStackView.axis = .vertical
            firstSubStackView.axis = .horizontal
            secondSubStackView.axis = .horizontal
            secondSubStackView.isHidden = false
        case .twoPhotosBottom :
            buttonTopRight.isHidden = true
            buttonBottomRight.isHidden = false
            buttonBottomLeft.isHidden = false
            maintStackView.axis = .vertical
            firstSubStackView.axis = .horizontal
            secondSubStackView.axis = .horizontal
            secondSubStackView.isHidden = false
        case .fourPhotos :
            buttonTopRight.isHidden = false
            buttonBottomRight.isHidden = false
            buttonBottomLeft.isHidden = false
            maintStackView.axis = .vertical
            firstSubStackView.axis = .horizontal
            secondSubStackView.axis = .horizontal
            secondSubStackView.isHidden = false
        case .twoPhotos :
            buttonTopRight.isHidden = true
            buttonBottomRight.isHidden = true
            buttonBottomLeft.isHidden = false
            maintStackView.axis = .vertical
            firstSubStackView.axis = .horizontal
            secondSubStackView.axis = .horizontal
            secondSubStackView.isHidden = false
        case .twoPhotoLeft :
            buttonTopRight.isHidden = false
            buttonBottomRight.isHidden = true
            buttonBottomLeft.isHidden = false
            maintStackView.axis = .horizontal
            firstSubStackView.axis = .vertical
            secondSubStackView.axis = .vertical
            secondSubStackView.isHidden = false
        case .twoPhotoRight :
            buttonTopRight.isHidden = true
            buttonBottomRight.isHidden = false
            buttonBottomLeft.isHidden = false
            maintStackView.axis = .horizontal
            firstSubStackView.axis = .vertical
            secondSubStackView.axis = .vertical
            secondSubStackView.isHidden = false
        case .onePhoto :
            buttonTopRight.isHidden = true
            buttonBottomRight.isHidden = true
            buttonBottomLeft.isHidden = true
            maintStackView.axis = .vertical
            firstSubStackView.axis = .horizontal
            secondSubStackView.axis = .horizontal
            secondSubStackView.isHidden = true
        case .twoPhotosVertical :
            buttonTopRight.isHidden = false
            buttonBottomRight.isHidden = true
            buttonBottomLeft.isHidden = true
            maintStackView.axis = .vertical
            firstSubStackView.axis = .horizontal
            secondSubStackView.axis = .horizontal
            secondSubStackView.isHidden = true
        }
    }
}
