import Foundation
import UIKit

class TopicDetailsViewController : UIViewController {
    
    let source = MOKGEnres
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        setup()
        super.viewDidLoad()
        view.backgroundColor = .black
    }
    
    func setup() {
        collectionView = UICollectionView(frame: .zero , collectionViewLayout: setupFlowLayout())
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        collectionView.dataSource = self
        
        collectionView.register(TopicDetailsCell.self, forCellWithReuseIdentifier: TopicDetailsCell.id)
    }

    func setupFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = .init(width: da(), height: 155)
        
        func da() -> Int {
            let width = itemWidth(for: view.frame.width, spacing: 20)
            return Int(width)
        }

        func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
            let totalSpasing: CGFloat = 3 * spacing
            let finalWidth = (width - totalSpasing) / 2
            return finalWidth
        }
        // отступ
        layout.sectionInset = .init(top: 32, left: 20, bottom: 36, right: 20)
        //расстояние между ячейками
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        return layout
    }
}

extension TopicDetailsViewController: UICollectionViewDataSource {
    // number of cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return source.count
    }
    //set up cell in collection
    func  collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopicDetailsCell.id, for: indexPath) as? TopicDetailsCell else {return UICollectionViewCell()}
        
        return cell
    }
    @objc func addToCollection(button: UIButton) {
        
    }
    
}

