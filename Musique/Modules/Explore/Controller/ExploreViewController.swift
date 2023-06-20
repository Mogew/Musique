import UIKit

class ExploreViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    let sections = exploreMOKSections
    let model = ExploreModel()
    var songCount = 1
    let CountRange = 1...9
    
    var dataSource: UICollectionViewDiffableDataSource<Section, SongModel>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mDarkBlue
        setupCollectionView()
        createDataSource()
        reloadData()
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds,
                                          collectionViewLayout: createCompositionalLayout())
        collectionView.backgroundColor = .mDarkBlue
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)
        collectionView.register(RecentlyMusicCell.self, forCellWithReuseIdentifier: RecentlyMusicCell.id)
        collectionView.register(TopTrendingCell.self, forCellWithReuseIdentifier: TopTrendingCell.id)
        collectionView.register(TopicCell.self, forCellWithReuseIdentifier: TopicCell.id)
        collectionView.register(SectionHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: SectionHeaderView.id)
        collectionView.showsVerticalScrollIndicator = false
    }
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout{
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layOutEnvironment in
            let section = self.sections[sectionIndex]
            
            switch section.type {
            case RecentlyMusicCell.id:
                return self.createRecentlyMusicSection()
            case TopTrendingCell.id:
                return self.createTopTrendingSection()
            default:
                return self.createTopicSection()
            }
        }
        return layout
    }
    
    private func createRecentlyMusicSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(60))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0,
                                                          bottom: 10, trailing: 0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .estimated(1))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 16, bottom: 0, trailing: 16)
        
        let header = createSectionHeader()
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    private func createTopTrendingSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(200))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0,
                                                          bottom: 0, trailing: 0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .estimated(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 24, bottom: 0, trailing: 24)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        let header = createSectionHeader()
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    private func createTopicSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 8, leading: 8,
                                                          bottom: 8, trailing: 8)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(0.09))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 24, bottom: 0, trailing: 24)
        let header = createSectionHeader()
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .absolute(60))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize,
                                                            elementKind: UICollectionView.elementKindSectionHeader,
                                                            alignment: .top)
        return sectionHeader
    }
    
}

//MARK: - DataSource
extension ExploreViewController {
    
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, SongModel>(collectionView: collectionView, cellProvider: {
            collecitonView, indexPath, itemIdentifier in
            switch self.sections[indexPath.section].type {
            case RecentlyMusicCell.id:
                let cell = collecitonView.dequeueReusableCell(withReuseIdentifier: RecentlyMusicCell.id, for: indexPath) as? RecentlyMusicCell
                cell?.configure(with: itemIdentifier)
                if self.CountRange.contains(self.songCount) {
                    cell?.number.text = "0" + "\(self.songCount)"
                } else {
                    cell?.number.text = "\(self.songCount)"
                }
                self.songCount += 1
                return cell!
            case TopTrendingCell.id:
                let cell = collecitonView.dequeueReusableCell(withReuseIdentifier: TopTrendingCell.id, for: indexPath) as? TopTrendingCell
                cell?.configure(with: itemIdentifier)
                return cell
            default:
                let cell = collecitonView.dequeueReusableCell(withReuseIdentifier: TopicCell.id, for: indexPath) as? TopicCell
                cell?.configure(with: itemIdentifier)
                return cell
            }
        })
        
        dataSource?.supplementaryViewProvider = { [weak self]
            collectionVIew, kind, indexPath in
            guard let sectionHeader = self?.collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.id, for: indexPath) as? SectionHeaderView else {return nil}
            guard let curentSection = self?.dataSource?.itemIdentifier(for: indexPath) else {return nil}
            guard let section = self?.dataSource?.snapshot().sectionIdentifier(containingItem: curentSection) else {return nil}
            if section.title.isEmpty {
                return nil
            }
            else {
                sectionHeader.title.text = section.title
                self?.check(header: sectionHeader)
            }

            return sectionHeader
        }
    }
    
    func check (header: SectionHeaderView) {
        if model.checkSection(with: header.title.text!) {
            header.viewAllLabel.isHidden = true
        }
    }
    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, SongModel>()
        snapshot.appendSections(exploreMOKSections)
        
        for section in exploreMOKSections {
            snapshot.appendItems(section.items, toSection: section)
            
        }
        dataSource?.apply(snapshot)
    }
}

