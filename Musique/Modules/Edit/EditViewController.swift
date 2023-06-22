//
//  EditViewController.swift
//  Musique
//
//  Created by Ольга Шовгенева on 16.06.2023.
//

import UIKit

class EditViewController: UIViewController {
    
    private var changePasswordButton = UIButton()
    private var backgroundView = UIView()
    private var avatarView = UIView()
    private var avatarImageView = UIImageView()
    private var editAvatarButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
    }
    
    //MARK: - Setup UI Elements
    
    private func setupViews() {
        view.backgroundColor = .mBlack
        setupChangePasswordButton()
        setupBackgroundView()
        setupAvatarView()
        setupAvatarImageView()
        setupEditAvatarButton()
    }
    
    private func setupAvatarView() {
        avatarView.backgroundColor = .clear
    }
    
    private func setupEditAvatarButton() {
        editAvatarButton.setImage(UIImage(named: "editImageButtonImage.png"), for: .normal)
        editAvatarButton.layer.cornerRadius = 20
        editAvatarButton.clipsToBounds = true
    }
    
    private func setupChangePasswordButton() {
        changePasswordButton.setTitle("Change password", for: .normal)
        changePasswordButton.titleLabel?.font = .robotoMedium(ofSize: 14)
        changePasswordButton.setTitleColor(.mLime, for: .normal)
        changePasswordButton.backgroundColor = .clear
    }
    
    private func setupBackgroundView() {
        backgroundView.backgroundColor = .mGray
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
        avatarImageView.layer.borderColor = UIColor.systemGray.cgColor // выбрать правильный цвет
        avatarImageView.clipsToBounds = true
    }
    //MARK: - Layout
    
    private func setConstraints() {
        addSubViews()
        makeConstraints()
    }
    
    private func addSubViews() {
        view.addSubview(changePasswordButton)
        view.addSubview(backgroundView)
        backgroundView.addSubview(avatarView)
        avatarView.addSubview(avatarImageView)
        avatarView.addSubview(editAvatarButton)
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
    }
}
