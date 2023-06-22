import Foundation

struct APIRequest: DataRequest {
    func decode(_ data: Data) throws -> RealHomeModel {
        let decoder = JSONDecoder()
        return try decoder.decode(Response.self, from: data)
    }
    
    init(q: String, limit: Int, artist: String) {
        self.searchText = q
        self.limit = String(limit)
        self.artist = artist
    }
    
    typealias Response = RealHomeModel
    
    var searchText: String
    var artist: String
    var limit: String
    
    var url: String {
        let baseUrl = "https://itunes.apple.com/"
        let path = "search"
        return baseUrl + path
    }
    
    var queryItems: [String : String] {
        [
            "?term": searchText,
            "&limit": limit,
            "&atribute": artist
        ]
    }
    
    var method: HTTPMethod {
        .get
    }
    
    func decode(_ data: Data) throws -> RealHomeModel? {
        let decoder = JSONDecoder()
        
        let response = try decoder.decode(RealHomeModel.self, from: data)
        return response
    }
}
