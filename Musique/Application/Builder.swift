import UIKit

class Builder {
    static func getSignUpModule() -> UIViewController {
        let view = UserSignUpController()
        let presenter = UserSignUpPresenter(view: view)
        view.presenter = presenter
        return view
    }
    
    static func getHomeModule() -> UIViewController {
        let view = HomeViewController()
        let networkService = DefaultNetworkService()
        let presenter = HomePresenter(view: view, networkService: networkService)
        view.presenter = presenter
        return view
    }
    
    static func getSearchModule() -> UIViewController {
        let view = SearchViewController()
        let networkService = DefaultNetworkService()
        let presenter = SearchPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        view.categoryCollectionView.presenter = presenter
        return view
    }
}
