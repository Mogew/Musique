//
//  ChangePasswordViewController.swift
//  Musique
//
//  Created by Келлер Дмитрий on 17.06.2023.
//

import UIKit
import Firebase

final class ChangePasswordViewController: UIViewController {
    
    var presenter: ChangePassPresenterProtocol?
    var code: String?
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Forgot Password?"
        label.textColor = .mWhite
        label.font = UIFont.robotoMedium(ofSize: 24)
        return label
    }()
    
    lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "if you need help resetting your password, we can help by sending you a link to reset it"
        label.textColor = .white
        label.font = .montseratSemiBold(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    //MARK: - PASSWORD CONFIG
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.leftViewMode = .always
        textField.rightViewMode = .always
        textField.delegate = self
        textField.setRightPaddingPoints(15)
        textField.setLeftPaddingPoints(45)
        textField.placeholder = "Password"
        textField.textColor = .white
        textField.autocapitalizationType = .none
        return textField
    }()
    private let passwordTextFieldImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage.init(systemName: "lock.fill")
        image.tintColor = .systemGray
        return image
    }()
    private let passwordTextFieldImageLine: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "line")
        return image
    }()
    //MARK: -PASSWORD Secure entry button config
    
    private lazy var toggleButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage.init(systemName: "eye"), for: .normal)
        button.tintColor = .systemGray
        button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        return button
    }()
    private var toggleObserver = true
    @objc func togglePasswordVisibility() {
        passwordTextField.isSecureTextEntry.toggle()
        if toggleObserver {
            toggleButton.setBackgroundImage(UIImage.init(systemName: "eye.slash"), for: .normal)
            toggleButton.tintColor = .systemGray
            toggleObserver = false
        } else {
            toggleButton.setBackgroundImage(UIImage.init(systemName: "eye"), for: .normal)
            toggleButton.tintColor = .systemGray
            toggleObserver = true
        }
    }
    //MARK: - CONFIRM PASSWORD Config
    lazy var confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.leftViewMode = .always
        textField.rightViewMode = .always
        textField.delegate = self
        textField.setRightPaddingPoints(15)
        textField.setLeftPaddingPoints(45)
        textField.placeholder = "Confirm Password"
        textField.textColor = .white
        textField.autocapitalizationType = .none
        return textField
    }()
    private let confirmPasswordTextFieldImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage.init(systemName: "lock.fill")
        image.tintColor = .systemGray
        return image
    }()
    private let confirmPasswordTextFieldImageLine: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "line")
        return image
    }()
    //MARK: - CONFIRM PASSWORD Secure entry button config
    
    private lazy var confirmToggleButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage.init(systemName: "eye"), for: .normal)
        button.tintColor = .systemGray
        button.addTarget(self, action: #selector(confirmTogglePasswordVisibility), for: .touchUpInside)
        return button
    }()
    private var confirmToggleObserver = true
    @objc func confirmTogglePasswordVisibility() {
        confirmPasswordTextField.isSecureTextEntry.toggle()
        if confirmToggleObserver {
            confirmToggleButton.setBackgroundImage(UIImage.init(systemName: "eye.slash"), for: .normal)
            confirmToggleButton.tintColor = .systemGray
            confirmToggleObserver = false
        } else {
            confirmToggleButton.setBackgroundImage(UIImage.init(systemName: "eye"), for: .normal)
            confirmToggleButton.tintColor = .systemGray
            confirmToggleObserver = true
        }
    }
    
    let changePassButton = UIButton(text: "CHANGE PASSWORD", action: #selector(changePassButtonTapped))
    
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupHierarchy()
        setConstrains()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: view)
        if !passwordTextField.frame.contains(touchLocation)
            && !confirmPasswordTextField.frame.contains(touchLocation)  {
            view.endEditing(true)
        }
    }
    
    // MARK:- Private Methods
    
    @objc private func changePassButtonTapped() {
        if let newPassword = passwordTextField.text, let confirmPassword = confirmPasswordTextField.text {
            if newPassword == confirmPassword {
                print("win")
                presenter?.updatePassword(password: newPassword)
                self.dismiss(animated: true)
            }
        }
    }
    
    //MARK: - Hierarchy
    private func setupHierarchy() {
        let views = [
            titleLabel,
            infoLabel,
            passwordTextField,
            confirmPasswordTextField,
            changePassButton,
            passwordTextFieldImage,
            toggleButton,
            passwordTextFieldImageLine,
            confirmPasswordTextField,
            confirmPasswordTextFieldImage,
            confirmPasswordTextFieldImageLine,
            confirmToggleButton
        ]
        
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(view)
        }
    }
    
    //MARK: - Constraints
    private func  setConstrains() {
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 112),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            
            infoLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 173),
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -101),
            infoLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -567),
            
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            passwordTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 346),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextFieldImage.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor, constant: 10),
            passwordTextFieldImage.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            
            toggleButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: -10),
            toggleButton.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            
            passwordTextFieldImageLine.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 0),
            passwordTextFieldImageLine.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            confirmPasswordTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 417),
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            confirmPasswordTextFieldImage.leadingAnchor.constraint(equalTo: confirmPasswordTextField.leadingAnchor, constant: 10),
            confirmPasswordTextFieldImage.centerYAnchor.constraint(equalTo: confirmPasswordTextField.centerYAnchor),
            
            confirmPasswordTextFieldImageLine.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 0),
            confirmPasswordTextFieldImageLine.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            confirmToggleButton.trailingAnchor.constraint(equalTo: confirmPasswordTextField.trailingAnchor, constant: -10),
            confirmToggleButton.centerYAnchor.constraint(equalTo: confirmPasswordTextField.centerYAnchor),
            
            changePassButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 60),
            changePassButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            changePassButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            changePassButton.heightAnchor.constraint(equalToConstant: 46),
            changePassButton.widthAnchor.constraint(equalToConstant: 284),
            
        ])
    }
}

extension ChangePasswordViewController: ChangePassViewProtocol {
    func success() {
        print("Password changed successfully")
        
        let alert = UIAlertController(title: "Password changed", message: "Your password has been successfully changed", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func failure(_ error: Error) {
        print("Error changing password: \(error.localizedDescription)")
        
        let alert = UIAlertController(title: "Passwords don't match", message: "Please make sure the new password and confirm password fields match", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension ChangePasswordViewController: UITextFieldDelegate {
    
}
