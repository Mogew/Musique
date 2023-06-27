import Foundation
import Firebase

protocol ForgotPassViewProtocol: AnyObject {
    func success()
    func failure(_ error: Error)
}

protocol ForgotPassPresenterProtocol: AnyObject {
    init(view: ForgotPassViewProtocol)
    func sendPasswordReset(email: String?)
}

final class ForgotPassPresenter: ForgotPassPresenterProtocol {
    
    weak var view: ForgotPassViewProtocol?
    required init(view: ForgotPassViewProtocol) {
        self.view = view
    }
    
    func sendPasswordReset(email: String?) {
        guard let email = email, !email.isEmpty else {
            return
        }
        Auth.auth().fetchSignInMethods(forEmail: email) { [weak self] (methods, error) in
            if let error = error {
                self?.view?.failure(error)
            } else if let methods = methods, !methods.isEmpty {
                Auth.auth().sendPasswordReset(withEmail: email) { [weak self] error in
                    if let error = error {
                        self?.view?.failure(error)
                    } else {
                        self?.view?.success()
                    }
                }
            }
        }
    }
}
