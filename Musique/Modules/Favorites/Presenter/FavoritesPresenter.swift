
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
    func deleteSongFromDB(with identifier: Int)
}

final class FavoritesPresenter: FavoritesPresenterProtocol {
    weak var view: FavoritesViewProtocol?
    let realm = try! Realm()
    var songs = [FavoriteSong]()
    
    required init(view: FavoritesViewProtocol) {
        self.view = view
    }
    
    func getDataFromDataBase() {
        let requestResult = realm.objects(FavoriteSong.self)
        var tempArray = [FavoriteSong]()
        for element in requestResult {
            tempArray.append(element)
        }
        songs = tempArray
        view?.succses()
    }
    
    func deleteSongFromDB(with identifier: Int) {
        let song = realm.objects(FavoriteSong.self)[identifier]
        songs.remove(at: identifier)
        do {
            // Open a thread-safe transaction.
            try realm.write {
                realm.delete(song)
            }
        } catch _ as NSError {
            // ... Handle error ...
        }
    }
    
}
