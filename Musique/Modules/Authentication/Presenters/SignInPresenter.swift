import Foundation
import Firebase

protocol SignInViewProtocol: AnyObject {
    func success()
    func failure(_ error: Error)
}

protocol SignInPresenterProtocol: AnyObject {
    init(view: SignInViewProtocol)
    func signInUser(email: String?, password: String?)
}

final class SignInPresenter: SignInPresenterProtocol {
    weak var view: SignInViewProtocol?
    required init(view: SignInViewProtocol) {
        self.view = view
    }
   

    func signInUser(email: String?, password: String?) {
        if let email = email, let password = password {
            FirebaseManager.shared.signIn(email: email, password: password) { [weak self] error in
                if let error = error {
                    self?.view?.failure(error)
                } else {
                    print("Auth ok")
                    UserDefaults.standard.set("ok", forKey: "onboarding")
                    self?.view?.success()
                }
            }
        }
    }
}

