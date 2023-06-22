import Foundation

protocol HomeViewProtocol: AnyObject {
    func succses()
    func failure()
}

protocol HomePresenterProtocol: AnyObject {
    init (view: HomeViewProtocol, networkService: NetworkService)
    var newSongArray: [RequestResult] {get}
    var recentlyPlayedArray: [RequestResult] {get}
    var popularAlbumArray: [RequestResult] {get}
}

class HomePresenter: HomePresenterProtocol {
    weak var view: HomeViewProtocol?
    var networkService: NetworkService!
    var newSongArray: [RequestResult] = []
    var recentlyPlayedArray: [RequestResult] = []
    var popularAlbumArray: [RequestResult] = []
    
    required init(view: HomeViewProtocol, networkService: NetworkService) {
        self.view = view
        self.networkService = networkService
        getNewSongs()
        getPopularAlbum()
        getRecentlyPlayed()
    }
    
    func getNewSongs() {
        let request = HomeRequest()
        networkService.request(request) { [weak self] result in
            switch result {
            case .success(let songArray):
                self?.newSongArray = songArray.results
                self?.view?.succses()
            case .failure(_):
                self?.view?.failure()
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    self?.getNewSongs()
                }
            }
        }
    }
    
    func getPopularAlbum() {
        let request = PopularAlbumRequest()
        networkService.request(request) { [weak self] result in
            switch result {
            case .success(let songArray):
                self?.popularAlbumArray = songArray.results
            case .failure(_):
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    self?.getPopularAlbum()
                }
            }
        }
    }
    
    func getRecentlyPlayed() {
        let request = RecentlyPlayedRequest()
        networkService.request(request) { [weak self] result in
            switch result {
            case .success(let songArray):
                self?.recentlyPlayedArray = songArray.results
            case .failure(_):
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    self?.getRecentlyPlayed()
                }
            }
        }
    }
    
}
