//
//  AlbumPresenter.swift
//  Musique
//
//  Created by sidzhe on 22.06.2023.
//

import Foundation

//MARK: - Protocols

protocol AlbumViewProtocol: AnyObject {
    func setData(index: IndexPath?, trackArray: [SearchTracks]?)
}

protocol AlbumPresenterProtocol: AnyObject {
    init(view: AlbumViewProtocol, networkService: NetworkService, avPlayer: AVplayerProtocol, indexPath: IndexPath?, tracksArray: [SearchTracks]?)
    var indexPath: IndexPath? { get set }
    var tracksArray: [SearchTracks]? { get set }
    func getData()
}


//MARK: - Class AlbumPresenter

class AlbumPresenter: AlbumPresenterProtocol {
    
    weak var view: AlbumViewProtocol?
    
    var networkService: NetworkService?
    
    var avPlayer: AVplayerProtocol?
    
    var indexPath: IndexPath?
    
    var tracksArray: [SearchTracks]?
    
    required init(view: AlbumViewProtocol, networkService: NetworkService, avPlayer: AVplayerProtocol, indexPath: IndexPath?, tracksArray: [SearchTracks]?) {
        self.view = view
        self.networkService = networkService
        self.avPlayer = avPlayer
        self.indexPath = indexPath
        self.tracksArray = tracksArray
        
        getData()
    }
    
    //MARK: - Methods
    
    func getData() {
        view?.setData(index: indexPath, trackArray: tracksArray)
    }
}
