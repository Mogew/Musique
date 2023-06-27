//
//  ProfileViewController.swift
//  Musique
//
//  Created by Ольга Шовгенева on 23.06.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private var signOutButton = UIButton()
    private var avatarImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
    }
    
    //MARK: - Setup UI Elements
    
    private func setupViews() {
        view.backgroundColor = .mDarkBlue
        setupSignOutButton()
        setupAvatarImageView()
    }
    
    private func setupAvatarImageView() {
        avatarImageView.image = UIImage(named: "baseAvatarImage.png")
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
    }
    
    //MARK: - Layout
    
    private func setConstraints() {
        addSubViews()
        makeConstraints()
    }
    
    private func addSubViews() {
        view.addSubview(signOutButton)
        view.addSubview(avatarImageView)
    }
    
    private func makeConstraints() {
        signOutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signOutButton.heightAnchor.constraint(equalToConstant: 46),
            signOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -38),
            signOutButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            signOutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40)
        ])
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            avatarImageView.heightAnchor.constraint(equalToConstant: 100),
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            avatarImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            avatarImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -272)
        ])
    }
}
