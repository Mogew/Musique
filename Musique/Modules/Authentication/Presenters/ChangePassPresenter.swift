import Foundation
import Firebase

protocol ChangePassViewProtocol: AnyObject {
    func success()
    func failure(_ error: Error)
}

protocol ChangePassPresenterProtocol: AnyObject {
    init(view: ChangePassViewProtocol)
    func updatePassword(password: String?)
}

final class ChangePassPresenter: ChangePassPresenterProtocol {
    
    weak var view: ChangePassViewProtocol?
    required init(view: ChangePassViewProtocol) {
        self.view = view
    }
    
    func updatePassword(password: String?) {
        if let password = password {
            FirebaseManager.shared.changePassword(password: password) { [weak self] error in
                if let error = error {
                    self?.view?.failure(error)
                } else {
                    self?.view?.success()
                
                }
            }
        }
    }
}


