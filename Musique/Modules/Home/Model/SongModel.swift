import UIKit


struct RealHomeModel: Decodable {
    let results: [RequestResult]
}

struct RequestResult: Decodable, Hashable {
    let artistName: String
    let trackName: String
    let artistViewUrl: String
    let previewUrl: String
    let artworkUrl100:String
    let releaseDate: String
}


struct Section: Hashable {
    let type: String
    let title: String
    let items: [RequestResult]
}

let MOKData: [RequestResult] = [
    RequestResult(artistName: "DA", trackName: "O", artistViewUrl: "", previewUrl: "", artworkUrl100: "", releaseDate: "")
]

let MOKData2: [RequestResult] = [
    RequestResult(artistName: "POP", trackName: "IT", artistViewUrl: "", previewUrl: "", artworkUrl100: "", releaseDate: "")
]

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


