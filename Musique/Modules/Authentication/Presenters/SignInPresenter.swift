import Foundation
import Firebase

protocol SignInViewProtocol: AnyObject {
    func success()
    func failure(_ error: Error)
}

protocol SignInPresenterProtocol: AnyObject {
    init(view: SignInViewProtocol)
    func authUser(email: String?, password: String?)
}

final class SignInPresenter: SignInPresenterProtocol {
    weak var view: SignInViewProtocol?
    required init(view: SignInViewProtocol) {
        self.view = view
    }
    
    func authUser(email: String?, password: String?) {
        if let email = email, let password = password {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                if let error = error {
                    self?.view?.failure(error)
                } else {
                    self?.view?.success()
                }
            }
        }
    }
}

