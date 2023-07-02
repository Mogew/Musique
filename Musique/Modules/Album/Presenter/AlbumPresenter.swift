import Foundation

//MARK: - Protocols

protocol AlbumViewProtocol: AnyObject {
    func setData(index: IndexPath?, trackArray: [SearchTracks]?, saveTrack: [SearchTracks]?)
}

protocol AlbumPresenterProtocol: AnyObject {
    init(view: AlbumViewProtocol, networkService: NetworkService, avPlayer: AVplayerProtocol, indexPath: IndexPath?, tracksArray: [SearchTracks]?, saveTracks: [SearchTracks]?)
    var indexPath: IndexPath? { get set }
    var tracksArray: [SearchTracks]? { get set }
    func getData()
    func play(track: SearchTracks)
    var avPlayer: AVplayerProtocol? { get }
}


//MARK: - Class AlbumPresenter

final class AlbumPresenter: AlbumPresenterProtocol {
    
    weak var view: AlbumViewProtocol?
    
    var networkService: NetworkService?
    
    var avPlayer: AVplayerProtocol?
    
    var indexPath: IndexPath?
    
    var tracksArray: [SearchTracks]?
    
    var saveTracks: [SearchTracks]?
    
    required init(view: AlbumViewProtocol, networkService: NetworkService, avPlayer: AVplayerProtocol, indexPath: IndexPath?, tracksArray: [SearchTracks]?, saveTracks: [SearchTracks]?) {
        self.view = view
        self.networkService = networkService
        self.avPlayer = avPlayer
        self.indexPath = indexPath
        self.tracksArray = tracksArray
        self.saveTracks = saveTracks
        getData()
    }
    
    //MARK: - Methods
    
    func getData() {
        view?.setData(index: indexPath, trackArray: tracksArray, saveTrack: saveTracks)
    }
    
    func play(track: SearchTracks) {
        avPlayer?.playTrack(track)
    }
}
