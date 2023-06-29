//
//  ProfileButton.swift
//  Musique
//
//  Created by Ольга Шовгенева on 24.06.2023.
//

import UIKit

class ProfileButton: UIButton {
    let leftImage = UIImage()
    let titleLabel1 = UILabel()
    let rightImage = UIImage()
    
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
        
            addSubview(titleLabel1)
            
            titleLabel1.translatesAutoresizingMaskIntoConstraints = false
        
            NSLayoutConstraint.activate([
                titleLabel1.widthAnchor.constraint(equalToConstant: 78),
                titleLabel1.centerYAnchor.constraint(equalTo: centerYAnchor),
                titleLabel1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0.75),
            ])
        }
        
        func setTitle1(_ title: String) {
            titleLabel1.text = title
        }
        
    }

