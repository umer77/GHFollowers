//
//  UserInfoView.swift
//  GHFollowers
//
//  Created by Muhammad Umer Farooq on 17/05/2020.
//  Copyright © 2020 Muhammad Umer Farooq. All rights reserved.
//

import UIKit
import SafariServices

protocol UserInfoViewDelegate: class {
    func didRequestFollowers(for username: String)
}

class UserInfoView: UIViewController {

    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = GFBodyLabel(textAlignment: .center)
    var itemViews: [UIView] = []
    
    weak var delegate: UserInfoViewDelegate!
    var username: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureScrollView()
        configureLayout()
        fetchUserInfo()
    }
    
    
    private func configureViewController() {
        self.view.backgroundColor = .systemBackground
        let barButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(UserInfoView.dismissView(sender:)))
        navigationItem.rightBarButtonItem = barButton
    }
    
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.pinToEdges(of: view)
        contentView.pinToEdges(of: scrollView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    
    private func configureLayout() {
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
        
        for itemView in itemViews {
            contentView.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
            ])
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),

            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -padding)
        ])
    }
    
    
    func addChildView(childViewController: UIViewController, to containerView: UIView) {
        addChild(childViewController)
        containerView.addSubview(childViewController.view)
        childViewController.view.frame = containerView.bounds
        childViewController.didMove(toParent: self)
    }

    
    @objc func dismissView(sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    
    private func fetchUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let `self` = self else { return }
            switch result {
                case .success(let userInfo):
                    DispatchQueue.main.async { self.configureUserInfoView(user: userInfo) }
                case .failure(let error):
                    self.presentAlert(title: "Something Bad Happened!", message: error.localizedDescription)
            }
        }
    }
    
    
    private func configureUserInfoView(user: User) {
        
        self.addChildView(childViewController: GFUserInfoHeaderView(user: user), to: self.headerView)
        self.addChildView(childViewController: GFRepoItemView(user: user, delegate: self), to: self.itemViewOne)
        self.addChildView(childViewController: GFFollowerItemView(user: user, delegate: self), to: self.itemViewTwo)
        self.dateLabel.text = "GitHub since \(user.createdAt.convertToMonthYearFormat())"
    }
}

extension UserInfoView: GFRepoItemViewDelegate {
    
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentAlert(title: "Invalid Url", message: "The url attached to this user is invalid.")
            return
        }
        
        presentSafariViewController(with: url)
    }
}

extension UserInfoView: GFFollowerItemViewDelegate {
    
    func didTapGitHubFollowers(for user: User) {
        
        guard user.followers != 0 else {
            presentAlert(title: "No Followers", message: "This user has no followers, what a shame 😞.")
            return
        }
        self.delegate.didRequestFollowers(for: user.login)
        dismiss(animated: true)
    }
}
