import UIKit
import FirebaseAuth

final class AuthSwitch {
    var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func root() {
        let status = UserDefaults.standard.bool(forKey: Keys.auth.rawValue)
        
        if status == true {
            Auth.auth().addStateDidChangeListener { (auth, user) in
                if user == nil {
                    let welcome = Builder.getSignInModule()
                    self.window?.rootViewController = UINavigationController(rootViewController: welcome)
                } else {
                    self.window?.rootViewController = TabBarController()
                }
            }
        } else {
            
        }
    }
}
