//
//  TextFieldBuilder.swift
//  Musique
//
//  Created by Келлер Дмитрий on 14.06.2023.
//

import UIKit

class TextFieldBuilder {
    
    private var placeholder: String?
    private var isSecureTextEntry: Bool = false
    private var borderStyle: UITextField.BorderStyle = .roundedRect
    
    func setPlaceholder(_ placeholder: String) -> TextFieldBuilder {
        self.placeholder = placeholder
        return self
    }
    
    func setIsSecureTextEntry(_ isSecureTextEntry: Bool) -> TextFieldBuilder {
        self.isSecureTextEntry = isSecureTextEntry
        return self
    }
    
    func setBorderStyle(_ borderStyle: UITextField.BorderStyle) -> TextFieldBuilder {
        self.borderStyle = borderStyle
        return self
    }
    
    func build() -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.isSecureTextEntry = isSecureTextEntry
        textField.borderStyle = borderStyle
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
}
