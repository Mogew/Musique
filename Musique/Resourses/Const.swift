//
//  Const.swift
//  Musique
//
//  Created by sidzhe on 26.06.2023.
//

import UIKit

//MARK: - Constants for PlayerVC, PlaylistVC, AlbumVC

enum Const {
    enum Text {
        static let empty = " "
        static let cell = "cell"
        static let tableCell = "tableCell"
        static let format = "%02d:%02d"
        static let size100 = "100x100"
        static let size300 = "300x300"
        static let size600 = "600x600"
        static let zeroTime = "00:00"
        static let emptyTime = "--:--"
        static let cellList = "cellList"
        static let playlist = "Playlist"
        static let addNewPlist = "Add new playlist"
        static let cellTextPart1 = "This artist is"
        static let cellTextPart2 = ", if you want to know more about that person you can look here"
        static let suggestion = "Suggestion"
        static let addSong = "Add this song to My Playlist"
        static let downloadSong = "Downloading 128Kbps for this song"
        static let itIsLong = "It is a long established fact that a reader"
        static let lookHere = "look here"
    }
    
    enum Images {
        static let ellipsePlay = UIImage(named: "EllipsePlay") ?? UIImage()
        static let pauseFill = UIImage(systemName: "pause.fill") ?? UIImage()
        static let pageImage = UIImage(named: "activePage") ?? UIImage()
        static let ellipse = UIImage(named: "Ellipse") ?? UIImage()
        static let speaker = UIImage(systemName: "speaker") ?? UIImage()
        static let speakerWave = UIImage(systemName: "speaker.wave.3") ?? UIImage()
        static let slider = UIImage(named: "slider") ?? UIImage()
        static let background = UIImage(named: "background") ?? UIImage()
        static let shuffle = UIImage(systemName: "shuffle") ?? UIImage()
        static let back = UIImage(named: "back") ?? UIImage()
        static let forward = UIImage(named: "forward") ?? UIImage()
        static let repeatImage = UIImage(systemName: "repeat") ?? UIImage()
        static let shared = UIImage(named: "shared") ?? UIImage()
        static let addLibr = UIImage(named: "addLibr") ?? UIImage()
        static let heart = UIImage(systemName: "heart") ?? UIImage()
        static let download = UIImage(named: "download") ?? UIImage()
        static let playFill = UIImage(systemName: "play.fill") ?? UIImage()
        static let heartFill = UIImage(systemName: "heart.fill") ?? UIImage()
        static let line = UIImage(named: "line") ?? UIImage()
        static let point = UIImage(named: "point") ?? UIImage()
        static let link = UIImage(systemName: "link.circle.fill") ?? UIImage()
        static let playpauseFill = UIImage(systemName: "playpause.fill") ?? UIImage()
        static let forwardFill = UIImage(systemName: "forward.fill") ?? UIImage()
    }
}
