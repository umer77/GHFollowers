//
//  GFAlertView.swift
//  GHFollowers
//
//  Created by Muhammad Umer Farooq on 09/05/2020.
//  Copyright © 2020 Muhammad Umer Farooq. All rights reserved.
//

import UIKit

class GFAlertView: UIViewController {

    let containerView = GFContainerView(frame: .zero)
    let titleLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel = GFBodyLabel(textAlignment: .center)
    let actionButton = GFButton(backgroundColor: .systemRed, title: "OK")
    
    let alertTitle: String!
    let alertMessage: String!
    let padding = CGFloat(20)
    
    
    init(alertTitle: String, alertMessage: String) {
        self.alertTitle     = alertTitle
        self.alertMessage   = alertMessage
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
    }
    
    
    private func configureLayout() {
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        self.view.addSubview(self.containerView)
        self.containerView.addSubviews(titleLabel, actionButton, messageLabel)
        
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureMessageLabel()
        self.containerView.layoutIfNeeded()
    }

    
    private func configureContainerView() {
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            containerView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.78),
            containerView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    
    private func configureTitleLabel() {
        titleLabel.text = alertTitle
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding)
        ])
    }
    
    
    private func configureActionButton() {
        actionButton.addTarget(self, action: #selector(GFAlertView.onActionButtonTapped(sender:)), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc private func onActionButtonTapped(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    private func configureMessageLabel() {
        messageLabel.text = alertMessage
        messageLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding)
        ])
    }
}
