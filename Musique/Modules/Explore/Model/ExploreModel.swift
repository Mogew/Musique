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

struct TopicModel: Hashable {
    let genreName: String
    let subGenres: [SubGenre]
}
struct SubGenre: Hashable {
    let subGenreName: String
    let subGenreSongs: [SongModel]
}

let exploreMOKSections = [
    Section(type: RecentlyMusicCell.id, title: "Recently played", items: MOKModel2),
    Section(type: TopTrendingCell.id, title: "Top Trending", items: [
        SongModel(image: UIImage(named: "Test Image")!, name: "Fake",
                  artist: "Five Fingers Death Punch", type: "Single"),
        SongModel(image: UIImage(named: "Test Image")!, name: "Lover Boy",
                  artist: "Dora", type: "Single"),
        SongModel(image: UIImage(named: "Test Image")!, name: "Levitation",
                  artist: "Dua Lipa", type: "Single")
    ]),
    Section(type: TopicCell.id, title: "Topic", items: MOKModel)
]

//
//let exploreTopicData = [
//    TopicModel(genreName: <#T##String#>, subGenres: <#T##[SubGenre]#>)
//]
//
//let exploreSubGenresData = [
//    SubGenre(subGenreName: <#T##String#>, subGenreSongs: MOKModel)
//]
