import UIKit
import RealmSwift

class FavoritesViewController: UIViewController {
    
    var presenter: FavoritesPresenterProtocol!
    private let favoritesTableView = SearchCategoryTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mDarkBlue
        addViewLayout()
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
    
    
}
