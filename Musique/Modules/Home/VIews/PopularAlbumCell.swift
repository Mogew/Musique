import UIKit

final class PopularAlbumCell: UICollectionViewCell {
    static var id = "popularAlbum"
    
    let image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "popularMusic")
        return image
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupConstraints() {
        addSubview(image)
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: self.topAnchor),
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            image.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

