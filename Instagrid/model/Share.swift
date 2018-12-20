
import UIKit

class Share: UIViewController {
    
    /// transform a view in image with a specific width
    private func image(with view: UIView, scaledWidthTo width: CGFloat) -> UIImage? {
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
    func photo(of view: PhotosView, width: CGFloat) {
        /// check that the layout is full of photo
        if (view.buttonTopLeft.currentImage != UIImage(imageLiteralResourceName: "plusSign") || view.buttonTopLeft.isHidden == true) && (view.buttonTopRight.currentImage != UIImage(imageLiteralResourceName: "plusSign") || view.buttonTopRight.isHidden == true) && (view.buttonBottomLeft.currentImage != UIImage(imageLiteralResourceName: "plusSign") || view.buttonBottomLeft.isHidden == true) && (view.buttonBottomRight.currentImage != UIImage(imageLiteralResourceName: "plusSign") || view.buttonBottomRight.isHidden == true) {
            
            if self.image(with: view, scaledWidthTo: width) != nil {
                // construct the image to share
                let imageToShare = self.image(with: view, scaledWidthTo: width)!
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
}


