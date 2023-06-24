//
//  PlaylistPresenter.swift
//  Musique
//
//  Created by sidzhe on 23.06.2023.
//

import Foundation

//MARK: - Protocols

protocol PlaylistViewProtocol: AnyObject {

}

protocol PlaylistPresenterProtocol: AnyObject {
    init(view: PlaylistViewProtocol, networkService: NetworkService?, track: SearchTracks?, indexPath: IndexPath?, saveTracks: [SearchTracks]?)
    var saveTracks: [SearchTracks]? { get set }
}


//MARK: - Class PlaylistPresenter

class PlaylistPresenter: PlaylistPresenterProtocol {
    
    weak var view: PlaylistViewProtocol?
    
    var networkService: NetworkService?
    
    var track: SearchTracks?
    
    var indexPath: IndexPath?
    
    var tracksPlaylist = [SearchTracks]()
    
    var saveTracks: [SearchTracks]?
    
    
    
    
    required init(view: PlaylistViewProtocol, networkService: NetworkService?, track: SearchTracks?, indexPath: IndexPath?, saveTracks: [SearchTracks]?) {
        self.view = view
        self.track = track
        self.networkService = networkService
        self.indexPath = indexPath
        self.saveTracks = saveTracks
    }
    
    //MARK: - Methods

}

