//
//  SearchCategoryModel.swift
//  Musique
//
//  Created by Marat Guseynov on 13.06.2023.
//

import Foundation
import UIKit

struct SearchCategoryModel: Decodable {
    
    var category: String
    var songName: String
    var artistName: String
    var image: UIImage
    var dots: String
    
    static func makeMockModel() -> [SearchCategoryModel] {[
        SearchCategoryModel(category: "All", songName: "Song Name", artistName: "Artist Name", image: UIImage(named: "tableViewTestImage")!, dots: "..."),
        SearchCategoryModel(category: "Artist", songName: "Song Name", artistName: "Artist Name", image: UIImage(named: "tableViewTestImage")!, dots: "..."),
        SearchCategoryModel(category: "Album", songName: "Song Name", artistName: "Artist Name", image: UIImage(named: "tableViewTestImage")!, dots: "..."),
        SearchCategoryModel(category: "Song", songName: "Song Name", artistName: "Artist Name", image: UIImage(named: "tableViewTestImage")!, dots: "..."),
        SearchCategoryModel(category: "Playlist", songName: "Song Name", artistName: "Artist Name", image: UIImage(named: "tableViewTestImage")!, dots: "..."),
    ]}
}
