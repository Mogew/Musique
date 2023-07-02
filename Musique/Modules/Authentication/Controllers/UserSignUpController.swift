import UIKit

final class UserSignUpController: UIViewController {
    
    //MARK: - Property
    var presenter: UserSignUpPresenterProtocol!
    
    // MARK: - Outlets
    
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "backgroundSignUp")
        return imageView
    }()
    
    lazy var signInLabel: UILabel = {
        let label = UILabel()
        label.text = "SIGN UP"
        label.textColor = .mWhite
        label.font = UIFont.robotoMedium(ofSize: 39)
        return label
    }()
    
    //MARK: - NameTextField CONFIG
    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.setLeftPaddingPoints(45)
        textField.leftViewMode = .always
        textField.placeholder = "Name"
        textField.textColor = .white
        textField.autocapitalizationType = .none
        textField.backgroundColor = .clear
        return textField
    }()
    private let nameTextFieldImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage.init(systemName: "person.crop.circle")
        image.tintColor = .systemGray
        return image
    }()
    private let nameTextFieldImageLine: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "line")
        return image
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
    
    let signUpButton = UIButton(text: "Sign Up", action: #selector(signUpButtonTapped))
    
    // MARK:- LifeCycle
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
    @objc private func signUpButtonTapped() {
        if let userName = nameTextField.text,
           let email = emailTextField.text,
           let password = passwordTextField.text {
            presenter?.createUser(email: email, password: password, userName: userName)
        }
    }
    
    
    //MARK: - Hierarchy
    private func setupHierarchy() {
        let views = [
            backgroundImageView,
            signInLabel,
            nameTextField,
            emailTextField,
            passwordTextField,
            signUpButton,
            emailTextFieldImage,
            emailTextFieldImageLine,
            passwordTextFieldImage,
            toggleButton,
            passwordTextFieldImageLine,
            nameTextFieldImage,
            nameTextFieldImageLine
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
            
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            nameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 275),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            nameTextFieldImage.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor, constant: 10),
            nameTextFieldImage.centerYAnchor.constraint(equalTo: nameTextField.centerYAnchor),
            
            nameTextFieldImageLine.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 0),
            nameTextFieldImageLine.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            emailTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 346),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            emailTextFieldImage.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor, constant: 10),
            emailTextFieldImage.centerYAnchor.constraint(equalTo: emailTextField.centerYAnchor),
            
            emailTextFieldImageLine.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 0),
            emailTextFieldImageLine.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            passwordTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 417),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextFieldImage.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor, constant: 10),
            passwordTextFieldImage.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            
            toggleButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: -10),
            toggleButton.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            
            passwordTextFieldImageLine.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 0),
            passwordTextFieldImageLine.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            signUpButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 497),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            signUpButton.heightAnchor.constraint(equalToConstant: 46),
            signUpButton.widthAnchor.constraint(equalToConstant: 295)
        ])
    }
}

extension UserSignUpController: UserSignUpViewProtocol {
    func succses() {
        let searchViewController = TabBarController()
        navigationController?.pushViewController(searchViewController, animated: true)
        print("win")
    }
    
    func failure(_ error: Error) {
        let alert = UIAlertController(title: "Warning!", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { [unowned self] _ in
            self.passwordTextField.text = ""
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
}
extension UserSignUpController: UITextFieldDelegate {
    
}
