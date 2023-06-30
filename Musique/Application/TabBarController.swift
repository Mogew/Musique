import UIKit
import SnapKit
import Kingfisher

protocol MusicDelegateProtocol: AnyObject {
    func setMusic()
    func hidePlayer()
}

class TabBarController: UITabBarController {
    
    //MARK: - Properties
    
    private lazy var miniPlayer = UIView()
    
    private let player = Builder.player
    
    //MARK: - UI Elements
    
    private lazy var logoImage: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 15
        view.tintColor = .clear
        return view
    }()
    
    private lazy var songName: UILabel = {
        let label = UILabel()
        label.font = UIFont.robotoRegular(ofSize: 16)
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
        
        self.setupTabs()
        customizeTabBar()
        setupMiniPlayer()
        
    }
    
    //MARK: - Tab Setup
    
    private func setupTabs() {
        let home = self.createNav(
            with: "Home",
            and: UIImage(systemName: "house"),
            and: "Music",
            vc: Builder.getHomeModule())
        
        let explore = self.createNav(
            with: "Explore",
            and: UIImage(systemName: "sparkles.rectangle.stack"),
            and: "Explore", vc: UIViewController())
        
        let favorites = self.createNav(
            with: "Favorites",
            and: UIImage(systemName: "heart"),
            and: "Favorites",vc: Builder.getFavoritesModule())
        
        let account = self.createNav(
            with: "Account",
            and: UIImage(systemName: "person"),
            and: "Account",
            vc: ProfileViewController())
        
        self.setViewControllers([home, explore, favorites, account], animated: true)
        
        home.viewControllers.forEach { vc in
            if let homeVC = vc as? HomeViewController {
                homeVC.musicDelegate = self
            }
        }
    }
    
    private func createNav(with title: String, and image: UIImage?, and largeTitle: String, vc: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        
        // font size
        let attributes = [ NSAttributedString.Key.font: UIFont.robotoBold(ofSize: 48) ]
        nav.navigationBar.largeTitleTextAttributes = attributes as [NSAttributedString.Key: Any]
        
        //navbar title
        nav.viewControllers.first?.navigationItem.title = largeTitle
        nav.navigationBar.prefersLargeTitles = true
        nav.navigationItem.largeTitleDisplayMode = .automatic
        
        return nav
    }
    
    private func customizeTabBar() {
        if #available(iOS 13.0, *) {
            let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            
            if #available(iOS 15.0, *) {
                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            }
        }
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBar.layer.masksToBounds = true
        tabBar.barTintColor = .mDarkBlue
        self.tabBar.tintColor = .mLime
        self.tabBar.unselectedItemTintColor = .mGray
        
    }
    
    //MARK: - Setup MiniPlayer
    
    private func setupMiniPlayer() {
        miniPlayer.backgroundColor = .mLime
        miniPlayer.alpha = 0
        
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

extension TabBarController: MusicDelegateProtocol {
    func setMusic() {
        guard let track = self.player.tracks?[self.player.indexPath?.row ?? 0] else { return }
        
        self.songName.text = track.trackName
        
        let urlImage = track.artworkUrl30
        guard let url = URL(string: urlImage ?? Const.Text.empty) else { return }
        self.logoImage.kf.setImage(with: url)
    }
    
    func hidePlayer() {
        UIView.animate(withDuration: 0.7) {
            self.miniPlayer.alpha = 1
            self.miniPlayer.isHidden = false
        }
    }
}
