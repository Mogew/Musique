import UIKit

class HomeViewController: UIViewController {
    
    let sections = MOKSections
    private var collectionView: UICollectionView!
    
    // 1 par - section, 2 par - item
    var dataSource: UICollectionViewDiffableDataSource<Section, SongModel>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.mDarkBlue
        setupCollectionView()
        createDataSource()
        reloadData()
    }
}

extension HomeViewController {
    
    func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds,
                                              collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)
        collectionView.register(RecentlyMusicCell.self, forCellWithReuseIdentifier: RecentlyMusicCell.id)
        collectionView.register(NewSongsCell.self, forCellWithReuseIdentifier: NewSongsCell.id)
        collectionView.register(PopularAlbumCell.self, forCellWithReuseIdentifier: PopularAlbumCell.id)
        collectionView.register(SectionHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: SectionHeaderView.id)
        collectionView.showsVerticalScrollIndicator = false
    }
    
    func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, SongModel>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            switch self.sections[indexPath.section].type {
            case NewSongsCell.id:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewSongsCell.id, for: indexPath) as? NewSongsCell
                cell?.configure(with: itemIdentifier)
                return cell
            case PopularAlbumCell.id:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularAlbumCell.id, for: indexPath) as? PopularAlbumCell
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentlyMusicCell.id, for: indexPath) as? RecentlyMusicCell
                cell?.configure(with: itemIdentifier)
                return cell
            }
        })
        dataSource?.supplementaryViewProvider = { [weak self]
            collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.id, for: indexPath) as? SectionHeaderView else {return nil}
            guard let curentSection = self?.dataSource?.itemIdentifier(for: indexPath) else {return nil}
            guard let section = self?.dataSource?.snapshot().sectionIdentifier(containingItem: curentSection) else {return nil}
            if section.title.isEmpty {
                return nil
            }
            else {
                sectionHeader.title.text = section.title
            }
            return sectionHeader
        }
    }
    
    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, SongModel>()
        snapshot.appendSections(MOKSections)
        
        for section in MOKSections {
            snapshot.appendItems(section.items, toSection: section)
            
        }
        dataSource?.apply(snapshot)
    }
    
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let section = self.sections[sectionIndex]
            
            switch section.type {
            case NewSongsCell.id:
                return self.createNewSongsSection()
            case PopularAlbumCell.id:
                return self.createPopularAlbumSection()
            default:
                return self.createRecentlyPlayedSection()
            }
        }
        return layout
    }
    
    func createNewSongsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalWidth(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 17)
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(148), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 12, leading: 16, bottom: 0, trailing: 16)
        
        let header = createSectionHeader()
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    func createPopularAlbumSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .absolute(200))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0,
                                                          bottom: 10, trailing: 0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .estimated(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 12, leading: 16, bottom: 0, trailing: 16)
        
        let header = createSectionHeader()
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    // section -> group -> items -> size
    func createRecentlyPlayedSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(60))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0,
                                                          bottom: 10, trailing: 0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .estimated(1))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 12, leading: 16, bottom: 0, trailing: 16)
        
        let header = createSectionHeader()
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem{
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .estimated(1))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize,
                                                                        elementKind: UICollectionView.elementKindSectionHeader,
                                                                        alignment: .top)
        return sectionHeader
    }
}
