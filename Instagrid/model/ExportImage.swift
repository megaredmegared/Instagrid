
import UIKit

class ExportImage {
    
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

}
