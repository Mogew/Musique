//
//  AlbumViewController.swift
//  Musique
//
//  Created by sidzhe on 22.06.2023.
//

import UIKit
import SnapKit

class AlbumViewController: UIViewController {
    
    //MARK: - Properties
    
    var presenter: AlbumPresenterProtocol?
    
    private var indexPath: IndexPath?
    
    private var tracks: [SearchTracks]?
    
    private let identifier = "tableCell"
    
    //MARK: - PageControl
    
    private lazy var pageControl: UIPageControl = {
        let page = UIPageControl()
        page.pageIndicatorTintColor = .lightGray
        page.currentPageIndicatorTintColor = .white
        page.numberOfPages = 3
        page.currentPage = 1
        page.isUserInteractionEnabled = false
        page.preferredIndicatorImage = UIImage(named: "activePage")
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
        view.image = UIImage(named: "line")
        return view
    }()
    
    //MARK: - Labels
    
    private lazy var songLabel: UILabel = {
        let label = UILabel()
        label.text = "Come to me"
        label.textAlignment = .right
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 36, weight: .semibold)
        return label
    }()
    
    private lazy var albumLabel: UILabel = {
        let label = UILabel()
        label.text = "Shawn Mendes"
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it"
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var header: UILabel = {
        let label = UILabel()
        label.text = "Suggestion"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    //MARK: - TableView
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.separatorStyle = .none
        view.backgroundColor = .clear
        view.allowsSelection = false
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
        guard let tracks = tracks, let indexPath = indexPath else { return }
        let playlistVC = Builder.createPlaylist(track: tracks[indexPath.row], indexPath: indexPath)
        playlistVC.modalPresentationStyle = .fullScreen
        playlistVC.modalTransitionStyle = .crossDissolve
        present(playlistVC, animated: true)
    }
    
    @objc private func tapRightSwipe() {
        dismiss(animated: true)
    }
}
//MARK: - Extension UITableViewDelegate

extension AlbumViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        ;;;;;
    }
}

//MARK: - Extension UITableViewDataSource

extension AlbumViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.tracksArray?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? AlbumCell
        cell!.backgroundColor = .clear
        
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
    func setData(index: IndexPath?, trackArray: [SearchTracks]?) {
        guard let safeIndexPath = index, let track = trackArray else { return }
        indexPath = safeIndexPath
        tracks = track
  
        songLabel.text = track[safeIndexPath.row].collectionName
        albumLabel.text = track[safeIndexPath.row].trackName
        textLabel.text = "This artist is \(track[safeIndexPath.row].artistName ?? ""), if you want to know more about that person you can look here"
        
        let urlImage = track[safeIndexPath.row].artworkUrl100!.replacingOccurrences(of: "100x100", with: "600x600")
        guard let url = URL(string: urlImage) else { return }
        
        backgroundView.kf.setImage(with: url)
    }
    
}
