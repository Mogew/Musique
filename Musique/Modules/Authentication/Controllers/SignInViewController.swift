//
//  SignINViewController.swift
//  Musique
//
//  Created by Келлер Дмитрий on 12.06.2023.
//

import UIKit
import Firebase

//emailTextField.text = "test@reg.com"
//passwordTextField.text = "1234567"

final class SignInViewController: UIViewController {
    //MARK: - Property
    var presenter: SignInPresenterProtocol?
    
    // MARK: - Outlets
    
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "backgroundAuth")
        return imageView
    }()
    
    lazy var signInLabel: UILabel = {
        let label = UILabel()
        label.text = "SIGN IN"
        label.textColor = .mWhite
        label.font = UIFont.robotoMedium(ofSize: 39)
        return label
    }()
    //MARK: - EMAIL CONFIG
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.setLeftPaddingPoints(45)
        textField.leftViewMode = .always
        textField.placeholder = "E-Mail"
        textField.textColor = .white
        textField.autocapitalizationType = .none
        textField.backgroundColor = .clear
        return textField
    }()
    private let emailTextFieldImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage.init(systemName: "at")
        image.tintColor = .systemGray
        return image
    }()
    private let emailTextFieldImageLine: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "line")
        return image
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
    //MARK: - FORGOT button
    lazy var forgotPassButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Forgot Password ?", for: .normal)
        button.setTitleColor(.mWhite, for: .normal)
        button.titleLabel?.font = .montseratMedium(ofSize: 14)
        button.addTarget(nil, action: #selector(forgotPassButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Don't have an account?"
        label.textColor = .white
        label.font = .robotoBold(ofSize: 14)
        return label
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SIGN UP", for: .normal)
        button.setTitleColor(.mLime, for: .normal)
        button.titleLabel?.font = .robotoBold(ofSize: 14)
        button.addTarget(nil, action: #selector(signUpButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var signUpStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [signUpLabel, signUpButton])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 3
        return stackView
    }()
    
    let signInButton = UIButton(text: "SIGN IN", action: #selector(signInButtonTapped))
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setConstrains()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: view)
        if !emailTextField.frame.contains(touchLocation) && !passwordTextField.frame.contains(touchLocation) {
            view.endEditing(true)
        }
    }
    
    // MARK:- Private Methods
    @objc private func signInButtonTapped() {
        if let email = emailTextField.text, let password = passwordTextField.text {
            presenter?.signInUser(email: email, password: password)
        }
    }
    
    @objc private func signUpButtonTapped() {
        let userSignUpController = Builder.getSignUpModule()
        navigationController?.pushViewController(userSignUpController, animated: true)
    }
    
    @objc private func forgotPassButtonTapped() {
        let forgotPassViewController = Builder.getForgotPassModule()
        navigationController?.pushViewController(forgotPassViewController, animated: true)
    }
    
    //MARK: - Hierarchy
    private func setupHierarchy() {
        let views = [
            backgroundImageView,
            signInLabel,
            emailTextField,
            passwordTextField,
            forgotPassButton,
            signInButton,
            signUpStackView,
            emailTextFieldImageLine,
            passwordTextFieldImageLine,
            emailTextFieldImage,
            passwordTextFieldImage,
            toggleButton
        ]
        
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(view)
        }
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
            
            emailTextFieldImage.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor, constant: 10),
            emailTextFieldImage.centerYAnchor.constraint(equalTo: emailTextField.centerYAnchor),
            
            emailTextFieldImageLine.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 0),
            emailTextFieldImageLine.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            passwordTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 320),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextFieldImage.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor, constant: 10),
            passwordTextFieldImage.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            
            toggleButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: -10),
            toggleButton.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            
            passwordTextFieldImageLine.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 0),
            passwordTextFieldImageLine.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            forgotPassButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            forgotPassButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 203),
            forgotPassButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -42),
            
            signInButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 443),
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            signInButton.heightAnchor.constraint(equalToConstant: 46),
            signInButton.widthAnchor.constraint(equalToConstant: 295),
            
            signUpButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -36),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            signUpStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -36),
            
            
        ])
        
    }
}


extension SignInViewController: SignInViewProtocol {
    
    func failure(_ error: Error) {
        let alert = UIAlertController(title: "Warning!", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { [unowned self] _ in
            self.passwordTextField.text = ""
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    func success() {
        print("win")
        let searchViewController = TabBarController()
        navigationController?.pushViewController(searchViewController, animated: true)
    }
}

extension SignInViewController: UITextFieldDelegate{
    
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
