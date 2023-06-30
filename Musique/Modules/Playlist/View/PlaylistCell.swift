//
//  PlaylistCell.swift
//  Musique
//
//  Created by sidzhe on 26.06.2023.
//

import UIKit

class PlaylistCell: UITableViewCell {
    
    //MARK: - UI Elements
    
    private lazy var logoImage: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var songLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var artistLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setImage(Const.Images.point, for: .normal)
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var songStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 4
        return view
    }()
    
    
    //MARK: - Inits
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - SetupViews
    
    private func setupViews() {
        
        songStackView.addArrangedSubview(songLabel)
        songStackView.addArrangedSubview(artistLabel)
        
        contentView.addSubview(button)
        contentView.addSubview(songStackView)
        contentView.addSubview(logoImage)
        contentView.addSubview(numberLabel)
        
        numberLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.size.equalTo(30)
            make.centerY.equalToSuperview()
        }
        
        logoImage.snp.makeConstraints { make in
            make.left.equalTo(numberLabel.snp.right).inset(-6)
            make.size.equalTo(50)
            make.centerY.equalToSuperview()
        }
        
        songStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(logoImage.snp.right).inset(-20)
            make.right.equalToSuperview().inset(60)
        }
        
        button.snp.makeConstraints { make in
            make.size.equalTo(36)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
        }
        
    }
    
    //MARK: - Methods
    
    @objc private func tapButton() {
        
    }
    
    public func configure(number: String, name: String, song: String, imageLink: SearchTracks) {
        numberLabel.text = number
        artistLabel.text = name
        songLabel.text = song
        
        guard let url = URL(string: imageLink.artworkUrl100 ?? Const.Text.empty) else { return }
        logoImage.kf.setImage(with: url)
    }
}
