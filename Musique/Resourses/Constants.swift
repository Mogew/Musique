//
//  Constants.swift
//  Musique
//
//  Created by Ольга Шовгенева on 14.06.2023.
//

import UIKit

enum Onboarding {
    enum Image {
        case first
        case second
        case third
        case fourth
        case fifth
        
        var getImage: UIImage {
            switch self {
            case .first:
                return UIImage(named: "onboardingImage1.jpg")!
            case .second:
                return UIImage(named: "onboardingImage2.jpg")!
            case .third:
                return UIImage(named: "onboardingImage3.jpg")!
            case.fourth:
                return UIImage(named: "onboardingImage4.jpg")!
            case.fifth:
                return UIImage(named: "onboardingImage5.jpg")!
            }
        }
    }
    
    enum Title {
        case first
        case second
        case third
        case fourth
        case fifth
        
        var getTitle: String {
            switch self {
            case .first:
                return "WELCOME TO MUSIC APP"
            case .second:
                return "WELCOME TO MUSIC APP"
            case .third:
                return "WELCOME TO MUSIC APP"
            case .fourth:
                return "WELCOME TO MUSIC APP"
            case .fifth:
                return "WELCOME TO MUSIC APP"
            }
        }
    }
    
    enum Subtitle1 {
        case first
        case second
        case third
        case fourth
        case fifth
        
        var getTitle: String {
            switch self {
            case .first:
                return "Make your design workflow easier and save your time"
            case .second:
                return "Make your design workflow easier and save your time"
            case .third:
                return "Make your design workflow easier and save your time"
            case .fourth:
                return "Make your design workflow easier and save your time"
            case .fifth:
                return "Make your design workflow easier and save your time"
            }
        }
    }
    
    enum Subtitle2 {
        case first
        case second
        case third
        case fourth
        case fifth
        
        var getTitle: String {
            switch self {
            case .first:
                return "APP UI KIT"
            case .second:
                return "APP UI KIT"
            case .third:
                return "APP UI KIT"
            case .fourth:
                return "APP UI KIT"
            case .fifth:
                return "APP UI KIT"
            }
        }
    }
}
