//
//  MainTabBarPresenter.swift
//  Musique
//
//  Created by sidzhe on 28.06.2023.
//

import Foundation

protocol MainTabBarProtocol: AnyObject {}

protocol MainTabBarPresenterProtocol: AnyObject {
    init(view: MainTabBarProtocol, avPlayer: AVplayerProtocol)
    func playPause() -> Bool
}


class MainTabBarPresenter: MainTabBarPresenterProtocol {
    
    weak var view: MainTabBarProtocol?
    var avPlayer: AVplayerProtocol?
    
    required init(view: MainTabBarProtocol, avPlayer: AVplayerProtocol) {
        self.view = view
        self.avPlayer = avPlayer
    }
    
    func playPause() -> Bool {
        avPlayer!.playPause()
    }
}
