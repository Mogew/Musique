import Firebase
import FirebaseDatabase


protocol ProfileViewProtocol: AnyObject {
    func success()
    func failure()
}

protocol ProfilePresenterProtocol: AnyObject {
    init(view: ProfileViewProtocol)
}

final class ProfilePresenter: ProfilePresenterProtocol{
    
    let uID = FirebaseManager.shared.userUID
    //let dbFirestore = Firestore.firestore()
    
    weak var view: ProfileViewProtocol?
    
    required init(view: ProfileViewProtocol) {
        self.view = view
    }
    
    
}
