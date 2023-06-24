
import Foundation
import RealmSwift

protocol FavoritesViewProtocol: AnyObject {
    func succses()
    func failure()
}

protocol FavoritesPresenterProtocol: AnyObject {
    init (view: FavoritesViewProtocol)
    var songs: [FavoriteSong] {set get}
    func getDataFromDataBase()
}

class FavoritesPresenter: FavoritesPresenterProtocol {
    weak var view: FavoritesViewProtocol?
    let realm = try! Realm()
    var songs = [FavoriteSong]()
    
    required init(view: FavoritesViewProtocol) {
        self.view = view
        getDataFromDataBase()
    }
    
    func getDataFromDataBase() {
        let requestResult = realm.objects(FavoriteSong.self)
        for i in requestResult {
            songs.append(i)
        }
        view?.succses()
    }
    
}
