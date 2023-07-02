import Foundation
import UIKit

struct SearchCategoryModel {
    
    var category: String
    var type: SearchType?
    
    static func makeMockModel() -> [SearchCategoryModel] {[
        SearchCategoryModel(category: "All", type: .song),
        SearchCategoryModel(category: "Artist", type: .musicArtist),
        SearchCategoryModel(category: "Album", type: .album),
        SearchCategoryModel(category: "Song", type: .song),
    ]}
}

struct SearchResponseModel: Decodable {
    let results: [SearchTracks]
}

struct SearchTracks: Decodable, Hashable {
    let artistName: String?
    let collectionName: String?
    let trackName: String?
    let previewUrl: String?
    let artworkUrl30: String?
    let artworkUrl60: String?
    let artworkUrl100: String?
    let artistViewUrl: String?
}
