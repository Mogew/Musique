import Foundation

protocol SearchViewProtocol: AnyObject {
    func succses()
    func failure()
}

protocol SearchPresenterProtocol: AnyObject {
    init(view: SearchViewProtocol, networkService: NetworkService)
    func getTracks()
    func request(term: String)
    var searchArray: [SearchTracks] { get }
    var currentType: SearchType { get set }
}

class SearchPresenter: SearchPresenterProtocol {
    var currentType: SearchType = .mix
    weak var view: SearchViewProtocol?
    var searchArray: [SearchTracks] = []
    var newtworkService: NetworkService?
    
    required init(view: SearchViewProtocol, networkService: NetworkService) {
        self.view = view
        self.newtworkService = networkService
    }
    
    func getTracks() {
        view?.succses()
    }
    
    func request(term: String) {
        let request = SearchDataRequest(term: convertSpacesToPlus(term), type: currentType)
        newtworkService?.request(request, completion: { [weak self] result in
            switch result {
            case .success(let arrayResponse):
                self?.searchArray = arrayResponse.results
                self?.view?.succses()
            case .failure(let error):
                self?.view?.failure()
                print(error.localizedDescription)
            }
        })
    }
    
    func convertSpacesToPlus(_ text: String) -> String {
        let modifiedText = text.replacingOccurrences(of: " ", with: "+")
        return modifiedText
    }
}
