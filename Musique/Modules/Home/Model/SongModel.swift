import UIKit


struct RealHomeModel: Decodable {
    let results: [SearchTracks]
}

struct RequestResult: Decodable, Hashable {
    let artistName: String
    let trackName: String
    let previewUrl: String
    let artworkUrl100:String
}


struct Section: Hashable {
    let type: String
    let title: String
    let items: [SearchTracks]
}

//public var MOKSections: [Section] = [
//    Section(type: "newSongs", title: "New Songs", items: []),
//    Section(type: "popularAlbum", title: "Popular Album", items: []),
//    Section(type: "recentlyplayed", title: "Recently played", items: [])
//]

struct SongModel1 {
    func check(with title: String) -> Bool {
        switch title {
        case "Recently played":
            return true
        case "Popular Album":
            return true
        default:
            return false
        }
    }
}


