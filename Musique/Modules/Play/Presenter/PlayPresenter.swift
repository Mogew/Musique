//
//  PlayPresenter.swift
//  Musique
//
//  Created by sidzhe on 22.06.2023.
//

import Foundation

//MARK: - Protocol PlayViewProtocol

protocol PlayViewProtocol: AnyObject {
    func getMusic(_ model: SearchTracks?)
    func setData(index: IndexPath?, model: [SearchTracks]?)
    func updateIndexPath(index: IndexPath)
}

//MARK: - Protocol PlayPresenterProtocol

protocol PlayPresenterProtocol: AnyObject {
    init(view: PlayViewProtocol, networkService: NetworkService, avPlayer: AVplayerProtocol, indexPath: IndexPath?, tracksArray: [SearchTracks]?)
    func setMusic()
    func playPause() -> Bool
    func playTrack()
    func monitorStartTime(completion: @escaping () -> Void)
    func observPlayerCurrentTime(completion: @escaping (String, String) -> Void)
    func getCurrunetTime() -> Float
    func moveTimeSlider(currentTime: Float)
    func changeVolume(_ value: Float)
    func findNextTrack(tag: Int)
    func sendData()
    func shakeTrack()
    func checkNextTrack()
    func repeatTrack()
    func updateIndexPath(index: IndexPath?)
    var indexPath: IndexPath? { get set }
    var tracksArray: [SearchTracks]? { get set }
}

//MARK: - Class

class PlayPresenter: PlayPresenterProtocol {
    
    //MARK: - Preperties
    
    weak var view: PlayViewProtocol?
    
    var networkService: NetworkService?
    
    var avPlayer: AVplayerProtocol?
    
    var tracksArray: [SearchTracks]?
    
    var indexPath: IndexPath?
    
    //MARK: - Init
    
    required init(view: PlayViewProtocol, networkService: NetworkService, avPlayer: AVplayerProtocol, indexPath: IndexPath?, tracksArray: [SearchTracks]?) {
        self.view = view
        self.networkService = networkService
        self.indexPath = indexPath
        self.avPlayer = avPlayer
        self.tracksArray = tracksArray
        
        setMusic()
        playTrack()
        sendData()
    }
    
    //MARK: - Methods
    
    func setMusic() {
        view?.getMusic(tracksArray?[indexPath?.row ?? 0])
    }
    
    func playPause() -> Bool {
        avPlayer!.playPause()
    }
    
    func playTrack() {
        avPlayer?.playTrack(tracksArray?[indexPath?.row ?? 0])
    }
    
    func monitorStartTime(completion: @escaping () -> Void) {
        avPlayer?.monitorStartTime(completion: completion)
    }
    
    func observPlayerCurrentTime(completion: @escaping (String, String) -> Void) {
        avPlayer?.observPlayerCurrentTime(completion: completion)
    }
    
    func getCurrunetTime() -> Float {
        return avPlayer?.getCurrunetTime() ?? 0
    }
    
    func moveTimeSlider(currentTime: Float) {
        avPlayer?.moveTimeSlider(currentTime: currentTime)
    }
    
    func changeVolume(_ value: Float) {
        avPlayer?.changeVolume(value)
    }
    
    func findNextTrack(tag: Int) {
        guard let tracks = tracksArray, indexPath?.row != nil else { return }
        
        if tag == 1 {
            checkNextTrack()
        } else {
            if indexPath!.row - 1 == -1 {
                indexPath!.row = tracks.count - 1
                view?.getMusic(tracks[indexPath!.row])
                avPlayer?.playTrack(tracks[indexPath!.row])
            } else {
                indexPath!.row -= 1
                view?.getMusic(tracks[indexPath!.row])
                avPlayer?.playTrack(tracks[indexPath!.row])
            }
        }
    }
    
    func checkNextTrack() {
        guard let tracks = tracksArray, indexPath?.row != nil else { return }
        
        if indexPath!.row + 1 == tracks.count {
            indexPath!.row = 0
            updateIndexPath(index: indexPath)
            view?.getMusic(tracks[indexPath!.row])
            avPlayer?.playTrack(tracks[indexPath!.row])
        } else {
            indexPath!.row += 1
            updateIndexPath(index: indexPath)
            view?.getMusic(tracks[indexPath!.row])
            avPlayer?.playTrack(tracks[indexPath!.row])
        }
    }
    
    func shakeTrack() {
        guard let tracksArray = tracksArray else { return }
        let random = Int.random(in: 0...tracksArray.count - 1)
        let randomTracks = tracksArray[random]
        var index = IndexPath(row: 0, section: 0)
        index.row = random
        updateIndexPath(index: index)
        view?.getMusic(randomTracks)
        avPlayer?.playTrack(randomTracks)
    }
    
    func repeatTrack() {
        guard let tracks = tracksArray, indexPath?.row != nil else { return }
        view?.getMusic(tracks[indexPath!.row])
        avPlayer?.playTrack(tracks[indexPath!.row])
    }
    
    func sendData() {
        view?.setData(index: indexPath, model: tracksArray)
    }
    
    func updateIndexPath(index: IndexPath?) {
        guard let index = index else { return }
        view?.updateIndexPath(index: index)
    }
}
