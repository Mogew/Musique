import Foundation
import RealmSwift

protocol HomeViewProtocol: AnyObject {
    func succses()
    func failure()
}

protocol HomePresenterProtocol: AnyObject {
    init (view: HomeViewProtocol, networkService: NetworkService)
    var newSongArray: [RequestResult] {get}
    var recentlyPlayedArray: [RequestResult] {get}
    var popularAlbumArray: [RequestResult] {get}
    
    func writeInDataBase(songObject: RequestResult)
}

class HomePresenter: HomePresenterProtocol {
    weak var view: HomeViewProtocol?
    var networkService: NetworkService!
    let realm = try! Realm()
    var newSongArray: [RequestResult] = [RequestResult(artistName: "", trackName: "", previewUrl: "1", artworkUrl100: "")]
    var recentlyPlayedArray: [RequestResult] = [RequestResult(artistName: "", trackName: "", previewUrl: "2", artworkUrl100: "")]
    var popularAlbumArray: [RequestResult] = [RequestResult(artistName: "", trackName: "", previewUrl: "3", artworkUrl100: "")]
    
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
                print("-------------------------------------------")
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
                self?.view?.succses()
            case .failure(_):
                print("-------------------------------------------")
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
                self?.view?.succses()
            case .failure(_):
                self?.view?.failure()
                print("-------------------------------------------")
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    self?.getRecentlyPlayed()
                }
            }
        }
    }
    
    func writeInDataBase(songObject: RequestResult) {
        let song = FavoriteSong(songObject: songObject)
        do {
            // Open a thread-safe transaction.
            try realm.write {
                realm.add(song)
                print(song)
            }
        } catch _ as NSError {
            // ... Handle error ...
        }
    }
    
}
