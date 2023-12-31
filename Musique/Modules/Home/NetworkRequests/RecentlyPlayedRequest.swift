struct RecentlyPlayedRequest: DataRequest {
    typealias Response = RealHomeModel
    
    var url: String {
        let baseUrl = "https://itunes.apple.com/"
        let path = "search"
        return baseUrl + path
    }
    
    var queryItems: [String : String] {
        [
            "attribute": "ratingIndex",
            "entity": "song",
            "country": "ru",
            "limit": "5"
        ]
    }
    
    var method: HTTPMethod {
        .get
    }
}
