//
//  FavoriteDatasource.swift
//  GHFollowers
//
//  Created by Muhammad Umer Farooq on 24/05/2020.
//  Copyright © 2020 Muhammad Umer Farooq. All rights reserved.
//

import UIKit

enum FavoriteSection {
    case main
}

class FavoriteDatasource: UITableViewDiffableDataSource<FavoriteSection, Follower> {
    
    let tableView: UITableView!
    
    weak var favoriteView: FavoritesView!
    var favorites: [Follower] = []
    
    
    init(tableView: UITableView, favoriteView: FavoritesView) {
        self.tableView = tableView
        self.favoriteView = favoriteView
        super.init(tableView: tableView) { (tableview, indexPath, favorite) -> UITableViewCell? in
            guard let favoriteCell = tableview.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID, for: indexPath) as? FavoriteCell else { fatalError("Unable to dequeue cell"); }
            favoriteCell.set(favorite: favorite)
            return favoriteCell
        }
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete,
            let favorite = self.itemIdentifier(for: indexPath) else { return }
        PersistenceManager.updateWith(follower: favorite, actionType: .remove) { [weak self] error in
            guard let `self` = self else { return }
            guard let error = error else {
                _ = self.favorites.remove(at: indexPath.item)
                self.updateData()
                if self.favorites.isEmpty {
                    self.favoriteView.showEmptyStateView(with: GFError.noFavorites.rawValue)
                }
                return
            }
            self.favoriteView.presentAlert(title: "Unable to remove", message: error.rawValue)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func updateData() {
        favoriteView.view.bringSubviewToFront(tableView)
        var snapshot = NSDiffableDataSourceSnapshot<FavoriteSection,Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(favorites)
        self.apply(snapshot, animatingDifferences: true)
    }
    
    
    func setFavorites(favorites: [Follower]) {
        self.favorites = favorites
    }
}
