import UIKit

class TopTrendingCell: UICollectionViewCell {
    static let id = "topTrending"
    
    
    let image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    let songNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textColor = .mWhite
        return label
    }()
    let artistLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .mWhite
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with data: SongModel) {
      //  image.image = data.artworkUrl100
        songNameLabel.text = data.name
        artistLabel.text = data.artist
    }
    
    private func setupConstraints() {
        addSubview(image)
        addSubview(songNameLabel)
        addSubview(artistLabel)
        NSLayoutConstraint.activate([
            //image
            image.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            image.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            image.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            // artist name
            artistLabel.topAnchor.constraint(equalTo: songNameLabel.bottomAnchor),
            artistLabel.leadingAnchor.constraint(equalTo: image.leadingAnchor, constant: 16),
            artistLabel.bottomAnchor.constraint(equalTo: image.bottomAnchor, constant: -16),
            // song name
            songNameLabel.leadingAnchor.constraint(equalTo: image.leadingAnchor,
                                                   constant: 16),
        ])
    }
}
