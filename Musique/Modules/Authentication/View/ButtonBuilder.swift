//
//  ButtonBuilder.swift
//  Musique
//
//  Created by Келлер Дмитрий on 14.06.2023.
//

import UIKit

import UIKit

class ButtonBuilder {
    private var title: String?
    private var target: Any?
    private var action: Selector!
    
    func setTitle(_ title: String) -> ButtonBuilder {
        self.title = title
        return self
    }
    
    func setAction(_ target: Any?, action: Selector) -> ButtonBuilder {
        self.target = target
        self.action = action
        return self
    }
    
    func build() -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}
