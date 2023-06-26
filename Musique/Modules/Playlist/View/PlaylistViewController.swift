//
//  PlaylistViewController.swift
//  Musique
//
//  Created by sidzhe on 23.06.2023.
//

import UIKit
import SnapKit

class PlaylistViewController: UIViewController {
    
    //MARK: - Properties
    
    var presenter: PlaylistPresenterProtocol?
    
    private let identifier = "cellList"
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.separatorStyle = .none
        view.backgroundColor = .clear
        view.allowsSelection = true
        view.showsVerticalScrollIndicator = false
        view.dataSource = self
        view.delegate = self
        view.register(PlaylistCell.self, forCellReuseIdentifier: identifier)
        return view
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add new playlist", for: .normal)
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        button.backgroundColor = .mLime
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private lazy var pageControl: UIPageControl = {
        let page = UIPageControl()
        page.pageIndicatorTintColor = .lightGray
        page.currentPageIndicatorTintColor = .white
        page.numberOfPages = 3
        page.currentPage = 2
        page.isUserInteractionEnabled = false
        page.preferredIndicatorImage = UIImage(named: "activePage")
        return page
    }()
    
    private lazy var swipe: UISwipeGestureRecognizer = {
        let swipe = UISwipeGestureRecognizer()
        swipe.direction = .right
        swipe.addTarget(self, action: #selector(tapPage))
        return swipe
    }()
    
    //MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
    }
    
    //MARK: - Methods
    
    private func setupViews() {
        title = "Playlist"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        
        view.addGestureRecognizer(swipe)
        view.addSubview(tableView)
        view.addSubview(addButton)
        
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(addButton.snp.top).inset(50)
        }
        
        addButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(50)
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
    }
    
    @objc private func tapButton() {
        
    }
    
    @objc private func tapPage() {
        dismiss(animated: true)
    }
    
}

//MARK: - Extension UITableViewDelegate

extension PlaylistViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.playTrack()
    }
}

//MARK: - Extension UITableViewDataSource

extension PlaylistViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.saveTracks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let tracks = presenter?.saveTracks else { return UITableViewCell() }
    
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? PlaylistCell
        cell?.backgroundColor = .clear
        cell?.configure(number: "\(indexPath.row + 1)",
                        name: tracks[indexPath.row].artistName!,
                        song: tracks[indexPath.row].trackName!,
                        imageLink: tracks[indexPath.row])
        
        return cell ?? UITableViewCell()
    }
    
}


//MARK: - Extension

extension PlaylistViewController: PlaylistViewProtocol {}
