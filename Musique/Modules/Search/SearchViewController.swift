//
//  SearchViewController.swift
//  Musique
//
//  Created by Marat Guseynov on 12.06.2023.
//

import UIKit

class SearchViewController: UIViewController {
    
    private let categoryCollectionView = SearchCategoryCollectionView()
    private let categoryTableView = SearchCategoryTableView()
    
    //MARK: - Searcbar config
    private lazy var searchBar: UISearchBar = {
        let searchbar = UISearchBar()
        searchbar.translatesAutoresizingMaskIntoConstraints = false
        searchbar.delegate = self
        searchbar.barTintColor = .mBlack
        searchbar.tintColor = .mLime
        searchbar.showsCancelButton = false
        return searchbar
    }()
    
    private func addViewLayout() {
        
        [searchBar, categoryCollectionView, categoryTableView].forEach {
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            categoryCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 40),
            categoryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            categoryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: 40),
            
            categoryTableView.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor, constant: 20),
            categoryTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoryTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoryTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mBlack
        
        addViewLayout()
        categoryCollectionView.set(cells: SearchCategoryModel.makeMockModel())
        categoryTableView.setTableView(cells: SearchCategoryModel.makeMockModel())
    }
}

//MARK: - Searcbar config
extension SearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }
}

