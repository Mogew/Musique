import UIKit

final class EditViewController: UIViewController {
    
    private var changePasswordButton = UIButton()
    private var backgroundView = UIView()
    private var avatarView = UIView()
    private var avatarImageView = UIImageView()
    private var editAvatarButton = UIButton()
    private var verticlaStackView = UIStackView()
    private var editUsernameButton = EditButton()
    private var editEmailButton = EditButton()
    private var editGenderButton = EditButton()
    private var editDateOfBirthButton = EditButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
    }
    
    //MARK: - Setup UI Elements
    
    private func setupViews() {
        view.backgroundColor = .mDarkBlue
        setupChangePasswordButton()
        setupBackgroundView()
        setupAvatarView()
        setupAvatarImageView()
        setupEditAvatarButton()
        setupVerticlaStackView()
        setupEditUsernameButton()
        setupEditEmailButton()
        setupEditGenderButton()
        setupEditDateOfBirthButton()
    }
    
    private func setupVerticlaStackView() {
        verticlaStackView.axis = .vertical
        verticlaStackView.alignment = .fill
        verticlaStackView.distribution = .fillEqually
        verticlaStackView.spacing = 22
    }
    
    private func setupEditUsernameButton() {
        editUsernameButton.setTitle1("Username")
        editUsernameButton.setTitle2("John Huston")
        editUsernameButton.addTarget(self, action: #selector(showEditUsernameAlert), for: .touchUpInside)
            }
    
    @objc private func showEditUsernameAlert() {
        let alert = UIAlertController(title: "Edit username",
                                      message: "Enter a new username",
                                      preferredStyle: .alert)
        alert.addTextField { field in
            field.placeholder = "Username"
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Safe", style: .default, handler: { _ in
            //read textfield value
        }))

        present(alert, animated: true)
    }
    
    private func setupEditEmailButton() {
        editEmailButton.setTitle1("Email")
        editEmailButton.setTitle2("Mufillluma@gmail.com")
        editEmailButton.addTarget(self, action: #selector(showEditEmailAlert), for: .touchUpInside)
    }
    
    @objc private func showEditEmailAlert() {
        let alert = UIAlertController(title: "Edit email",
                                      message: "Enter a new email",
                                      preferredStyle: .alert)
        alert.addTextField { field in
            field.placeholder = "Username"
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Safe", style: .default, handler: { _ in
            //read textfield value
        }))

        present(alert, animated: true)
    }
    
    private func setupEditDateOfBirthButton() {
        editDateOfBirthButton.setTitle1("Date of birth")
        editDateOfBirthButton.setTitle2("10/09/1995")
        editEmailButton.addTarget(self, action: #selector(showEditDateOfBirthAlert), for: .touchUpInside)
    }
    
    @objc private func showEditDateOfBirthAlert() {

    }
    
    private func setupEditGenderButton() {
        editGenderButton.setTitle1("Gender")
        editGenderButton.setTitle2("Male")
        editUsernameButton.addTarget(self, action: #selector(showGenderUsernameAlert), for: .touchUpInside)
    }
    
    @objc private func showGenderUsernameAlert() {
        
    }

    private func setupAvatarView() {
        avatarView.backgroundColor = .clear
    }
    
    private func setupEditAvatarButton() {
        editAvatarButton.setImage(UIImage(named: "editImageButtonImage.png"), for: .normal)
        editAvatarButton.layer.cornerRadius = 20
        editAvatarButton.clipsToBounds = true
        editAvatarButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    @objc func buttonTapped() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    private func setupChangePasswordButton() {
        changePasswordButton.setTitle("Change password", for: .normal)
        changePasswordButton.titleLabel?.font = .robotoMedium(ofSize: 14)
        changePasswordButton.setTitleColor(.mLime, for: .normal)
        changePasswordButton.backgroundColor = .clear
        changePasswordButton.addTarget(self, action: #selector(changePassButtonTapped), for: .touchUpInside)
    }
    
    private func setupBackgroundView() {
        backgroundView.backgroundColor = UIColor(red: 0.54, green: 0.57, blue: 0.66, alpha: 1)
        backgroundView.layer.cornerRadius = 12
        backgroundView.clipsToBounds = false
//        backgroundView.layer.shadowColor = UIColor.mWhite.cgColor
//        backgroundView.layer.shadowOpacity = 0.2
//        backgroundView.layer.shadowRadius = 4
    }
    
    private func setupAvatarImageView() {
        avatarImageView.image = UIImage(named: "baseAvatarImage.png")
        avatarImageView.layer.cornerRadius = 71
        avatarImageView.layer.borderWidth = 3
        avatarImageView.layer.borderColor = UIColor(red: 173, green: 176, blue: 192, alpha: 1).cgColor
        avatarImageView.clipsToBounds = true
    }
    
    
    //MARK: - Layout
    
    private func setConstraints() {
        addSubViews()
        makeConstraints()
    }
    
    @objc private func changePassButtonTapped() {
        let changePasswordVC = ChangePasswordViewController()
        changePasswordVC.hidesBottomBarWhenPushed = true
        self.navigationItem.hidesBackButton = false
        self.navigationController?.pushViewController(changePasswordVC, animated: true)
    }
    
    private func addSubViews() {
        view.addSubview(changePasswordButton)
        view.addSubview(backgroundView)
        backgroundView.addSubview(avatarView)
        avatarView.addSubview(avatarImageView)
        avatarView.addSubview(editAvatarButton)
        backgroundView.addSubview(verticlaStackView)
        verticlaStackView.addArrangedSubview(editUsernameButton)
        verticlaStackView.addArrangedSubview(editEmailButton)
        verticlaStackView.addArrangedSubview(editGenderButton)
        verticlaStackView.addArrangedSubview(editDateOfBirthButton)
    }
    
    private func makeConstraints() {
        
        changePasswordButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            changePasswordButton.heightAnchor.constraint(equalToConstant: 31),
            changePasswordButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -52),
            changePasswordButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 112),
            changePasswordButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -112)
        ])
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundView.bottomAnchor.constraint(equalTo: changePasswordButton.topAnchor, constant: -36),
            backgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 98),
            backgroundView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            backgroundView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24)
        ])
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            avatarView.heightAnchor.constraint(equalToConstant: 142),
            avatarView.widthAnchor.constraint(equalToConstant: 142),
            avatarView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            avatarView.centerYAnchor.constraint(equalTo: backgroundView.topAnchor)
        ])
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            avatarImageView.heightAnchor.constraint(equalToConstant: 142),
            avatarImageView.widthAnchor.constraint(equalToConstant: 142),
            avatarImageView.centerXAnchor.constraint(equalTo: avatarView.centerXAnchor),
            avatarImageView.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor)
        ])
        editAvatarButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            editAvatarButton.heightAnchor.constraint(equalToConstant: 40),
            editAvatarButton.widthAnchor.constraint(equalToConstant: 40),
            editAvatarButton.bottomAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 0),
            editAvatarButton.trailingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 0)
        ])
        verticlaStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            verticlaStackView.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 90),
            verticlaStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 15),
            verticlaStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -15),
            verticlaStackView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -88)
        ])
    }
}

// MARK: - UIImagePickerControllerDelegate
extension EditViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        avatarImageView.image = image
    }
}
