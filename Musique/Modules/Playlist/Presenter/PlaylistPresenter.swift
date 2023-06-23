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
    init(view: PlaylistViewProtocol, networkService: NetworkService?, track: SearchTracks?, indexPath: IndexPath?)
}


//MARK: - Class PlaylistPresenter

class PlaylistPresenter: PlaylistPresenterProtocol {
    
    weak var view: PlaylistViewProtocol?
    
    var networkService: NetworkService?
    
    var track: SearchTracks?
    
    var indexPath: IndexPath?
    
    var tracksPlaylist = [SearchTracks]()
    
    
    required init(view: PlaylistViewProtocol, networkService: NetworkService?, track: SearchTracks?, indexPath: IndexPath?) {
        self.view = view
        self.track = track
        self.networkService = networkService
        self.indexPath = indexPath
        addNewTrack()
    }
    
    func addNewTrack() {
        guard let track = track else { return }
        tracksPlaylist.append(track)
    }
    
}

