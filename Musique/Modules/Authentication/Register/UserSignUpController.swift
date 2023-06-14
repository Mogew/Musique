//
//  UserSignUpController.swift
//  Musique
//
//  Created by Келлер Дмитрий on 12.06.2023.
//

import UIKit
import Firebase

class UserSignUpController: UIViewController {

    // MARK: - Outlets
    
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "backgroundSignUp")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var signInLabel: UILabel = {
        let label = UILabel()
        label.text = "SIGN UP"
        label.textColor = .mWhite
        label.font = UIFont.robotoMedium(ofSize: 39)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var nameTextField: UITextField = {
        let textField = TextFieldBuilder()
            .setPlaceholder("Name")
            .build()
        return textField
    }()

    lazy var emailTextField: UITextField = {
        let textField = TextFieldBuilder()
            .setPlaceholder("Email")
            .build()
        return textField
    }()

    lazy var passwordTextField: UITextField = {
        let textField = TextFieldBuilder()
            .setPlaceholder("Password")
            .setIsSecureTextEntry(true)
            .build()
        return textField
    }()
  
    lazy var signInButton: UIButton = {
        let button = ButtonBuilder()
            .setTitle("SIGN IN")
            .setAction(self, action: #selector(signUpButtonTapped))
            .build()
        return button
    }()
 
  
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHierarchy()
        setConstrains()
    }
    
    // MARK:- Private Methods
    @objc private func signUpButtonTapped() {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { [unowned self] authResult, error in
                if let e = error {
                    let alert = UIAlertController(title: "Invalid format", message: e.localizedDescription, preferredStyle: .alert)
                    
                    let OkAction = UIAlertAction(title: "OK", style: .default) { [unowned self] _ in
                        self.passwordTextField.text = ""
                    }
                        alert.addAction(OkAction)
                        present(alert, animated: true)
                        return
                    } else {
                            //  нужно добавить метод
                    }
                }
            }
        }
   
        
    
    //MARK: - Hierarchy
    private func setupHierarchy() {
        view.addSubview(backgroundImageView)
        view.addSubview(signInLabel)
        view.addSubview(nameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signInButton)
    }
    
    //MARK: - Constraints
    private func  setConstrains() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            signInLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 103),
            signInLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            nameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 275),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            emailTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 346),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            passwordTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 417),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            signInButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 497),
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            signInButton.heightAnchor.constraint(equalToConstant: 46),
            signInButton.widthAnchor.constraint(equalToConstant: 295)
        ])
        
    }
    
}
