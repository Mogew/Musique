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
    init(view: PlaylistViewProtocol, networkService: NetworkService?, track: SearchTracks?, indexPath: IndexPath?, saveTracks: [SearchTracks]?, avPlayer: AVplayerProtocol)
    var saveTracks: [SearchTracks]? { get set }
    func playTrack(track: SearchTracks)
}


//MARK: - Class PlaylistPresenter

class PlaylistPresenter: PlaylistPresenterProtocol {
    
    weak var view: PlaylistViewProtocol?
    
    var networkService: NetworkService?
    
    var track: SearchTracks?
    
    var indexPath: IndexPath?
        
    var saveTracks: [SearchTracks]?
    
    var avPlayer: AVplayerProtocol?
    
    required init(view: PlaylistViewProtocol, networkService: NetworkService?, track: SearchTracks?, indexPath: IndexPath?, saveTracks: [SearchTracks]?, avPlayer: AVplayerProtocol) {
        self.view = view
        self.track = track
        self.networkService = networkService
        self.indexPath = indexPath
        self.saveTracks = saveTracks
        self.avPlayer = avPlayer
    }
    
    //MARK: - Methods
    
    func playTrack(track: SearchTracks) {
        avPlayer?.playTrack(track)
    }
}

