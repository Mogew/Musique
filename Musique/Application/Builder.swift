import UIKit

class Builder {
    static let player = AVPlayerClass()
    
    static func getSignUpModule() -> UIViewController {
        let view = UserSignUpController()
        let presenter = UserSignUpPresenter(view: view)
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
    
    static func getPlayModule(track: [SearchTracks]?, indexPath: IndexPath?) -> UIViewController {
        let view = PlayViewController()
        let networkService = DefaultNetworkService()
        let presenter = PlayPresenter(view: view, networkService: networkService, avPlayer: player, indexPath: indexPath, tracksArray: track)
        view.presenter = presenter
        return view
    }
    
    static func createAlbumVC(indexPath: IndexPath, tracksArray: [SearchTracks], saveTrack: [SearchTracks]?) -> UIViewController {
        let view = AlbumViewController()
        let networkService = DefaultNetworkService()
        let presenter = AlbumPresenter(view: view, networkService: networkService, avPlayer: player, indexPath: indexPath, tracksArray: tracksArray, saveTracks: saveTrack)
        view.presenter = presenter
        return view
    }
    
    static func createPlaylist(track: SearchTracks, indexPath: IndexPath?, saveTracks: [SearchTracks]) -> UIViewController {
        let view = PlaylistViewController()
        let networkService = DefaultNetworkService()
        let presenter = PlaylistPresenter(view: view, networkService: networkService, track: track, indexPath: indexPath, saveTracks: saveTracks, avPlayer: player)
        view.presenter = presenter
        return view
    }
}
