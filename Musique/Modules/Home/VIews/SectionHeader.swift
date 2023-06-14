import UIKit

class SectionHeaderView: UICollectionReusableView {
    static let id = "SectionHeaderView"
    let title = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpTitle()
        customizeElement()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has been implemented")
    }
}

extension SectionHeaderView {
    
    private func customizeElement() {
        title.textColor = UIColor.mWhite
        title.font = .systemFont(ofSize: 18)
    }
    
    private func setUpTitle() {
        addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor),
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            title.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            title.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
