//
//  SearchCategoryCollectionView.swift
//  Musique
//
//  Created by Marat Guseynov on 13.06.2023.
//

import UIKit

class SearchCategoryCollectionView: UICollectionView {
    
    var cells = [SearchCategoryModel]()
    var selectedIndexPath: IndexPath?
    
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
        selectedIndexPath = IndexPath(item: 0, section: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(cells: [SearchCategoryModel]) {
        self.cells = cells
    }
}

extension SearchCategoryCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = dequeueReusableCell(withReuseIdentifier: SearcCategoryCollectionViewCell.reuseID, for: indexPath) as! SearcCategoryCollectionViewCell
        cell.categoryTitleLabel.text = cells[indexPath.row].category
        if indexPath == selectedIndexPath {
            cell.categoryCellView.backgroundColor = .systemGray3
        } else {
            cell.categoryCellView.backgroundColor = .mBlack
        }
        return cell
    }
}

extension SearchCategoryCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel()
        label.text = cells[indexPath.row].category
        label.sizeToFit()
        return CGSize(width: label.frame.width + 30, height: 40)
    }
}

extension SearchCategoryCollectionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedIndexPath == indexPath {
            return
        }
        if let cell = collectionView.cellForItem(at: indexPath) as? SearcCategoryCollectionViewCell {
            cell.categoryCellView.backgroundColor = .systemGray3
        }
        if let cell = collectionView.cellForItem(at: selectedIndexPath ?? indexPath) as? SearcCategoryCollectionViewCell {
            cell.categoryCellView.backgroundColor = .mBlack
        }
        selectedIndexPath = indexPath
    }
}
