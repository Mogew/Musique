//
//  SearchCategoryCollectionView.swift
//  Musique
//
//  Created by Marat Guseynov on 13.06.2023.
//

import UIKit

class SearchCategoryCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
 
    var cells = [SearchCategoryModel]()

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        backgroundColor = .mBlack
        delegate = self
        dataSource = self
        translatesAutoresizingMaskIntoConstraints = false
        register(SearcCategoryCollectionViewCell.self, forCellWithReuseIdentifier: SearcCategoryCollectionViewCell.reuseID)
        showsHorizontalScrollIndicator = false
    }
    
    func set(cells: [SearchCategoryModel]) {
        self.cells = cells
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: SearcCategoryCollectionViewCell.reuseID, for: indexPath) as! SearcCategoryCollectionViewCell
        cell.categoryTitleLabel.text = cells[indexPath.row].category
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel()
        label.text = cells[indexPath.row].category
        label.sizeToFit()
        return CGSize(width: label.frame.width + 30, height: 40)
//        return CGSize(width: 100, height: 40)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
