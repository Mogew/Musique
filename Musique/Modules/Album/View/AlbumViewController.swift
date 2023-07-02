import UIKit
import SnapKit
import SafariServices

final class AlbumViewController: UIViewController {
    
    //MARK: - Properties
    
    var presenter: AlbumPresenterProtocol?
    
    private var indexPath: IndexPath?
    
    private var tracks: [SearchTracks]?
    
    private var saveTracks: [SearchTracks]?
    
    private let identifier = Const.Text.tableCell
    
    //MARK: - PageControl
    
    private lazy var pageControl: UIPageControl = {
        let page = UIPageControl()
        page.pageIndicatorTintColor = .lightGray
        page.currentPageIndicatorTintColor = .white
        page.numberOfPages = 3
        page.currentPage = 1
        page.isUserInteractionEnabled = false
        page.preferredIndicatorImage = Const.Images.pageImage
        return page
    }()
    
    //MARK: - Image Views
    
    private lazy var backgroundView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private lazy var lineImage: UIImageView = {
        let view = UIImageView()
        view.image = Const.Images.line
        return view
    }()
    
    //MARK: - Labels
    
    private lazy var songLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.numberOfLines = 0
        label.font = UIFont.robotoBold(ofSize: 36)
        return label
    }()
    
    private lazy var albumLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.robotoMedium(ofSize: 22)
        return label
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.robotoRegular(ofSize: 18)
        label.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openLink(_:)))
        label.addGestureRecognizer(tapGesture)
        return label
    }()
    
    private lazy var header: UILabel = {
        let label = UILabel()
        label.text = Const.Text.suggestion
        label.font = UIFont.robotoMedium(ofSize: 18)
        return label
    }()
    
    //MARK: - TableView
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.separatorStyle = .none
        view.backgroundColor = .clear
        view.allowsSelection = true
        view.showsVerticalScrollIndicator = false
        view.dataSource = self
        view.delegate = self
        view.register(AlbumCell.self, forCellReuseIdentifier: identifier)
        return view
    }()
    
    //MARK: - Stack Views
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 20
        view.alignment = .leading
        return view
    }()
    
    private lazy var musicStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 20
        return view
    }()
    
    //MARK: - Swipe
    
    private lazy var swipeLeft: UISwipeGestureRecognizer = {
        let swipe = UISwipeGestureRecognizer()
        swipe.direction = .left
        swipe.addTarget(self, action: #selector(tapLeftSwipe))
        return swipe
    }()
    
    private lazy var swipeRight: UISwipeGestureRecognizer = {
        let swipe = UISwipeGestureRecognizer()
        swipe.direction = .right
        swipe.addTarget(self, action: #selector(tapRightSwipe))
        return swipe
    }()
    
    //MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
    }
    
    //MARK: - Setup Views
    
    private func setupViews() {
        musicStackView.addArrangedSubview(songLabel)
        musicStackView.addArrangedSubview(albumLabel)
        
        stackView.addArrangedSubview(musicStackView)
        stackView.addArrangedSubview(textLabel)
        
        view.addGestureRecognizer(swipeLeft)
        view.addGestureRecognizer(swipeRight)
        
        view.addSubview(backgroundView)
        
        view.addSubview(pageControl)
        view.addSubview(stackView)
        view.addSubview(header)
        view.addSubview(tableView)
        view.addSubview(lineImage)
        
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        lineImage.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(288)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        tableView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalTo(view.snp.bottom).inset(224)
        }
        
        header.snp.makeConstraints { make in
            make.top.equalTo(lineImage.snp.bottom).offset(36)
            make.left.equalToSuperview().inset(22)
            make.width.equalTo(200)
            make.height.equalTo(20)
        }
        
        stackView.snp.makeConstraints { make in
            make.bottom.equalTo(lineImage.snp.top).inset(-36)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
        }
    }
    
    //MARK: - Methods
    
    @objc private func tapLeftSwipe() {
        guard let tracks = tracks, let indexPath = indexPath, let saveTracks = saveTracks else { return }
        
        let playlistVC = Builder.createPlaylist(track: tracks[indexPath.row], indexPath: indexPath, saveTracks: saveTracks)
        playlistVC.modalPresentationStyle = .fullScreen
        playlistVC.modalTransitionStyle = .crossDissolve
        present(playlistVC, animated: true)
    }
    
    @objc private func tapRightSwipe() {
        dismiss(animated: true)
    }
    
    @objc func openLink(_ gestureRecognizer: UITapGestureRecognizer) {
        if let label = gestureRecognizer.view as? UILabel,
           let attributedString = label.attributedText,
           let url = attributedString.attribute(.link, at: attributedString.length - 1, effectiveRange: nil) as? String,
           let linkURL = URL(string: url) {
            let safariViewController = SFSafariViewController(url: linkURL)
            present(safariViewController, animated: true, completion: nil)
        }
    }
}
//MARK: - Extension UITableViewDelegate

extension AlbumViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let track = tracks?[indexPath.row] else { return }
        presenter?.avPlayer?.playTrack(track)
    }
}

//MARK: - Extension UITableViewDataSource

extension AlbumViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.tracksArray?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? AlbumCell
        cell?.backgroundColor = .clear
        
        guard let model = presenter?.tracksArray?[indexPath.row] else { return UITableViewCell() }
        cell?.configure(
            number: String(indexPath.row + 1),
            name: model.artistName!,
            song: model.trackName!,
            imageLink: model)
        
        return cell ?? UITableViewCell()
    }
}

//MARK: -  Extension AlbumViewProtocol

extension AlbumViewController: AlbumViewProtocol {
    func setData(index: IndexPath?, trackArray: [SearchTracks]?, saveTrack: [SearchTracks]?) {
        
        guard let safeIndexPath = index, let track = trackArray, let saveTrack = saveTrack else { return }
        indexPath = safeIndexPath
        tracks = track
        saveTracks = saveTrack
        
        songLabel.text = track[safeIndexPath.row].collectionName
        albumLabel.text = track[safeIndexPath.row].trackName
        
        let text = "\(Const.Text.cellTextPart1) \(track[safeIndexPath.row].artistName ?? Const.Text.empty)\(Const.Text.cellTextPart2)"
        let linkText = Const.Text.lookHere
        let urlString = track[safeIndexPath.row].artistViewUrl
        let attributedString = NSMutableAttributedString(string: text)
        
        if let range = text.range(of: linkText) {
            let nsRange = NSRange(range, in: text)
            attributedString.addAttribute(.link, value: urlString, range: nsRange)
        }
        
        textLabel.attributedText = attributedString
        
        let urlImage = track[safeIndexPath.row].artworkUrl100!.replacingOccurrences(of: Const.Text.size100, with: Const.Text.size600)
        guard let url = URL(string: urlImage) else { return }
        
        backgroundView.kf.setImage(with: url)
    }
}
