import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    //MARK: - Property
    var window: UIWindow?

    //MARK: - Methods
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = Builder.createTabBar()
        window?.makeKeyAndVisible()
        
//        window = UIWindow(windowScene: windowScene)
//        window?.overrideUserInterfaceStyle = .dark
////        window?.rootViewController = UINavigationController(rootViewController: Builder.getSignInModule())
//        window?.rootViewController = Builder.createTabBar()
//        window?.makeKeyAndVisible()
    }
}
