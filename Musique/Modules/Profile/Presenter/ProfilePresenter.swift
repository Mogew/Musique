
protocol ProfileViewProtocol: AnyObject {
    func success()
    func failure()
}

protocol ProfilePresenterProtocol: AnyObject {
    init(view: ProfileViewProtocol)
}

class ProfilePresenter: ProfilePresenterProtocol{
    weak var view: ProfileViewProtocol?
    
    required init(view: ProfileViewProtocol) {
        self.view = view
    }
    
    
}
