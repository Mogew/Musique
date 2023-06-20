import UIKit

class HomeViewController: UIViewController {
    
    let sections = MOKSections
    private var collectionView: UICollectionView!
    private let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
    var model = SongModel1()
    var songCount = 1
    let CountRange = 1...9
    
    // 1 par - section, 2 par - item
    var dataSource: UICollectionViewDiffableDataSource<Section, SongModel>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.mDarkBlue
        setupCollectionView()
        createDataSource()
        reloadData()
        setupButton()
    }
}

extension HomeViewController {
    
    func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds,
                                              collectionViewLayout: createCompositionalLayout())
        collectionView.backgroundColor = .mDarkBlue
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
                return cell!
            case PopularAlbumCell.id:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularAlbumCell.id, for: indexPath) as? PopularAlbumCell
                return cell!
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentlyMusicCell.id, for: indexPath) as? RecentlyMusicCell
                cell?.configure(with: itemIdentifier)
                if self.CountRange.contains(self.songCount) {
                    cell?.number.text = "0" + "\(self.songCount)"
                } else {
                    cell?.number.text = "\(self.songCount)"
                }
                self.songCount += 1
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
                self?.check(header: sectionHeader)
            }
            return sectionHeader
        }
    }
    
    func check (header: SectionHeaderView) {
        if model.check(with: header.title.text!) {
            header.viewAllLabel.isHidden = true
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
                                                       heightDimension: .absolute(60))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize,
                                                                        elementKind: UICollectionView.elementKindSectionHeader,
                                                                        alignment: .top)
        return sectionHeader
    }
}

//MARK: - navBar button
extension HomeViewController {
    private func showImage(_ show: Bool) {
      UIView.animate(withDuration: 0.4) {
        self.imageView.alpha = show ? 1.0 : 0.0
      }
    }
    
    private struct Const {
      /// Image height/width for Large NavBar state
      static let ImageSizeForLargeState: CGFloat = 40
      /// Margin from right anchor of safe area to right anchor of Image
      static let ImageRightMargin: CGFloat = 16
      /// Margin from bottom anchor of NavBar to bottom anchor of Image for Large NavBar state
      static let ImageBottomMarginForLargeState: CGFloat = 12
      /// Margin from bottom anchor of NavBar to bottom anchor of Image for Small NavBar state
      static let ImageBottomMarginForSmallState: CGFloat = 6
      /// Image height/width for Small NavBar state
      static let ImageSizeForSmallState: CGFloat = 32
      /// Height of NavBar for Small state. Usually it's just 44
      static let NavBarHeightSmallState: CGFloat = 44
      /// Height of NavBar for Large state. Usually it's just 96.5 but if you have a custom font for the title, please make sure to edit this value since it changes the height for Large state of NavBar
      static let NavBarHeightLargeState: CGFloat = 96.5
    }
    
    private func setupButton() {
      // Initial setup for image for Large NavBar state since the the screen always has Large NavBar once it gets opened
      guard let navigationBar = self.navigationController?.navigationBar else { return }

      navigationBar.addSubview(imageView)

      // setup constraints
        imageView.tintColor = .mWhite
      imageView.layer.cornerRadius = Const.ImageSizeForLargeState / 2
      imageView.clipsToBounds = true
      imageView.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        imageView.rightAnchor.constraint(equalTo: navigationBar.rightAnchor, constant: -Const.ImageRightMargin),
        imageView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -Const.ImageBottomMarginForLargeState),
        imageView.heightAnchor.constraint(equalToConstant: Const.ImageSizeForLargeState),
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
      ])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      showImage(false)
    }

    override func viewWillAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      showImage(true)
    }
}
