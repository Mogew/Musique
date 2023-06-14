//
//  AccountViewController.swift
//  Musique
//
//  Created by Келлер Дмитрий on 12.06.2023.
//

import UIKit
import Firebase

class AccountViewController: UIViewController {
    
    // MARK: - Outlets
    
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "backgroundAuth")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var signInLabel: UILabel = {
        let label = UILabel()
        label.text = "SIGN IN"
        label.textColor = .mWhite
        label.font = UIFont.robotoMedium(ofSize: 39)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        let button = UIButton()
        button.setTitle("SIGN IN", for: .normal)
        button.setTitleColor(.mGray, for: .normal)
        button.backgroundColor = .mLime
        button.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var signUpButton: UIButton = {
        let button = ButtonBuilder()
            .setTitle("SIGN UP")
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
    @objc private func signInButtonTapped() {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                if let e = error {
                    let alert = UIAlertController(title: "Warning!", message: e.localizedDescription, preferredStyle: .alert)
                    
                    let OkAction = UIAlertAction(title: "OK", style: .default) { [unowned self] _ in
                        self?.passwordTextField.text = ""
                    }
                    alert.addAction(OkAction)
                    self?.present(alert, animated: true)
                    return
                } else {
                    //Navigate to the ChatVController
                 //   self?.performSegue(withIdentifier: K.loginSegue, sender: self)
                }
            }
        }
    }

    
    
    @objc private func signUpButtonTapped() {
        let userSignUpController = UserSignUpController()
        navigationController?.pushViewController(userSignUpController, animated: true)
    }
    
    //MARK: - Hierarchy
    private func setupHierarchy() {
        view.addSubview(backgroundImageView)
        view.addSubview(signInLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signInButton)
        view.addSubview(signUpButton)
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
            
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            emailTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 249),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            passwordTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 320),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            signInButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 443),
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            signInButton.heightAnchor.constraint(equalToConstant: 46),
            signInButton.widthAnchor.constraint(equalToConstant: 295),
            
            signUpButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -36),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
          
        ])
        
    }
    
}
