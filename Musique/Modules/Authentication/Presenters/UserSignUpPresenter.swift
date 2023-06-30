import Foundation
import Firebase

protocol UserSignUpViewProtocol: AnyObject {
    func succses()
    func failure(_ error: Error)
}

protocol UserSignUpPresenterProtocol: AnyObject {
    init (view: UserSignUpViewProtocol)
    func createUser(email: String?, password: String?, userName: String?)
}

final class UserSignUpPresenter: UserSignUpPresenterProtocol {
    weak var view: UserSignUpViewProtocol?
    
    required init(view: UserSignUpViewProtocol) {
        self.view = view
    }
    
    func createUser(email: String?, password: String?, userName: String?) {
        guard let email = email, !email.isEmpty, let password = password, !password.isEmpty, let userName = userName else {
            return
        }
        FirebaseManager.shared.createAccount(
            email: email,
            password: password,
            userName: userName) { [weak self] error in
            if let error = error {
                self?.view?.failure(error)
            } else {
                print("Registration ok")
                
                UserDefaults.standard.set("ok", forKey: "onboarding")
                self?.view?.succses()
            }
        }
    }
}
