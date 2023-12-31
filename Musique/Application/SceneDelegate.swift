import UIKit
import FirebaseAuth

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    //MARK: - Property
    var window: UIWindow?
    
    //MARK: - Methods
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        setupWindow(windowScene: windowScene)
        checkAuthentication()
    }
    
    private func setupWindow(windowScene: UIWindowScene) {
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        self.window?.overrideUserInterfaceStyle = .dark
        self.window?.makeKeyAndVisible()
    }
    
    func checkAuthentication() {
        if UserDefaults.standard.value(forKey: "onbording") as? String == "ok" {
            Auth.auth().addStateDidChangeListener { (auth, user) in
                if user == nil {
                    let welcome = Builder.getSignInModule()
                    self.window?.rootViewController = UINavigationController(rootViewController: welcome)
                } else {
                    self.window?.rootViewController = TabBarController()
                }
            }
        } else {
            // If onboarding not completed
            let vc = OnboardingViewController()
            self.window?.rootViewController = UINavigationController(rootViewController: vc)
        }
    }
}

