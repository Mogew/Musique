import UIKit

struct ExploreModel {
    func checkSection(with title: String) -> Bool{
        switch title {
        case "Recently played":
            return true
        case "Top Trending":
            return true
        default:
            return false
        }
    }
}

struct SongModel: Hashable {
    let image: UIImage
    let name: String
    let artist: String
    let type: String
}

struct TopicModel: Hashable {
    let genreName: String
    let subGenres: [SubGenre]
}
struct SubGenre: Hashable {
    let subGenreName: String
    let subGenreSongs: [SongModel]
}
struct Section1: Hashable {
    let type: String
    let title: String
    let items: [SongModel]
}

let exploreMOKSections = [
    Section1(type: RecentlyMusicCell.id, title: "Recently played", items: [SongModel(image: UIImage(named: "Test Image")!, name: "Fake",
                                artist: "Five Fingers Death Punch", type: "Single")]),
    Section1(type: TopTrendingCell.id, title: "Top Trending", items: [
        SongModel(image: UIImage(named: "Test Image")!, name: "Fake",
                  artist: "Five Fingers Death Punch", type: "Single"),
        SongModel(image: UIImage(named: "Test Image")!, name: "Lover Boy",
                  artist: "Dora", type: "Single"),
        SongModel(image: UIImage(named: "Test Image")!, name: "Levitation",
                  artist: "Dua Lipa", type: "Single")
    ]),
    Section1(type: TopicCell.id, title: "Topic", items: [SongModel(image: UIImage(named: "Test Image")!, name: "Fake",artist: "Five Fingers Death Punch", type: "Single")])
]

//
//let exploreTopicData = [
//    TopicModel(genreName: <#T##String#>, subGenres: <#T##[SubGenre]#>)
//]
//
//let exploreSubGenresData = [
//    SubGenre(subGenreName: <#T##String#>, subGenreSongs: MOKModel)
//]
