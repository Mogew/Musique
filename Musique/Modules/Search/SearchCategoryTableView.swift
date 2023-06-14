//
//  SearchCategoryTableView.swift
//  Musique
//
//  Created by Marat Guseynov on 14.06.2023.
//

import UIKit

class SearchCategoryTableView: UITableView {
    
    var cellsTableView = [SearchCategoryModel]()
    var selectedIndexPath: IndexPath?
    
    init() {
        super.init(frame: .zero, style: .plain)
        backgroundColor = .mBlack
        delegate = self
        dataSource = self
        translatesAutoresizingMaskIntoConstraints = false
        super.register(SearchCategoryTableViewCell.self, forCellReuseIdentifier: SearchCategoryTableViewCell.reuseID)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTableView(cells: [SearchCategoryModel]) {
        self.cellsTableView = cells
    }
}

extension SearchCategoryTableView: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsTableView.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchCategoryTableViewCell.reuseID, for: indexPath) as! SearchCategoryTableViewCell
        
        cell.tableTitleLabel.text = cellsTableView[indexPath.row].category
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension SearchCategoryTableView: UITableViewDelegate {
    
}
