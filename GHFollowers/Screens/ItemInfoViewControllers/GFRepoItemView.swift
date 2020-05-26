//
//  GFRepoItemView.swift
//  GHFollowers
//
//  Created by Muhammad Umer Farooq on 23/05/2020.
//  Copyright © 2020 Muhammad Umer Farooq. All rights reserved.
//

import UIKit

protocol GFRepoItemViewDelegate: class {
    func didTapGitHubProfile(for user: User)
}

class GFRepoItemView: GFItemInfoViewController {

    weak var delegate: GFRepoItemViewDelegate!
    
    
    init(user: User, delegate: GFRepoItemViewDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, with: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, with: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "Github Profile")
    }
    
    
    override func actionButtonTapped(sender: UIButton) {
        self.delegate.didTapGitHubProfile(for: user)
    }
}
