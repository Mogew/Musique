import UIKit
import RealmSwift

class FavoritesViewController: UIViewController {
    // temp solution
    let realm = try! Realm()
    var songs = [FavoriteSong]()
    
    var presenter: FavoritesPresenterProtocol!
    private let favoritesTableView = FavoritesTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mDarkBlue
        addViewLayout()
    }
    // temp solution
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDataFromDataBase()
        favoritesTableView.setTableView(cells: songs)
    }
    

    
    func addViewLayout() {
        view.addSubview(favoritesTableView)
        
        NSLayoutConstraint.activate([
            favoritesTableView.topAnchor.constraint(equalTo: view.topAnchor),
            favoritesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            favoritesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            favoritesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    
}

extension FavoritesViewController: FavoritesViewProtocol {
    func succses() {
        print("success")
    }
    
    func failure() {
        print("fail")
    }
    // temp solution
    func getDataFromDataBase() {
        let requestResult = realm.objects(FavoriteSong.self)
        for i in requestResult {
            songs.append(i)
        }
    }
    
    func deleteSongFromDB(with indexPath: Int) {
        let song = realm.objects(FavoriteSong.self)[indexPath]
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
