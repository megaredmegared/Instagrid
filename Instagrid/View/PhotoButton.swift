
import UIKit

class PhotoButton: UIButton {
    
    /// Rounded corner for the photos    
    override func layoutSubviews() {
        super.layoutSubviews()
        super.layer.cornerRadius = 6
    }

}
