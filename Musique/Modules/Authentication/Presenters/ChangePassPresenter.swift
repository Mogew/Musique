import Foundation
import Firebase

protocol ChangePassViewProtocol: AnyObject {
    func success()
    func failure(_ error: Error)
}

protocol ChangePassPresenterProtocol: AnyObject {
    init(view: ChangePassViewProtocol)
    func updatePassword(password: String?, code: String?)
}

final class ChangePassPresenter: ChangePassPresenterProtocol {
    
    weak var view: ChangePassViewProtocol?
    required init(view: ChangePassViewProtocol) {
        self.view = view
    }
    
    func updatePassword(password: String?, code: String?) {
        if let password = password, let code = code {
            Auth.auth().confirmPasswordReset(withCode: code, newPassword: password) { [weak self] error in
                if let error = error {
                    self?.view?.failure(error)
                } else {
                    self?.view?.success()
                }
            }
        }
    }
}


