import Foundation
import Firebase

protocol UserSignUpViewProtocol: AnyObject {
    func succses()
    func failure(_ error: Error)
}

protocol UserSignUpPresenterProtocol: AnyObject {
    init (view: UserSignUpViewProtocol)
    func createUser(email: String?, password: String?)
}

final class UserSignUpPresenter: UserSignUpPresenterProtocol {
    weak var view: UserSignUpViewProtocol?
    
    required init(view: UserSignUpViewProtocol) {
        self.view = view
    }
    
    func createUser(email: String?, password: String?) {
        guard let email = email, !email.isEmpty, let password = password, !password.isEmpty else {
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                self?.view?.failure(error)
            } else {
                self?.view?.succses()
            }
        }
    }
}
