import UIKit

extension UIButton {
    convenience init(text: String, textColor: UIColor, backgroundColor: UIColor) {
        self.init(type: .system)
        self.setTitle(text, for: .normal)
        self.titleLabel?.font = .robotoBold(ofSize: 16)
        self.layer.cornerRadius = 4
        self.backgroundColor = backgroundColor
        self.tintColor = textColor
    }
}
