import Foundation

struct SearchDataRequest: DataRequest {
    typealias Response = SearchResponseModel
    
    var term: String
    
    var type: SearchType
    
    var url: String {
        let baseUrl = "https://itunes.apple.com/"
        let path = "search"
        return baseUrl + path
    }
    
    init(term: String, type: SearchType) {
        self.term = term
        self.type = type
    }
    
    var queryItems: [String : String] {
        [
            "term": term,
            "entity": type.rawValue,
            "limit": "15",
            "media": "music"
        ]
    }
    
    var method: HTTPMethod {
        .get
    }
}

//MARK: - SearchType
enum SearchType: String {
    case mix = ""
    case musicArtist
    case album
    case song
}
