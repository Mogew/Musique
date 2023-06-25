import UIKit

extension UIButton {
    convenience init(text: String, textColor: UIColor = .mBlack, backgroundColor: UIColor = .mLime, action: Selector) {
        self.init(type: .system)
        self.setTitle(text, for: .normal)
        self.titleLabel?.font = .robotoBold(ofSize: 16)
        self.layer.cornerRadius = 4
        self.backgroundColor = backgroundColor
        self.tintColor = textColor
        self.addTarget(nil, action: action, for: .touchUpInside)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
