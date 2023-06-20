import UIKit

public struct Section: Hashable {
    let type: String
    let title: String
    let items: [SongModel]
}

public var MOKSections: [Section] = [
    Section(type: "newSongs", title: "New Songs", items: MOKModel),
    Section(type: "popularAlbum", title: "Popular Album", items: [SongModel(image: UIImage(named: "Test Image")!, name: "Nice For What", artist: "Avinci John", type: "Single")]),
    Section(type: "recentlyplayed", title: "Recently played", items: MOKModel2)
]

public struct SongModel: Hashable {
    let image: UIImage
    let name: String
    let artist: String
    let type: String
}

public var MOKModel = [
    SongModel(image: UIImage(named: "Test Image")!, name: "Nice For What", artist: "Avinci John", type: "Single"),
    SongModel(image: UIImage(named: "Test Image")!, name: "Where can i get some", artist: "Arian Grande", type: "Single"),
    SongModel(image: UIImage(named: "Test Image")!, name: "Love Story", artist: "Taylor Swift", type: "Album"),
    SongModel(image: UIImage(named: "Test Image")!, name: "Save Your Tears", artist: "The Weeknd", type: "Single"),
    SongModel(image: UIImage(named: "Test Image")!, name: "Why do we use it", artist: "Alan Walker", type: "Single"),
    SongModel(image: UIImage(named: "Test Image")!, name: "... ", artist: "Alan Walker", type: "Single"),
]
public var MOKModel2 = [
    SongModel(image: UIImage(named: "Test Image")!, name: "USTAL1", artist: "Avinci John", type: "Single"),
    SongModel(image: UIImage(named: "Test Image")!, name: "USTAL2", artist: "Arian Grande", type: "Single"),
    SongModel(image: UIImage(named: "Test Image")!, name: "USTAL3", artist: "Taylor Swift", type: "Album"),
    SongModel(image: UIImage(named: "Test Image")!, name: "USTAL4", artist: "The Weeknd", type: "Single"),
    SongModel(image: UIImage(named: "Test Image")!, name: "USTAL5", artist: "Alan Walker", type: "Single")
]

