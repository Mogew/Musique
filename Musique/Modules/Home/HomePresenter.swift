import Foundation

protocol HomeViewProtocol: AnyObject {
    func succses()
    func failure()
}

protocol HomePresenterProtocol: AnyObject {
    init (view: HomeViewProtocol, networkService: NetworkService)
    var newSongArray: [RequestResult] {get}
}

class HomePresenter: HomePresenterProtocol {
    weak var view: HomeViewProtocol?
    var networkService: NetworkService!
    var newSongArray: [RequestResult] = []
    
    required init(view: HomeViewProtocol, networkService: NetworkService) {
        self.view = view
        self.networkService = networkService
        getNewSongs()
    }
    
    func getNewSongs() {
        let request = HomeRequest()
        networkService.request(request) { [weak self] result in
            switch result {
            case .success(let songArray):
                self?.newSongArray = songArray.results
                self?.view?.succses()
                print(self?.newSongArray, "____-------------------- HELLo")
            case .failure(_):
                self?.view?.failure()
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    self?.getNewSongs()
                }
            }
        }
    }
}
