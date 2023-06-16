import Foundation

struct SearchDataRequest: DataRequest {
    func decode(_ data: Data) throws -> SearchCategoryModel {
        let decoder = JSONDecoder()
        return try decoder.decode(Response.self, from: data)
    }
    
    init(q: String, type: SearchType) {
        self.searchText = q
        self.type = type
    }
    
    typealias Response = SearchCategoryModel
    
    var searchText: String
    
    var type: SearchType
    
    var url: String {
        let baseUrl = "https://spotify23.p.rapidapi.com/"
        let path = "search/"
        return baseUrl + path
    }
    
    var headers: [String : String] {
        [
            "X-RapidAPI-Key": "718cb90288mshcb528169432614fp1b6728jsn21a94ffc61da",
            "X-RapidAPI-Host": "spotify23.p.rapidapi.com"
        ]
    }
    
    var queryItems: [String : String] {
        [
            "q": searchText,
            "type": "multi"
        ]
    }
    
    var method: HTTPMethod {
        .get
    }
    
    func decode(_ data: Data) throws -> SearchCategoryModel? {
        let decoder = JSONDecoder()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        let response = try decoder.decode(SearchCategoryModel.self, from: data)
        return response
    }
}

//MARK: - SearchType
enum SearchType {
    case multi
}
