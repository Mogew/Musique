import UIKit

final class ProfileViewController: UIViewController {
    
    var presenter: ProfilePresenterProtocol?
    
    private let imageView = UIImageView(image: UIImage(named: "settings"))
    private var signOutButton = UIButton()
    private var avatarImageView = UIImageView()
    private var profileTableView = UITableView()
    private var libraryLabel = UILabel()
    
    private var model = ProfileSection(title: "Library", options: [
        ProfileModel(text: "My playlist", image: UIImage(named: "library_music")!,
                     rightImage: UIImage(systemName: "chevron.right"),
                     toggleIsHidden: true),
        ProfileModel(text: "Notification", image: UIImage(named: "notification")!,
                     rightImage: nil,
                     toggleIsHidden: false),
        ProfileModel(text: "Download", image: UIImage(named: "profileDownload")!,
                     rightImage: UIImage(systemName: "chevron.right"),
                     toggleIsHidden: true)
    ])
    
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        setupButton()
    }
    
    //MARK: - Setup UI Elements
    
    private func setupViews() {
        view.backgroundColor = .mDarkBlue
        setupSignOutButton()
        setupAvatarImageView()
        setupLibraryLabel()
        setupTableView()
    }
    
    private func setupTableView() {
        profileTableView.register(ProfileTableViewCell.self,
                                  forCellReuseIdentifier: ProfileTableViewCell.id)
        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileTableView.backgroundColor = .mDarkBlue
    }
    
    private func setupLibraryLabel() {
        libraryLabel.text = "Library"
        libraryLabel.font = .robotoBold(ofSize: 22)
        libraryLabel.textColor = .mWhite
    }
    
    private func setupAvatarImageView() {
        avatarImageView.image = UIImage(named: "Test Image")
        avatarImageView.contentMode = .scaleAspectFill
    }
    
    private func setupSignOutButton() {
        signOutButton.setTitle("SIGN OUT", for: .normal)
        signOutButton.setTitleColor(.mLime, for: .normal)
        signOutButton.titleLabel?.font = .robotoBold(ofSize: 22)
        signOutButton.backgroundColor = .mDarkBlue
        signOutButton.layer.borderWidth = 1
        signOutButton.layer.borderColor = UIColor.mLime.cgColor
        signOutButton.layer.cornerRadius = 4
        signOutButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    //MARK: - Layout
    
    private func setConstraints() {
        addSubViews()
        makeConstraints()
    }
    
    @objc private func buttonTapped() {
        FirebaseManager.shared.signOut {
            print("Sing Out")
            let startVC = SignInViewController()
            startVC.hidesBottomBarWhenPushed = true
            self.navigationItem.hidesBackButton = false
            self.navigationController?.pushViewController(startVC, animated: true)
        
        }
    }
    
    private func addSubViews() {
        view.addSubview(signOutButton)
        view.addSubview(avatarImageView)
        view.addSubview(libraryLabel)
        view.addSubview(profileTableView)
    }
    
    private func makeConstraints() {
        signOutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signOutButton.heightAnchor.constraint(equalToConstant: 46),
            signOutButton.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -38),
            signOutButton.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            signOutButton.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40)
        ])
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            avatarImageView.heightAnchor.constraint(equalToConstant: 80),
            avatarImageView.widthAnchor.constraint(equalToConstant: 80),
            avatarImageView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            avatarImageView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24)
        ])
        libraryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            libraryLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor,
                                              constant: 30),
            libraryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                  constant: 24),
            libraryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                   constant:-24),
        ])
        profileTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileTableView.topAnchor.constraint(
                equalTo: libraryLabel.bottomAnchor,constant: 10),
            profileTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                      constant: 24),
            profileTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                       constant: -24),
            profileTableView.bottomAnchor.constraint(equalTo: signOutButton.topAnchor,
                                                     constant: -20)
        ])
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = profileTableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.id, for: indexPath) as! ProfileTableViewCell
        cell.configureCell(with: model.options[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ProfileTableViewCell
        cell.selectedBackgroundView?.backgroundColor = .mDarkBlue
        UIView.animate(withDuration: 0.2, animations: {
            cell.transform = CGAffineTransform(scaleX: 0.99, y: 0.99)
        }, completion: { finished in
            UIView.animate(withDuration: 0.2) {
                cell.transform = .identity
            }
        })
        if !cell.rightToggle.isOn {
            cell.rightToggle.setOn(true, animated: true)
        } else {
            cell.rightToggle.setOn(false, animated: true)
        }
    }
}

extension ProfileViewController: ProfileViewProtocol {
    func success() {
        
    }
    func failure() {
        
    }
}


//MARK: - navBar button
extension ProfileViewController {
    
    private func showImage(_ show: Bool) {
        UIView.animate(withDuration: 0.4) {
            self.imageView.alpha = show ? 1.0 : 0.0
        }
    }
    
    private struct Constant {
        /// Image height/width for Large NavBar state
        static let ImageSizeForLargeState: CGFloat = 24
        /// Margin from right anchor of safe area to right anchor of Image
        static let ImageRightMargin: CGFloat = 16
        /// Margin from bottom anchor of NavBar to bottom anchor of Image for Large NavBar state
        static let ImageBottomMarginForLargeState: CGFloat = 12
        /// Margin from bottom anchor of NavBar to bottom anchor of Image for Small NavBar state
        static let ImageBottomMarginForSmallState: CGFloat = 6
        /// Image height/width for Small NavBar state
        static let ImageSizeForSmallState: CGFloat = 24
        /// Height of NavBar for Small state. Usually it's just 44
        static let NavBarHeightSmallState: CGFloat = 30
        /// Height of NavBar for Large state. Usually it's just 96.5 but if you have a custom font for the title, please make sure to edit this value since it changes the height for Large state of NavBar
        static let NavBarHeightLargeState: CGFloat = 70
    }
    
    private func setupButton() {
        // Initial setup for image for Large NavBar state since the the screen always has Large NavBar once it gets opened
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        
        navigationBar.addSubview(imageView)
        
        // setup constraints
        imageView.tintColor = .mWhite
        imageView.layer.cornerRadius = Constant.ImageSizeForLargeState / 2
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.rightAnchor.constraint(equalTo: navigationBar.rightAnchor, constant: -Constant.ImageRightMargin),
            imageView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -Constant.ImageBottomMarginForLargeState),
            imageView.heightAnchor.constraint(equalToConstant: Constant.ImageSizeForLargeState),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
        ])
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        navigationController?.pushViewController(EditViewController(), animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showImage(false)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showImage(true)
    }
}
