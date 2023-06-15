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

class UserSignUpPresenter: UserSignUpPresenterProtocol {
    weak var view: UserSignUpViewProtocol?
    
    required init(view: UserSignUpViewProtocol) {
        self.view = view
    }
    
    func createUser(email: String?, password: String?) {
        if let email, let password {
            Auth.auth().createUser(withEmail: email, password: password) { [unowned self] authResult, error in
                if error != nil {
                    view?.failure(error!)
                } else {
                    view?.succses()
                }
            }
        }
    }
}
