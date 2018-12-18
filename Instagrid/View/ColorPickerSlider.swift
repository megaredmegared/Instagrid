
import UIKit

/// color picker to set color of photoView background and colorpicker button color
class ColorPickerSlider: UIView {
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    /// Default values for the layout background color
    let redDefault: CGFloat = 4 / 255
    let greenDefault: CGFloat = 101 / 255
    let blueDefault: CGFloat = 154 / 255
    let aplhaDefault: CGFloat = 1
    
    /// starting values for the layout background color
    lazy var red: CGFloat = redDefault
    lazy var green: CGFloat = greenDefault
    lazy var blue: CGFloat = blueDefault
    lazy var alphaChannel: CGFloat = aplhaDefault
    
    /// set and sync the background color RGB values with the sliders values
    func setBackgroundColor(view: PhotosView, button: UIButton) {
        view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: alphaChannel)
        button.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: alphaChannel)
    }
    
    /// reset layout background color to default values
    func resetBackgroundColor(view: PhotosView, button: UIButton) {
        view.backgroundColor = UIColor(red: redDefault, green: greenDefault, blue: blueDefault, alpha: aplhaDefault)
        button.backgroundColor = UIColor(red: redDefault, green: greenDefault, blue: blueDefault, alpha: aplhaDefault)
    }
}
