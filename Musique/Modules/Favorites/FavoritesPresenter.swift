
import Foundation
import RealmSwift

protocol FavoritesViewProtocol: AnyObject {
    func succses()
    func failure()
}

protocol FavoritesPresenterProtocol: AnyObject {
    init (view: FavoritesViewController)
    
    func getDataFromDataBase()
}

class FavoritesPresenter: FavoritesPresenterProtocol {

    weak var view: FavoritesViewController?
    let realm = try! Realm()
    
    required init(view: FavoritesViewController) {
        self.view = view
        getDataFromDataBase()
    }
    
    func getDataFromDataBase() {
        print("Path: \(String(describing: realm.configuration.fileURL?.path))")
        view?.succses()
    }
    
}
