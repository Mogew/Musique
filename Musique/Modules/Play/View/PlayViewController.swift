//
//  PlayViewController.swift
//  Musique
//
//  Created by sidzhe on 22.06.2023.
//

import UIKit
import SnapKit

class PlayViewController: UIViewController {
    
    //MARK: - Properties
    
    var presenter: PlayPresenterProtocol?
    
    private let identifier = Const.Text.cell
    
    private var mixButtonSelector = false
    
    private var replayButtonSelector = false
    
    private var indexPath: IndexPath?
    
    private var trackArray: [SearchTracks]?
    
    private var saveTracks = [SearchTracks]()
    
    //MARK: - UI Buttons
    
    private lazy var mixButton = UIButton()
    private lazy var backButton = UIButton()
    private lazy var forwawrdButton = UIButton()
    private lazy var replayButton = UIButton()
    private lazy var sharedButton = UIButton()
    private lazy var addPlayListButton = UIButton()
    private lazy var favoritesButton = UIButton()
    private lazy var downloadButton = UIButton()
    
    private lazy var playPauseButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(Const.Images.ellipsePlay, for: .normal)
        button.setImage(Const.Images.pauseFill, for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(tapPlayPause), for: .touchUpInside)
        return button
    }()
    
    private lazy var addFavoriteButton: UIButton = {
        let button = UIButton()
        button.setTitle(Const.Text.addSong, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .mLime
        button.layer.cornerRadius = 10
        button.alpha = 0
        button.addTarget(self, action: #selector(addPListButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var addDownloadButton: UIButton = {
        let button = UIButton()
        button.setTitle(Const.Text.addSong, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .mLime
        button.layer.cornerRadius = 10
        button.alpha = 0
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Labels
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = Const.Text.itIsLong
        label.textColor = .mLime
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var artistLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var songLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 36, weight: .semibold)
        return label
    }()
    
    private lazy var startTimeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15)
        label.text = Const.Text.zeroTime
        label.textColor = .white
        return label
    }()
    
    private lazy var endTimeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 15)
        label.text = Const.Text.emptyTime
        label.textColor = .white
        return label
    }()
    
    //MARK: - PageControll
    
    private lazy var pageControl: UIPageControl = {
        let page = UIPageControl()
        page.pageIndicatorTintColor = .lightGray
        page.currentPageIndicatorTintColor = .white
        page.numberOfPages = 3
        page.currentPage = 0
        page.isUserInteractionEnabled = false
        page.preferredIndicatorImage = Const.Images.pageImage
        return page
    }()
    
    //MARK: - Swipe
    
    private lazy var swipe: UISwipeGestureRecognizer = {
        let swipe = UISwipeGestureRecognizer()
        swipe.direction = .left
        swipe.addTarget(self, action: #selector(tapPage))
        return swipe
    }()
    
    private lazy var swipeDown: UISwipeGestureRecognizer = {
        let swipe = UISwipeGestureRecognizer()
        swipe.direction = .down
        swipe.addTarget(self, action: #selector(tapDown))
        return swipe
    }()
    
    //MARK: - Shared Controller
    
    private lazy var sharedControl: UIActivityViewController = {
        let dataArray = []
        let view = UIActivityViewController(activityItems: dataArray, applicationActivities: nil)
        return view
    }()
    
    //MARK: - ImageViews
    
    private lazy var logoImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = Const.Images.ellipse
        view.layer.cornerRadius = 150
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var minVolumeImage: UIImageView = {
        let image = UIImageView()
        image.image = Const.Images.speaker
        image.tintColor = .white
        return image
    }()
    
    private lazy var maxVolumeImage: UIImageView = {
        let image = UIImageView()
        image.image = Const.Images.speakerWave
        image.tintColor = .white
        return image
    }()
    
    //MARK: - Sliders
    
    private lazy var songTimeSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.tintColor = .mLime
        slider.setThumbImage(Const.Images.slider, for: .normal)
        slider.addTarget(self, action: #selector(moveTrackSlider), for: .valueChanged)
        return slider
    }()
    
    private lazy var volumeSlider: UISlider = {
        let slider = UISlider()
        slider.value = 0.5
        slider.tintColor = .mLime
        slider.setThumbImage(Const.Images.slider, for: .normal)
        slider.addTarget(self, action: #selector(moveVolumeSlider), for: .valueChanged)
        return slider
    }()
    
    //MARK: - StackViews
    
    private lazy var generalStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 20
        return view
    }()
    
    private lazy var trackStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillProportionally
        view.spacing = 10
        return view
    }()
    
    private lazy var mainStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 20
        return view
    }()
    
    private lazy var playStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 20
        view.distribution = .equalCentering
        view.alignment = .center
        return view
    }()
    
    private lazy var timeStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        view.distribution = .fillEqually
        return view
    }()
    
    private lazy var favoritesStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        view.distribution = .fillEqually
        return view
    }()
    
    private lazy var volumeStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        return view
    }()
    
    //MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        trackSetups()
        
        //navigationController?.navigationBar.isHidden = true
        navigationController?.tabBarController?.tabBar.isHidden = true
        
        let scale: CGFloat = 0.8
        logoImage.transform = CGAffineTransform(scaleX: scale, y: scale)
        
    }
    
    //MARK: - Setup Views
    
    private func setupViews() {
        view.backgroundColor = UIColor(patternImage: Const.Images.background)
        
        view.addGestureRecognizer(swipeDown)
        view.addGestureRecognizer(swipe)
        
        favoritesButton.tintColor = .white
        mixButton.tintColor = .white
        replayButton.tintColor = .white
        
        forwawrdButton.tag = 1
        backButton.tag = 2
        favoritesButton.tag = 1
        downloadButton.tag = 1
        
        trackStackView.addArrangedSubview(songLabel)
        trackStackView.addArrangedSubview(artistLabel)
        
        generalStackView.addArrangedSubview(logoImage)
        generalStackView.addArrangedSubview(trackStackView)
        generalStackView.addArrangedSubview(textLabel)
        
        createButton(mixButton, image: Const.Images.shuffle, stackView: playStackView, selector: #selector(tapShake))
        createButton(backButton, image: Const.Images.back, stackView: playStackView, selector: #selector(secondTrack(sender:)))
        playStackView.addArrangedSubview(playPauseButton)
        createButton(forwawrdButton, image: Const.Images.forward, stackView: playStackView, selector: #selector(secondTrack(sender:)))
        createButton(replayButton, image: Const.Images.repeatImage, stackView: playStackView, selector: #selector(tapReplay))
        createButton(sharedButton, image: Const.Images.shared, stackView: favoritesStackView, selector: #selector(tapShared))
        createButton(addPlayListButton, image: Const.Images.addLibr, stackView: favoritesStackView, selector: #selector(addPListButton))
        createButton(favoritesButton, image: Const.Images.heart, stackView: favoritesStackView, selector: #selector(tapFavoriteButton))
        createButton(downloadButton, image: Const.Images.download, stackView: favoritesStackView, selector: #selector(tapDownloadButton))
        
        timeStackView.addArrangedSubview(startTimeLabel)
        timeStackView.addArrangedSubview(endTimeLabel)
        
        volumeStackView.addArrangedSubview(minVolumeImage)
        volumeStackView.addArrangedSubview(volumeSlider)
        volumeStackView.addArrangedSubview(maxVolumeImage)
        
        view.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(pageControl)
        mainStackView.addArrangedSubview(generalStackView)
        mainStackView.addArrangedSubview(favoritesStackView)
        mainStackView.addArrangedSubview(songTimeSlider)
        mainStackView.addArrangedSubview(timeStackView)
        mainStackView.addArrangedSubview(playStackView)
        mainStackView.addArrangedSubview(volumeStackView)
        
        view.addSubview(addFavoriteButton)
        view.addSubview(addDownloadButton)
        
        mainStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(30)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
        }
        
        addFavoriteButton.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.horizontalEdges.equalToSuperview().inset(56)
            make.center.equalTo(logoImage.snp.center)
        }
        
        addDownloadButton.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.horizontalEdges.equalToSuperview().inset(50)
            make.center.equalTo(logoImage.snp.center)
        }
        
        logoImage.snp.makeConstraints { make in
            make.height.equalTo(logoImage.snp.width)
        }
        
    }
    
    //MARK: - Animations
    
    private func largeLogo() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.logoImage.transform = .identity
        }
    }
    
    private func reduceLogo() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut) {
            let scale: CGFloat = 0.8
            self.logoImage.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
    }
    
    private func monitoringTime() {
        presenter?.monitorStartTime { [weak self] in
            guard let self = self else { return }
            self.largeLogo()
        }
    }
    
    private func observPlayerCurrentTime() {
        presenter?.observPlayerCurrentTime { [weak self] (startTime, endTime) in
            guard let self = self else { return }
            self.startTimeLabel.text = startTime
            self.endTimeLabel.text = "-\(endTime)"
            self.updateCurrentTimeSlider()
            
            if endTime == Const.Text.zeroTime {
                
                if self.mixButtonSelector {
                    sleep(1)
                    self.presenter?.shakeTrack()
                } else if self.replayButtonSelector {
                    sleep(1)
                    self.presenter?.repeatTrack()
                } else {
                    sleep(1)
                    self.presenter?.checkNextTrack()
                }
            }
        }
    }
    
    private func updateCurrentTimeSlider() {
        songTimeSlider.value = presenter?.getCurrunetTime() ?? 0
    }
    
    //MARK: - Monitoring Tracks
    
    private func trackSetups() {
        monitoringTime()
        observPlayerCurrentTime()
    }
    
    //MARK: - Targets
    
    @objc private func tapButton() {
//
    }
    
    @objc private func tapDown() {
        
    }
    
    @objc private func addPListButton() {
        guard let trackArray = trackArray, let indexPath = indexPath?.row else { return }
        
        saveTracks.append(trackArray[indexPath])
        
        favoritesButton.tag = 1
        favoritesButton.setImage(Const.Images.heart, for: .normal)
        favoritesButton.tintColor = .white
        downloadButton.isEnabled = true
        
        UIView.animate(withDuration: 0.5) {
            self.addFavoriteButton.alpha = 0
        }
        
    }
    
    @objc private func tapShared() {
        present(sharedControl, animated: true)
    }
    
    @objc private func tapPage() {
        guard let index = indexPath, let array = trackArray else { return }
        let albumVC = Builder.createAlbumVC(indexPath: index, tracksArray: array, saveTrack: saveTracks)
        albumVC.modalPresentationStyle = .fullScreen
        albumVC.modalTransitionStyle = .crossDissolve
        present(albumVC, animated: true)
    }
    
    @objc private func tapReplay() {
        if replayButtonSelector {
            replayButton.tintColor = .white
            replayButtonSelector = false
            mixButton.isEnabled = true
        } else {
            replayButton.tintColor = .mLime
            replayButtonSelector = true
            mixButton.isEnabled = false
        }
    }
    
    @objc private func tapShake() {
        
        if mixButtonSelector {
            mixButton.tintColor = .white
            mixButtonSelector = false
            replayButton.isEnabled = true
        } else {
            mixButton.tintColor = .mLime
            mixButtonSelector = true
            replayButton.isEnabled = false
        }
    }
    
    @objc private func moveTrackSlider() {
        presenter?.moveTimeSlider(currentTime: songTimeSlider.value)
    }
    
    @objc private func moveVolumeSlider() {
        presenter?.changeVolume(volumeSlider.value)
    }
    
    @objc private func tapPlayPause() {
        if presenter?.playPause() == true {
            playPauseButton.setImage(Const.Images.pauseFill, for: .normal)
            playPauseButton.tintColor = .black
            largeLogo()
        } else {
            playPauseButton.setImage(Const.Images.playFill, for: .normal)
            playPauseButton.tintColor = .black
            reduceLogo()
        }
    }
    
    @objc private func secondTrack(sender: UIButton) {
        if mixButtonSelector {
            presenter?.shakeTrack()
        } else if replayButtonSelector {
            presenter?.repeatTrack()
        } else {
            presenter?.findNextTrack(tag: sender.tag)
        }
    }
    
    @objc private func tapFavoriteButton() {
        
        if favoritesButton.tag == 1 {
            presenter?.writeInDataBase(songObject: (trackArray?[indexPath!.item])!)
            favoritesButton.tag = 0
            favoritesButton.setImage(Const.Images.heartFill, for: .normal)
            favoritesButton.tintColor = .mLime
            downloadButton.isEnabled = false
            
            UIView.animate(withDuration: 0.5) {
                self.addFavoriteButton.alpha = 0.8
            }
        } else {
            // temp bad decision
            presenter?.deleteLastFromDB()
            //
            favoritesButton.tag = 1
            favoritesButton.setImage(Const.Images.heart, for: .normal)
            favoritesButton.tintColor = .white
            downloadButton.isEnabled = true
            
            UIView.animate(withDuration: 0.5) {
                self.addFavoriteButton.alpha = 0
            }
        }
    }
    
    @objc private func tapDownloadButton() {
        
        if downloadButton.tag == 1 {
            downloadButton.tag = 0
            downloadButton.setImage(Const.Images.download.withRenderingMode(.alwaysTemplate), for: .normal)
            downloadButton.tintColor = .mLime
            favoritesButton.isEnabled = false
            
            UIView.animate(withDuration: 0.5) {
                self.addDownloadButton.alpha = 0.8
            }
        } else {
            downloadButton.tag = 1
            downloadButton.setImage(Const.Images.download.withRenderingMode(.alwaysTemplate), for: .normal)
            downloadButton.tintColor = .white
            favoritesButton.isEnabled = true
            
            UIView.animate(withDuration: 0.5) {
                self.addDownloadButton.alpha = 0
            }
        }
    }
    
    //MARK: - Create Buttons
    
    private func createButton(_ button: UIButton, image: UIImage, stackView: UIStackView, selector: Selector) {
        button.setImage(image, for: .normal)
        button.addTarget(self, action: selector, for: .touchUpInside)
        stackView.addArrangedSubview(button)
    }
}

//MARK: - Extension PlayViewProtocol

extension PlayViewController: PlayViewProtocol {
    func updateIndexPath(index: IndexPath) {
        indexPath = index
    }
    
    func setData(index: IndexPath?, model: [SearchTracks]?) {
        indexPath = index
        trackArray = model
    }
    
    func getMusic(_ model: SearchTracks?) {
        
        artistLabel.text = model?.artistName
        songLabel.text = model?.trackName
        textLabel.text = model?.collectionName ?? Const.Text.empty
        
        let urlImage = model?.artworkUrl100?.replacingOccurrences(of: Const.Text.size100, with: Const.Text.size300)
        guard let url = URL(string: urlImage ?? Const.Text.empty) else { return }
        logoImage.kf.setImage(with: url)
    }
}
