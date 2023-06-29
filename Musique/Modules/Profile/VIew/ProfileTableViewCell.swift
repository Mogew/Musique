import UIKit

class ProfileTableViewCell: UITableViewCell {

    static let id = "profileCell"
    
    private let optionTextLabel: UILabel = {
        let label = UILabel()
        label.font = .robotoRegular(ofSize: 14)
        label.textColor = .mWhite
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let leftImageView: UIImageView = {
        let image = UIImageView()
        image.tintColor = .mWhite
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private let rightImage: UIImageView = {
        let image = UIImageView()
        image.tintColor = .mGray
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    let rightToggle: UISwitch = {
        let rSwitch = UISwitch()
        rSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        return rSwitch
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
        self.backgroundColor = .mDarkBlue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with model: ProfileModel){
        self.rightToggle.isHidden = model.toggleIsHidden
        self.rightImage.image = model.rightImage
        self.leftImageView.image = model.image
        self.optionTextLabel.text = model.text
    }
    
    private func setLayout() {
        addSubview(optionTextLabel)
        addSubview(leftImageView)
        addSubview(rightImage)
        addSubview(rightToggle)
        
        NSLayoutConstraint.activate([
            //image
            leftImageView.heightAnchor.constraint(equalToConstant: 24),
            leftImageView.widthAnchor.constraint(equalToConstant: 24),
            leftImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            leftImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            //label
            optionTextLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            optionTextLabel.leadingAnchor.constraint(
                equalTo: leftImageView.trailingAnchor, constant: 20),
            //button
            rightImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            rightImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            rightImage.heightAnchor.constraint(equalToConstant: 24),
            rightImage.widthAnchor.constraint(lessThanOrEqualToConstant: 32),
            // toggle
            rightToggle.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            rightToggle.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                 constant: -10),
            rightToggle.heightAnchor.constraint(equalToConstant: 30),
            rightToggle.widthAnchor.constraint(lessThanOrEqualToConstant: 100)
            
        ])
    }
}
