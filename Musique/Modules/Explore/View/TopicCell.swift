import UIKit

final class TopicCell: UICollectionViewCell {
    static let id = "topic"
    
    let image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let label: UILabel = {
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
        //image.image = data.artworkUrl100
        label.text = data.name
    }
    
    private func setupConstraints() {
        addSubview(image)
        addSubview(label)
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: self.topAnchor),
            image.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            
        ])
    }
}
