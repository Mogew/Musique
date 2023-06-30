//
//  AVPlayer.swift
//  Musique
//
//  Created by sidzhe on 22.06.2023.
//

import UIKit
import AVKit
import RealmSwift

protocol AVplayerProtocol: AnyObject {
    func playPause() -> Bool
    func playTrack(_ track: SearchTracks?)
    func monitorStartTime(completion: @escaping () -> Void)
    func observPlayerCurrentTime(completion: @escaping (String, String) -> Void)
    func getCurrunetTime() -> Float
    func moveTimeSlider(currentTime: Float)
    func changeVolume(_ value: Float)
    var tracks: [SearchTracks]? { get set }
    var indexPath: IndexPath? { get set }
}

//MARK: - AV Player

class AVPlayerClass: AVplayerProtocol {
    
    //MARK: - Properties
    
    var tracks: [SearchTracks]?
    let realm = try! Realm()
    var indexPath: IndexPath?
    
    //MARK: - Methods
    
    private let avPlayer: AVPlayer = {
        let player = AVPlayer()
        player.automaticallyWaitsToMinimizeStalling = false
        return player
    }()
    
    func playPause() -> Bool {
        if avPlayer.timeControlStatus == .paused {
            avPlayer.play()
            return true
        } else {
            avPlayer.pause()
            return false
        }
    }
    
    func playTrack(_ track: SearchTracks?) {
        guard let urlTrack = URL(string: track?.previewUrl ?? Const.Text.empty) else { return }
        let playerItem = AVPlayerItem(url: urlTrack)
        avPlayer.replaceCurrentItem(with: playerItem)
        avPlayer.play()
        writeRecentlyToDB(songObject: track!)
    }
    // for recently played
    func writeRecentlyToDB(songObject: SearchTracks) {
        let song = RecentlySong(songObject: songObject)
        if realm.object(ofType: RecentlySong.self, forPrimaryKey: song.previewUrl) != nil {
            do {
                // Open a thread-safe transaction.
                try realm.write {
                    realm.add(song)
                    print(song)
                }
            } catch _ as NSError {
                // ... Handle error ...
            }
        } else {
            print("object already exist")
        }
    }
    
    func monitorStartTime(completion: @escaping () -> Void) {
        let time = CMTimeMakeWithSeconds(1, preferredTimescale: 1)
        let times = [NSValue(time: time)]
        avPlayer.addBoundaryTimeObserver(forTimes: times, queue: .main) {
            completion()
        }
    }
    
    func observPlayerCurrentTime(completion: @escaping (String, String) -> Void) {
        let interval = CMTime(value: 1, timescale: 2)
        avPlayer.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
            guard let self = self else { return }
            
            let durationTime = self.avPlayer.currentItem?.duration
            let currentRurationString = ((durationTime ?? CMTime(value: 1, timescale: 1)) - time).convertToString()
            let timeString = time.convertToString()
            
            completion(timeString, currentRurationString)
        }
    }
    
    func getCurrunetTime() -> Float {
        let currentTimeSeconds = CMTimeGetSeconds(avPlayer.currentTime())
        let durationSeconds = CMTimeGetSeconds(avPlayer.currentItem?.duration ?? CMTime(value: 1, timescale: 1))
        let persent = currentTimeSeconds / durationSeconds
        return Float(persent)
    }
    
    func moveTimeSlider(currentTime: Float) {
        guard let duration = avPlayer.currentItem?.duration else { return }
        let durationInSeconds = CMTimeGetSeconds(duration)
        let seekTimeInSeconds = Float64(currentTime) * durationInSeconds
        let seekTime = CMTimeMakeWithSeconds(seekTimeInSeconds, preferredTimescale: 1)
        avPlayer.seek(to: seekTime)
    }
    
    func changeVolume(_ value: Float) {
        avPlayer.volume = value
    }
}
