//
//  GFEmptyStateView.swift
//  GHFollowers
//
//  Created by Muhammad Umer Farooq on 25/05/2020.
//  Copyright © 2020 Muhammad Umer Farooq. All rights reserved.
//

import UIKit

class GFEmptyStateView: UIView {

    let messageLabel = GFTitleLabel(textAlignment: .center, fontSize: 18)
    let logoImageView = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }
    
    
    private func configureLayout() {
        addSubviews(messageLabel, logoImageView)
        
        messageLabel.numberOfLines                              = 3
        messageLabel.textColor                                  = .secondaryLabel
        
        logoImageView.image                                     = Images.emptyStateLogo
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat                                    = 40
        
        let messageLabelCenterYConstraint: CGFloat              = DeviceType.isiPhoneSE || DeviceType.isiPhone8Zoomed ? -90 : -150
        let logoImageViewBottomConstraint: CGFloat              = DeviceType.isiPhoneSE || DeviceType.isiPhone8Zoomed ? 80 : padding
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: messageLabelCenterYConstraint),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),
            
            logoImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
            logoImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
            logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 170),
            logoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: logoImageViewBottomConstraint)
        ])
    }
}
