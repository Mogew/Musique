//
//  TrackModel.swift
//  Musique
//
//  Created by sidzhe on 22.06.2023.
//

import Foundation

//MARK: - Api Model

struct MusicModel: Codable {
    var resultCount: Int
    var results: [Track]
}

struct Track: Codable {
    var trackName: String
    var collectionName: String?
    var artistName: String
    var artworkUrl100: String?
    var previewUrl: String?
}
