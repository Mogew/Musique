//
//  SearchCollectionViewCell.swift
//  Musique
//
//  Created by Marat Guseynov on 12.06.2023.
//

import UIKit

class SearcCategoryCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "SearcCategoryCollectionViewCell"
    
    private let categoryCellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.backgroundColor = .systemGray5
        view.clipsToBounds = true
        return view
    }()
    
     let categoryTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(categoryCellView)
        categoryCellView.addSubview(categoryTitleLabel)
        
        NSLayoutConstraint.activate([
            categoryCellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            categoryCellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            categoryCellView.topAnchor.constraint(equalTo: contentView.topAnchor),
            categoryCellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            categoryTitleLabel.topAnchor.constraint(equalTo: categoryCellView.topAnchor, constant: 10),
            categoryTitleLabel.leadingAnchor.constraint(equalTo: categoryCellView.leadingAnchor, constant: 10),
            categoryTitleLabel.trailingAnchor.constraint(equalTo: categoryCellView.trailingAnchor, constant: -10),
            categoryTitleLabel.bottomAnchor.constraint(equalTo: categoryCellView.bottomAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
