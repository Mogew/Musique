import UIKit
import SnapKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTabs()
        customizeTabBar()
        setupMini()
        
    }
    //MARK: - Tab Setup
    private func setupTabs() {
        let home = self.createNav(with: "Home",
                                  and: UIImage(systemName: "house"),
                                  and: "Music",
                                  vc: HomeViewController())
        let explore = self.createNav(with: "Explore",
                                     and: UIImage(systemName: "sparkles.rectangle.stack"),
                                     and: "Explore", vc: HomeViewController())
        let favorites = self.createNav(with: "Favorites",
                                       and: UIImage(systemName: "heart"),
                                       and: "Favorites",vc: HomeViewController())
        let account = self.createNav(with: "Account",
                                     and: UIImage(systemName: "person"),
                                     and: "Account",
                                     vc: HomeViewController())
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
    
    private func setupMini() {
        let miniPlayer = MiniPlayerView()
        
        view.insertSubview(miniPlayer, belowSubview: tabBar)
        
        miniPlayer.snp.makeConstraints { make in
            make.bottom.equalTo(tabBar.snp.top)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(64)
        }
    }
}
