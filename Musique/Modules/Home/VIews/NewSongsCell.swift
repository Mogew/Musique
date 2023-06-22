import UIKit
import Kingfisher

class NewSongsCell: UICollectionViewCell {
    static var id = "newSongs"
    
    let image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    let songName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor.mWhite
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let artist: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.mGray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with data: RequestResult) {
        let url = URL(string: data.artworkUrl100)
        image.kf.setImage(with: url)
        songName.text = data.trackName
        artist.text = data.artistName
    }
    
    func setupConstraints() {
        addSubview(songName)
        addSubview(artist)
        addSubview(image)
        
        NSLayoutConstraint.activate([
            // image
            image.widthAnchor.constraint(equalToConstant: 148),
            image.heightAnchor.constraint(equalToConstant: 148),
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            image.topAnchor.constraint(equalTo: self.topAnchor),
            image.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            // songName
            songName.topAnchor.constraint(equalTo: image.bottomAnchor,
                                         constant: 8),
            songName.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            songName.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            //artist
            artist.topAnchor.constraint(equalTo: songName.bottomAnchor,
                                         constant: 8),
            artist.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            artist.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
}

