
import UIKit

/// Settings for the layouts of photos

class PhotosView: UIView {
    
    @IBOutlet private var boutonTopLeft: PhotoButton!
    @IBOutlet private var boutonTopRight: PhotoButton!
    @IBOutlet private var boutonBottomLeft: PhotoButton!
    @IBOutlet private var boutonBottomRight: PhotoButton!
    
    
    /// Shadow under the frame of the photo layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        super.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        super.layer.shadowOpacity = 0.5
        super.layer.shadowOffset = CGSize(width: 0, height: 2)
        super.layer.shadowRadius = 4
    }
    
    /// Every possible photos layouts cases
    
    enum Layout {
        case twoPhotosTop, twoPhotosBottom, fourPhotos, twoPhotos
    }
    
    var layout: Layout = .twoPhotosTop {
        didSet {
            setLayout(layout)
        }
    }
    
    /// Layouts settings
    
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
    
    func getPhotoFromLibrary() {
        
    }
    
    func loadPhotos() {
        // boutonTopLeft.backgroundImage(for: <#T##UIControl.State#>)
    }
 

    
}
