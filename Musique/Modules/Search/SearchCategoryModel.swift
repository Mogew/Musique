//
//  SearchCategoryModel.swift
//  Musique
//
//  Created by Marat Guseynov on 13.06.2023.
//

import Foundation

struct SearchCategoryModel {
    
    var category: String
    
    static func makeMockModel() -> [SearchCategoryModel] {[
        SearchCategoryModel(category: "All"),
        SearchCategoryModel(category: "Artist"),
        SearchCategoryModel(category: "Album"),
        SearchCategoryModel(category: "Song"),
        SearchCategoryModel(category: "Playlist"),
    ]}
}
