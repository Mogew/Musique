//
//  SearchCategoryTableViewCell.swift
//  Musique
//
//  Created by Marat Guseynov on 14.06.2023.
//

import UIKit

class SearchCategoryTableViewCell: UITableViewCell {

    static let reuseID = "SearchCategoryTableViewCell"
    
    var tableCellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        view.clipsToBounds = true
        return view
    }()
    
    let tableTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 1
        label.textColor = .white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addviewLayout()
    }
    
    private func addviewLayout() {
        contentView.addSubview(tableCellView)
        tableCellView.addSubview(tableTitleLabel)
        
        NSLayoutConstraint.activate([
            tableCellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableCellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tableCellView.topAnchor.constraint(equalTo: contentView.topAnchor),
            tableCellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            tableTitleLabel.topAnchor.constraint(equalTo: tableCellView.topAnchor, constant: 10),
            tableTitleLabel.leadingAnchor.constraint(equalTo: tableCellView.leadingAnchor, constant: 10),
            tableTitleLabel.trailingAnchor.constraint(equalTo: tableCellView.trailingAnchor, constant: -10),
            tableTitleLabel.bottomAnchor.constraint(equalTo: tableCellView.bottomAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
