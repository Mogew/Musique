import UIKit

final class SectionHeaderView: UICollectionReusableView {
    static let id = "SectionHeaderView"
    let title = UILabel()
    let viewAllLabel = UILabel()
    
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
        title.font = .robotoMedium(ofSize: 22)
        viewAllLabel.textColor = .mWhite
        viewAllLabel.font = .robotoRegular(ofSize: 14)
        viewAllLabel.textAlignment = .right
        viewAllLabel.text = "View all"
    }
    
    private func setUpTitle() {
        addSubview(title)
        addSubview(viewAllLabel)
        viewAllLabel.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor),
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            title.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            title.trailingAnchor.constraint(equalTo: viewAllLabel.leadingAnchor),
            viewAllLabel.topAnchor.constraint(equalTo: self.topAnchor),
            viewAllLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            viewAllLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
