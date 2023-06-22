import UIKit

class RecentlyMusicCell: UICollectionViewCell {
    
    static let id = "recentlyplayed"
    
    let image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    let songName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let artist: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let number: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let playButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "playButton"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        addSubview(number)
        addSubview(playButton)
        addSubview(artist)
        addSubview(image)
        
        NSLayoutConstraint.activate([
        // nuber
            number.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            number.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            number.widthAnchor.constraint(equalToConstant: 20),
            // image
            image.widthAnchor.constraint(equalToConstant: 36),
            image.heightAnchor.constraint(equalToConstant: 36),
            image.leadingAnchor.constraint(equalTo: number.trailingAnchor,
                                           constant: 20),
            image.topAnchor.constraint(equalTo: self.topAnchor,
                                      constant: 4),
            //songName
            songName.leadingAnchor.constraint(equalTo: image.trailingAnchor,
                                             constant: 16),
            songName.topAnchor.constraint(equalTo: self.topAnchor),
            songName.bottomAnchor.constraint(equalTo: artist.topAnchor,
                                            constant: 4),
            // artist
            artist.leadingAnchor.constraint(equalTo: image.trailingAnchor,
                                             constant: 16),
            artist.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            //button
            playButton.heightAnchor.constraint(equalToConstant: 16),
            playButton.widthAnchor.constraint(equalToConstant: 16),
            playButton.topAnchor.constraint(equalTo: self.topAnchor,
                                           constant: 8),
            playButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                constant: -10)
        ])
    }
    
}

