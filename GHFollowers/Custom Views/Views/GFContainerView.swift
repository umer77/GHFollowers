//
//  GFContainerView.swift
//  GHFollowers
//
//  Created by Muhammad Umer Farooq on 09/05/2020.
//  Copyright © 2020 Muhammad Umer Farooq. All rights reserved.
//

import UIKit

class GFContainerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureView() {
        translatesAutoresizingMaskIntoConstraints   = false
        backgroundColor                             = .systemBackground
        layer.cornerRadius                          = 16
        layer.borderWidth                           = 2
        layer.borderColor                           = UIColor.white.cgColor
    }
}
