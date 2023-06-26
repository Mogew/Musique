//
//  MiniPlayerViewController.swift
//  Musique
//
//  Created by sidzhe on 25.06.2023.
//

import UIKit
import SnapKit

class MiniPlayerView: UIView {
    
    //MARK: - Properties
        
    private lazy var logoImage: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 15
        view.image = UIImage(systemName: "swift")
        return view
    }()
    
    private lazy var songName: UILabel = {
        let label = UILabel()
        label.text = "name name"
        label.textColor = .black
        return label
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "EllipsePlay"), for: .normal)
        button.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(tapPlay), for: .touchUpInside)
        return button
    }()
    
    private lazy var forwardButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "EllipsePlay"), for: .normal)
        button.setImage(UIImage(systemName: "forward.fill"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    private func setupViews() {        
        backgroundColor = .mLime
        
        addSubview(songName)
        addSubview(logoImage)
        addSubview(playButton)
        addSubview(forwardButton)
        
        logoImage.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(20)
        }
        
        songName.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(logoImage.snp.right).inset(-16)
        }
        
        forwardButton.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(16)
        }
        
        playButton.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.centerY.equalToSuperview()
            make.right.equalTo(forwardButton.snp.left).inset(-16)
        }
        
    }
    
    @objc private func tapPlay() {
        print("TAP TAP TAP")
        let playVC = Builder.getPlayModule(track: nil, indexPath: nil)
        
        playVC.modalTransitionStyle = .crossDissolve
        playVC.modalPresentationStyle = .fullScreen
    }
    
    @objc private func tap() {
        
    }
}
