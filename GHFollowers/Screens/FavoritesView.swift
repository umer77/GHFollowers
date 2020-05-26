//
//  FavoritesView.swift
//  GHFollowers
//
//  Created by Muhammad Umer Farooq on 09/05/2020.
//  Copyright © 2020 Muhammad Umer Farooq. All rights reserved.
//

import UIKit

class FavoritesView: UIViewController {

    let tableView = UITableView()
    private var datasource: FavoriteDatasource!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        configureTableView()
        configureDatasource()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    
    private func configureLayout() {
        self.view.backgroundColor       = .systemBackground
        self.title                      = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    private func configureTableView() {
        self.view.addSubview(tableView)
        tableView.rowHeight         = 80
        tableView.frame             = view.bounds
        tableView.backgroundColor   = .systemBackground
        tableView.delegate          = self
        tableView.tableFooterView   = UIView()
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
    }
    
    
    private func configureDatasource() {
        datasource = FavoriteDatasource(tableView: tableView, favoriteView: self)
    }
    
    
    private func getFavorites() {
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let `self` = self else { return }
            switch result {
                case.success(let favorites):
                    DispatchQueue.main.async {
                        if favorites.isEmpty {
                            self.showEmptyStateView(with: GFError.noFavorites.rawValue)
                            return
                        }
                        self.datasource.setFavorites(favorites: favorites)
                        self.datasource.updateData()
                    }
                case.failure(let error):
                    self.presentAlert(title: "Something went wrong", message: error.rawValue)
            }
        }
    }
}

extension FavoritesView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = self.datasource.favorites[indexPath.item]
        let destVC = FollowersView(username: favorite.login)
        navigationController?.pushViewController(destVC, animated: true)
    }
}
