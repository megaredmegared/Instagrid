
import UIKit

class PhotosView: UIView {
    
    @IBOutlet private var boutonTopLeft: PhotoButton!
    @IBOutlet private var boutonTopRight: UIButton!
    @IBOutlet private var boutonBottomLeft: UIButton!
    @IBOutlet private var boutonBottomRight: UIButton!
    //boutonTopLeft.layer.cornerRadius = 6
    
    enum Layout {
        case twoPhotosTop, twoPhotosBottom, fourPhotos, twoPhotos
    }
    
    var layout: Layout = .twoPhotosTop {
        didSet {
            setLayout(layout)
        }
    }
    
    private func setLayout(_ layout: Layout) {
        switch layout {
        case .twoPhotosTop :
            boutonTopRight.isHidden = false
            boutonBottomRight.isHidden = true
        case .twoPhotosBottom :
            boutonTopRight.isHidden = true
            boutonBottomRight.isHidden = false
        case .fourPhotos :
            boutonTopRight.isHidden = false
            boutonBottomRight.isHidden = false
        case .twoPhotos :
            boutonTopRight.isHidden = true
            boutonBottomRight.isHidden = true
        }
    }

 

    
}
