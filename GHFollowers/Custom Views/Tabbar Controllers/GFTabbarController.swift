//
//  GFTabbarController.swift
//  GHFollowers
//
//  Created by Muhammad Umer Farooq on 24/05/2020.
//  Copyright © 2020 Muhammad Umer Farooq. All rights reserved.
//

import UIKit

class GFTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [createSearchController(),createFavoritesController()]
    }
    
    
    func createSearchController() -> UINavigationController {
        let searchView              = SearchView()
        searchView.title            = "Search"
        searchView.tabBarItem       = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return UINavigationController(rootViewController: searchView)
    }
    
    
    func createFavoritesController() -> UINavigationController {
        let favoritesView           = FavoritesView()
        favoritesView.title         = "Favorites"
        favoritesView.tabBarItem    = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return UINavigationController(rootViewController: favoritesView)
    }
}
