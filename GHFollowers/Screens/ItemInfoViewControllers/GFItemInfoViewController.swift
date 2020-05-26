//
//  GFItemInfoView.swift
//  GHFollowers
//
//  Created by Muhammad Umer Farooq on 23/05/2020.
//  Copyright © 2020 Muhammad Umer Farooq. All rights reserved.
//

import UIKit

class GFItemInfoViewController: UIViewController {

    let stackView = UIStackView()
    let itemInfoViewOne = GFItemInfoView()
    let itemInfoViewTwo = GFItemInfoView()
    let actionButton = GFButton()
    
    var user: User!
    
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        configureActionButton()
    }

    
    private func configureLayout() {
        view.addSubviews(stackView, actionButton)
        stackView.addArrangedSubview(itemInfoViewOne)
        stackView.addArrangedSubview(itemInfoViewTwo)
        
        view.layer.cornerRadius                                 = 18
        view.backgroundColor                                    = .secondarySystemBackground
        stackView.translatesAutoresizingMaskIntoConstraints     = false
        stackView.axis                                          = .horizontal
        stackView.distribution                                  = .equalSpacing
        let padding: CGFloat                                    = 20
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    
    private func configureActionButton() {
        self.actionButton.addTarget(self, action: #selector(actionButtonTapped(sender:)), for: .touchUpInside)
    }
    
    
    @objc func actionButtonTapped(sender: UIButton) {
        
    }
}
