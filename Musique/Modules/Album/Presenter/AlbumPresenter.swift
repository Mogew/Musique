//
//  AlbumPresenter.swift
//  Musique
//
//  Created by sidzhe on 22.06.2023.
//

import Foundation

//MARK: - Protocols

protocol AlbumViewProtocol: AnyObject {
    func setBackgroundImage(model: Track)
}

protocol AlbumPresenterProtocol: AnyObject {
    init(view: AlbumViewProtocol, networkService: NetworkServiceProtocol, avPlayer: AVplayerProtocol, indexPath: IndexPath?, tracksArray: [Track]?)
    var indexPath: IndexPath? { get set }
    var tracksArray: [Track]? { get set }
    func getBackgroundImage()
}


//MARK: - Class AlbumPresenter

class AlbumPresenter: AlbumPresenterProtocol {
    
    weak var view: AlbumViewProtocol?
    
    var networkService: NetworkServiceProtocol?
    
    var avPlayer: AVplayerProtocol?
    
    var indexPath: IndexPath?
    
    var tracksArray: [Track]?
    
    required init(view: AlbumViewProtocol, networkService: NetworkServiceProtocol, avPlayer: AVplayerProtocol, indexPath: IndexPath?, tracksArray: [Track]?) {
        self.view = view
        self.networkService = networkService
        self.avPlayer = avPlayer
        self.indexPath = indexPath
        self.tracksArray = tracksArray
        
    }
    
    //MARK: - Methods
    
    func getBackgroundImage() {
        guard let indexPath = indexPath?.row else { return }
        guard let tracksArray = tracksArray else { return }
        
        view?.setBackgroundImage(model: tracksArray[indexPath])
    }
}
