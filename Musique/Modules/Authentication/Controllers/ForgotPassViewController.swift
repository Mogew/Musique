//
//  ForgotPassViewController.swift
//  Musique
//
//  Created by Келлер Дмитрий on 16.06.2023.
//

import UIKit
import Firebase

final class ForgotPassViewController: UIViewController {
    
    var presenter: ForgotPassPresenterProtocol?
    
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
    
    let sentButton = UIButton(text: "SENT", action: #selector(sentButtonTapped))
    
    
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
        if !emailTextField.frame.contains(touchLocation) {
            view.endEditing(true)
        }
    }
    
    // MARK:- Private Methods
    @objc private func sentButtonTapped() {
        if let email = emailTextField.text, !email.isEmpty {
            presenter?.sendPasswordReset(email: email)
        }
    }
    //MARK: - Hierarchy
    private func setupHierarchy() {
        let views = [
            titleLabel,
            infoLabel,
            emailTextField,
            sentButton,
            emailTextFieldImage,
            emailTextFieldImageLine
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
            
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            emailTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 369),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            emailTextFieldImage.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor, constant: 10),
            emailTextFieldImage.centerYAnchor.constraint(equalTo: emailTextField.centerYAnchor),
            
            emailTextFieldImageLine.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 0),
            emailTextFieldImageLine.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            sentButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 448),
            sentButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            sentButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            sentButton.heightAnchor.constraint(equalToConstant: 46),
            sentButton.widthAnchor.constraint(equalToConstant: 295),
            
        ])
        
    }
}

extension ForgotPassViewController: ForgotPassViewProtocol {
    func success() {
        let changePassViewController = ChangePasswordViewController()
        self.navigationController?.pushViewController(changePassViewController, animated: true)
        print("win")
    }
    
    func failure(_ error: Error) {
        print("Error fetching sign-in methods: \(error.localizedDescription)")
        
        let alert = UIAlertController(title: "User not registered", message: "Please register first", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
}

extension ForgotPassViewController: UITextFieldDelegate{
    
}



