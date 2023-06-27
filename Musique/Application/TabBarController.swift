import UIKit
import SnapKit

class TabBarController: UITabBarController {
    
    //MARK: - UI Elements
 
    lazy var miniPlayer = UIView()
    
    private let player = Builder.player
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "EllipsePlay"), for: .normal)
        button.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        return button
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
        let home = self.createNav(with: "Home",
                                  and: UIImage(systemName: "house"),
                                  and: "Music",
                                  vc: Builder.getHomeModule())
        let explore = self.createNav(with: "Explore",
                                     and: UIImage(systemName: "sparkles.rectangle.stack"),
                                     and: "Explore", vc: HomeViewController())
        let favorites = self.createNav(with: "Favorites",
                                       and: UIImage(systemName: "heart"),
                                       and: "Favorites",vc: Builder.getFavoritesModule())
        let account = self.createNav(with: "Account",
                                     and: UIImage(systemName: "person"),
                                     and: "Account",
                                     vc: ProfileViewController())
        self.setViewControllers([home, explore, favorites, account], animated: true)
        
    }
    
    private func createNav(with title: String,
                           and image: UIImage?,
                           and largeTitle: String,
                           vc: UIViewController) -> UINavigationController {
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
    
    private func setupMiniPlayer() {
        miniPlayer.backgroundColor = .mLime
        
        miniPlayer.addSubview(playButton)
        
        view.insertSubview(miniPlayer, belowSubview: tabBar)
        
        miniPlayer.snp.makeConstraints { make in
            make.bottom.equalTo(tabBar.snp.top)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(64)
        }
        
        playButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.center.equalToSuperview()
        }
    }
    
    //MARK: - Targets
    
    @objc private func tap() {
        player.playPause()
    }
}

