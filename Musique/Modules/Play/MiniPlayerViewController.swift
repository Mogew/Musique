//
//  MiniPlayerViewController.swift
//  Musique
//
//  Created by sidzhe on 25.06.2023.
//

import UIKit
import SnapKit

class MiniPlayerViewController: UIView {
    
    //MARK: - Properties
    
    private lazy var logoImage: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 15
        return view
    }()

    private lazy var songName: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "EllipsePlay"), for: .normal)
        button.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        return button
    }()
    
    private lazy var forwardButton: UIButton = {
        let button = UIButton()
        button.configuration = .filled()
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        return button
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "EllipsePlay"), for: .normal)
        button.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        return button
    }()

    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 20
        return view
    }()
    
    //MARK: - Init
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        setupViews()
//
//    }
    
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
        addSubview(forwardButton)
//        stackView.addArrangedSubview(forwardButton)
//        stackView.addArrangedSubview(playButton)
//        stackView.addArrangedSubview(backButton)
//        stackView.addArrangedSubview(songName)
//        stackView.addArrangedSubview(logoImage)
        
        forwardButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.center.equalToSuperview()
        }
    }
    
    @objc private func tapPlay() {
        print("dfsadsad")
        let playVC = Builder.getPlayModule(track: nil, indexPath: nil)
        
        playVC.modalTransitionStyle = .crossDissolve
        playVC.modalPresentationStyle = .fullScreen
//        present(playVC, animated: true)
    }
    
    @objc private func tap() {
        print("dsdsadsa")
    }
    
}
