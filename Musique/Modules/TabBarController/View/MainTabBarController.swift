//
//  TabBarController.swift
//  Musique
//
//  Created by sidzhe on 28.06.2023.
//

import UIKit

protocol MusicDelegateProtocol: AnyObject {
    func setMusic()
}

class MainTabBarController: UITabBarController, MainTabBarProtocol {
    
    //MARK: - Properties
    
    var presenter: MainTabBarPresenterProtocol?
    
    private lazy var miniPlayer = UIView()
    
    private let player = Builder.player
    
    //MARK: - UI Elements
    
    private lazy var logoImage: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 15
        view.image = UIImage(systemName: "swift")
        view.tintColor = .clear
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
        button.setBackgroundImage(Const.Images.ellipsePlay, for: .normal)
        button.setImage(Const.Images.playpauseFill, for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        return button
    }()
    
    private lazy var swipe: UISwipeGestureRecognizer = {
        let swipe = UISwipeGestureRecognizer()
        swipe.direction = .up
        swipe.addTarget(self, action: #selector(tapSwipe))
        return swipe
    }()
    
    
    //MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupControllers()
        setupMiniPlayer()
        
    }
    
    //MARK: - Setup Views, Controllers
    
    private func setupControllers() {
        let home = Builder.getHomeModule()
        let explore = UIViewController()
        let favorites = Builder.getFavoritesModule()
        let account = ProfileViewController()
        
        
        viewControllers = [
            //            createVC(vc: home, item: UITabBarItem(tabBarSystemItem: .topRated, tag: 0), title: "Home"),
            createHome(vc: home as! HomeViewController, item: UITabBarItem(tabBarSystemItem: .topRated, tag: 4), title: "Home"),
            createVC(vc: explore, item: UITabBarItem(tabBarSystemItem: .topRated, tag: 1), title: "Explore"),
            createVC(vc: favorites, item: UITabBarItem(tabBarSystemItem: .topRated, tag: 2), title: "Favorites"),
            createVC(vc: account, item: UITabBarItem(tabBarSystemItem: .topRated, tag: 3), title: "Account")
        ]
    }
    
    private func createVC(vc: UIViewController, item: UITabBarItem, title: String) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: vc)
        navigationVC.navigationBar.prefersLargeTitles = true
        vc.tabBarItem = item
        vc.navigationItem.title = title
        tabBar.tintColor = .mLime
        return navigationVC
    }
    
    private func createHome(vc: HomeViewController, item: UITabBarItem, title: String) -> UIViewController {
        vc.musicDelegate = self
        let navigationVC = UINavigationController(rootViewController: vc)
        navigationVC.navigationBar.prefersLargeTitles = true
        vc.tabBarItem = item
        vc.navigationItem.title = title
        tabBar.tintColor = .mLime
        return navigationVC
    }
    
    //MARK: - Setup MiniPlayer
    
    private func setupMiniPlayer() {
        
        miniPlayer.backgroundColor = .mLime
        
        miniPlayer.addSubview(logoImage)
        miniPlayer.addSubview(songName)
        miniPlayer.addSubview(playButton)
        
        view.addGestureRecognizer(swipe)
        
        view.insertSubview(miniPlayer, belowSubview: tabBar)
        
        miniPlayer.snp.makeConstraints { make in
            make.bottom.equalTo(tabBar.snp.top)
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(tabBar.snp.top).inset(-64)
        }
        
        logoImage.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(20)
        }
        
        songName.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(logoImage.snp.right).inset(-16)
        }
        
        playButton.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(20)
        }
    }
    
    //MARK: - Targets
    
    @objc private func tap() {
        player.playPause()
    }
    
    @objc private func tapSwipe() {
        let playVC = Builder.getPlayModule(track: player.tracks, indexPath: player.indexPath)
        playVC.modalPresentationStyle = .fullScreen
        playVC.modalTransitionStyle = .crossDissolve
        present(playVC, animated: true)
    }
    
}

//MARK: - Extension MusicDelegate

extension MainTabBarController: MusicDelegateProtocol {
    func setMusic() {
        guard let track = self.player.tracks?[self.player.indexPath?.row ?? 0] else { return }
        
        self.songName.text = track.trackName
        
        let urlImage = track.artworkUrl30
        guard let url = URL(string: urlImage ?? Const.Text.empty) else { return }
        self.logoImage.kf.setImage(with: url)
    }
}
