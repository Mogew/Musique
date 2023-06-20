import UIKit

class TopicDetailsCell: UICollectionViewCell {
    static var id = "topicDetails"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with data: SongModel) {

    }
    
    private func setupConstraints() {
        self.backgroundColor = .red
    }
}
