//
//  GFFollowerItemView.swift
//  GHFollowers
//
//  Created by Muhammad Umer Farooq on 23/05/2020.
//  Copyright © 2020 Muhammad Umer Farooq. All rights reserved.
//

import UIKit

protocol GFFollowerItemViewDelegate: class {
    func didTapGitHubFollowers(for user: User)
}

class GFFollowerItemView: GFItemInfoViewController {

    weak var delegate: GFFollowerItemViewDelegate!
    
    
    init(user: User, delegate: GFFollowerItemViewDelegate) {
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
        itemInfoViewOne.set(itemInfoType: .followers, with: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, with: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    
    override func actionButtonTapped(sender: UIButton) {
        self.delegate.didTapGitHubFollowers(for: user)
    }
}
