//
//  SearchCategoryTableViewCell.swift
//  Musique
//
//  Created by Marat Guseynov on 14.06.2023.
//

import UIKit
import Kingfisher

class SearchCategoryTableViewCell: UITableViewCell {
    
    static let reuseID = "SearchCategoryTableViewCell"
    
    var cellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .mDarkBlue
        view.clipsToBounds = true
        return view
    }()
    
    let artistImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 3
        image.backgroundColor = .mGray
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let songNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 1
        label.textColor = .white
        return label
    }()
    
    let artistNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 1
        label.textColor = .systemGray
        return label
    }()
    
    let dotsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 1
        label.textColor = .white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addviewLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        artistImage.image = nil
    }
    
    func configureCell(title: String,
                       subtitle: String,
                       imageUrlString: String?) {
        artistNameLabel.text = subtitle
        songNameLabel.text = title
        
        let url = URL(string: imageUrlString ?? "")
        artistImage.kf.setImage(with: url, placeholder: UIImage(systemName: "person.fill")?.withTintColor(.mLime))
    }
    
    private func addviewLayout() {
        contentView.addSubview(cellView)
        cellView.addSubview(songNameLabel)
        cellView.addSubview(artistImage)
        cellView.addSubview(artistNameLabel)
        cellView.addSubview(dotsLabel)
        
        NSLayoutConstraint.activate([
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            artistImage.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 17),
            artistImage.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 24),
            artistImage.heightAnchor.constraint(equalToConstant: 40),
            artistImage.widthAnchor.constraint(equalToConstant: 40),
            
            songNameLabel.topAnchor.constraint(equalTo: artistImage.topAnchor),
            songNameLabel.leadingAnchor.constraint(equalTo: artistImage.trailingAnchor, constant: 16),
            
            artistNameLabel.bottomAnchor.constraint(equalTo: artistImage.bottomAnchor),
            artistNameLabel.leadingAnchor.constraint(equalTo: artistImage.trailingAnchor, constant: 16),
            
            dotsLabel.bottomAnchor.constraint(equalTo: cellView.centerYAnchor),
            dotsLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -28),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
