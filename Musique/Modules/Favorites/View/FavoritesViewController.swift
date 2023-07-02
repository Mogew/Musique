import UIKit

protocol FavoriteDeleteFromDB: AnyObject {
    func getIndexPathToDelete(indexPath: IndexPath)
}

final class FavoritesViewController: UIViewController {
    var presenter: FavoritesPresenterProtocol!
    private let favoritesTableView = FavoritesTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mDarkBlue
        addViewLayout()
        favoritesTableView.dbDelegate = self
    }
    
    // temp solution
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getDataFromDataBase()
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
        favoritesTableView.setTableView(cells: presenter.songs)
    }
    
    func failure() {
        print("fail")
    }
    // temp solution
    

    
}
extension FavoritesViewController: FavoriteDeleteFromDB {
    func getIndexPathToDelete(indexPath: IndexPath){
        presenter.deleteSongFromDB(with: indexPath.row)
    }
}
