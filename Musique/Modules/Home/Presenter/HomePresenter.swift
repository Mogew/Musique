import Foundation
import RealmSwift

protocol HomeViewProtocol: AnyObject {
    func succses()
    func failure()
}

protocol HomePresenterProtocol: AnyObject {
    init (view: HomeViewProtocol, networkService: NetworkService)
    var newSongArray: [SearchTracks] {get}
    var recentlyPlayedArray: [SearchTracks] {get set}
    var popularAlbumArray: [SearchTracks] {get}
    
    func writeInDataBase(songObject: SearchTracks)
    func getRecentlyPlayed()
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
        
        let realmObjects = realm.objects(RecentlySong.self)
        if !realmObjects.isEmpty {
            var recentlyPlayedArrayTemp = [SearchTracks]()
            for object in realmObjects {
                let track = SearchTracks(artistName: object.artistName, collectionName: "", trackName: object.trackName, previewUrl: object.previewUrl, artworkUrl30: object.artworkUrl100, artworkUrl60: object.artworkUrl100, artworkUrl100: object.artworkUrl100, artistViewUrl: "")
                recentlyPlayedArrayTemp.insert(track, at: 0)
            }
            recentlyPlayedArray = recentlyPlayedArrayTemp
        }
    }
    
    func writeInDataBase(songObject: SearchTracks) {
        let song = FavoriteSong(songObject: songObject)
        do {
            // Open a thread-safe transaction.
            try realm.write {
                realm.add(song)
            }
        } catch _ as NSError {
            // ... Handle error ...
        }
    }
}
