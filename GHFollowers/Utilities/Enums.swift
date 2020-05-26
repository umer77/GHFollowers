//
//  Enums.swift
//  GHFollowers
//
//  Created by Muhammad Umer Farooq on 10/05/2020.
//  Copyright © 2020 Muhammad Umer Farooq. All rights reserved.
//

import UIKit

enum GFError: String, Error {
    case invalidUrl                     = "Invalid url request. Please try again."
    case invalidNetworkConnnection      = "Unable to connect to the server. Please try again."
    case invalidResponse                = "Invalid response from the server. Please try again"
    case invalidData                    = "Invalid data received. Please try again."
    case invalidDecoding                =  "Unable to decode the data. Please try again."
    case unableToFavorite               = "There was an error while adding favorite user. Please try again."
    case alreadyInFavorites             = "You have already favorited this user."
    case success                        = "You have successfully favorited this user."
    case noFollowers                    = "This user doesn't have any follower."
    case noFavorites                    = "No favorites.Add one on the follower screen."
}


enum SFSymbols {
    static let location                 = UIImage(systemName: "mappin.and.ellipse")
    static let repos                    = UIImage(systemName: "folder")
    static let gists                    = UIImage(systemName: "text.alignleft")
    static let followers                = UIImage(systemName: "heart")
    static let following                = UIImage(systemName: "person.2")
}


enum Images {
    static let ghLogo                   = UIImage(named: "gh-logo")
    static let placeholderImage         = UIImage(named: "avatar-placeholder")
    static let emptyStateLogo           = UIImage(named: "empty-state-logo")
}


enum ScreenSize {
    static let width                    = UIScreen.main.bounds.size.width
    static let height                   = UIScreen.main.bounds.size.height
    static let maxLength                = max(ScreenSize.width, ScreenSize.height)
    static let minLength                = min(ScreenSize.width, ScreenSize.height)
}


enum DeviceType {
    static let idiom                    = UIDevice.current.userInterfaceIdiom
    static let nativeScale              = UIScreen.main.nativeScale
    static let scale                    = UIScreen.main.scale
        
    static let isiPhoneSE               = idiom == .phone && ScreenSize.maxLength == 568.0
    static let isiPhone8Standard        = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale
    static let isiPhone8Zoomed          = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale > scale
    static let isiPhone8PlusStandard    = idiom == .phone && ScreenSize.maxLength == 736.0
    static let isiPhone8PlusZoomed      = idiom == .phone && ScreenSize.maxLength == 736.0 && nativeScale < scale
    static let isiPhoneX                = idiom == .phone && ScreenSize.maxLength == 812.0
    static let isiPhoneXsMaxAndXr       = idiom == .phone && ScreenSize.maxLength == 896.0
    static let isiPad                   = idiom == .phone && ScreenSize.maxLength == 1024.0
    
    static func isiPhoneXAspectRation() -> Bool {
        return isiPhoneX || isiPhoneXsMaxAndXr
    }
}
