//
//  FollowersView.swift
//  GHFollowers
//
//  Created by Muhammad Umer Farooq on 09/05/2020.
//  Copyright © 2020 Muhammad Umer Farooq. All rights reserved.
//

import UIKit

fileprivate enum Section {
    case main
}

class FollowersView: UIViewController {
    
    var collectionView: UICollectionView!
    fileprivate var datasource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    var username: String!
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var page = 1
    var hasMoreFollowers = true
    var isLoadingMoreFollowers = false
    
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
        title = username
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        configureCollectionView()
        configureSearchController()
        configureDataSource()
        fetchFollowers(with: username, pageNo: page)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: configureFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        collectionView.backgroundColor = .systemBackground
    }
    
    
    private func configureLayout() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addFavoritesButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToFavoritesButtonTapped))
        navigationItem.rightBarButtonItem = addFavoritesButton
    }
    
    
    @objc func addToFavoritesButtonTapped() {
        showLoadingView()
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let `self` = self else { return }
            self.dismissLoadingView()
            switch result {
                case.success(let user):
                    let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                    PersistenceManager.updateWith(follower: favorite, actionType: .add) { [weak self] error in
                        guard let `self` = self else { return }
                        guard let error = error else {
                            self.presentAlert(title: "Success", message: GFError.success.rawValue)
                            return
                        }
                        self.presentAlert(title: "Error", message: error.rawValue)
                }
                case.failure(let error):
                    self.presentAlert(title: "Something went wrong", message: error.rawValue)
            }
        }
    }
    
    
    private func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for a username"
        navigationItem.searchController = searchController
    }
    
    
    private func fetchFollowers(with username: String, pageNo: Int) {
        showLoadingView()
        isLoadingMoreFollowers = true
        NetworkManager.shared.getFollowers(for: username, pageNo: pageNo, completionHandler: { [weak self]
            result in
            guard let `self` = self else { return }
            self.dismissLoadingView()
            switch result {
                case .success(let followers):
                    if followers.count < 100 { self.hasMoreFollowers = false }
                    self.followers.append(contentsOf: followers)
                    if followers.isEmpty {
                        DispatchQueue.main.async {
                            self.showEmptyStateView(with: GFError.noFollowers.rawValue)
                        }
                    }
                    self.updateData(arr: self.followers)
                case .failure(let error):
                    self.presentAlert(title: "Something Bad Happened", message: error.rawValue)
            }
            self.isLoadingMoreFollowers = false
        })
    }
    
    
    private func configureDataSource() {
        datasource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as? FollowerCell else { fatalError("Unable to dequeue cell") }
            cell.setFollower(follower: follower)
            return cell
        })
    }
    
    
    private func updateData(arr: [Follower]) {
        filteredFollowers = arr
        DispatchQueue.main.async {
            var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
            snapshot.appendSections([.main])
            snapshot.appendItems(arr)
            self.datasource.apply(snapshot, animatingDifferences: true)
        }
    }
}

extension FollowersView {
    
    private func configureFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        let padding: CGFloat = 12
        let minimumSpacing: CGFloat = 10
        let width = view.bounds.width
        let availableWidth = width - (padding * 2) - (minimumSpacing * 2)
        let itemWidth = availableWidth/3
        
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        return flowLayout
    }
}

extension FollowersView: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers,
            !isLoadingMoreFollowers else { return }
            page += 1
            fetchFollowers(with: username, pageNo: page)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let follower = self.filteredFollowers[indexPath.item]
        let destVC = UserInfoView()
        destVC.username = follower.login
        destVC.delegate = self
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
}

extension FollowersView: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filteredFollowers.removeAll()
            updateData(arr: followers)
            return
        }
        let result = self.followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(arr: result)
    }
}

extension FollowersView: UserInfoViewDelegate {
    
    func didRequestFollowers(for username: String) {
        self.username = username
        title = username
        followers.removeAll()
        filteredFollowers.removeAll()
        page = 1
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        fetchFollowers(with: username, pageNo: page)
    }
}
