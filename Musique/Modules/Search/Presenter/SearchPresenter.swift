import Foundation

protocol SearchViewProtocol: AnyObject {
    func succses()
    func failure()
}

protocol SearchPresenterProtocol: AnyObject {
    init(view: SearchViewProtocol, networkService: NetworkService)
    func getTracks()
    func request(q: String, type: SearchType)
    var searchArray: [SearchCategoryModel] { get }
}

class SearchPresenter: SearchPresenterProtocol {
    weak var view: SearchViewProtocol?
    var searchArray: [SearchCategoryModel] = []
    var newtworkService: NetworkService?
    
    required init(view: SearchViewProtocol, networkService: NetworkService) {
        self.view = view
        self.newtworkService = networkService
    }
    
    func getTracks() {
        view?.succses()
    }
    
    func request(q: String, type: SearchType) {
        let request = SearchDataRequest(q: q, type: .multi)
        newtworkService?.request(request, completion: { [weak self] result in
            switch result {
            case .success(let success):
                self?.searchArray.append(success)
                self?.view?.succses()
            case .failure(_):
                self?.view?.failure()
            }
        })
    }
}
