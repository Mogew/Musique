import Foundation
import RealmSwift

protocol HomeViewProtocol: AnyObject {
    func succses()
    func failure()
}

protocol HomePresenterProtocol: AnyObject {
    init (view: HomeViewProtocol, networkService: NetworkService)
    var newSongArray: [SearchTracks] {get}
    var recentlyPlayedArray: [SearchTracks] {get}
    var popularAlbumArray: [SearchTracks] {get}
    
    func writeInDataBase(songObject: SearchTracks)
}

class HomePresenter: HomePresenterProtocol {
    
    weak var view: HomeViewProtocol?
    var networkService: NetworkService!
    let realm = try! Realm()
    var newSongArray: [SearchTracks] = [SearchTracks(artistName: "", collectionName: "", trackName: "", previewUrl: "1", artworkUrl30: "", artworkUrl60: "", artworkUrl100: "", artistViewUrl: "")]
    var recentlyPlayedArray: [SearchTracks] = [SearchTracks(artistName: "", collectionName: "", trackName: "", previewUrl: "2", artworkUrl30: "", artworkUrl60: "", artworkUrl100: "", artistViewUrl: "")]
    var popularAlbumArray: [SearchTracks] = [SearchTracks(artistName: "", collectionName: "", trackName: "", previewUrl: "3", artworkUrl30: "", artworkUrl60: "", artworkUrl100: "", artistViewUrl: "")]
    
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
    
    func writeInDataBase(songObject: SearchTracks) {
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
