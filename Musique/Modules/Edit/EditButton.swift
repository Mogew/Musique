import UIKit

final class EditButton: UIButton {
    
    let titleLabel1 = UILabel()
    let titleLabel2 = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    private func setupButton() {
                
            titleLabel1.textAlignment = .left
            titleLabel1.font = .robotoRegular(ofSize: 14)
            titleLabel1.textColor = .mGray
            
            titleLabel2.textAlignment = .right
            titleLabel2.font = .robotoMedium(ofSize: 16)
            titleLabel2.textColor = .mWhite
        
            addSubview(titleLabel1)
            addSubview(titleLabel2)
            
            titleLabel1.translatesAutoresizingMaskIntoConstraints = false
            titleLabel2.translatesAutoresizingMaskIntoConstraints = false
        
            NSLayoutConstraint.activate([
                titleLabel1.widthAnchor.constraint(equalToConstant: 78),
                titleLabel1.centerYAnchor.constraint(equalTo: centerYAnchor),
                titleLabel1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0.75),
                titleLabel2.centerYAnchor.constraint(equalTo: centerYAnchor),
                titleLabel2.leadingAnchor.constraint(equalTo: titleLabel1.trailingAnchor, constant: 50),
                titleLabel2.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -0.75)
            ])
        }
        
        func setTitle1(_ title: String) {
            titleLabel1.text = title
        }
        
        func setTitle2(_ title: String) {
            titleLabel2.text = title
        }
    }
