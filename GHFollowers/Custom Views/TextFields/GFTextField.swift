//
//  GFTextField.swift
//  GHFollowers
//
//  Created by Muhammad Umer Farooq on 09/05/2020.
//  Copyright © 2020 Muhammad Umer Farooq. All rights reserved.
//

import UIKit

class GFTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(placeholder: String) {
        self.init(frame: .zero)
        self.placeholder = placeholder
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints   = false
        
        layer.cornerRadius                          = 10
        layer.borderWidth                           = 2
        layer.borderColor                           = UIColor.systemGray4.cgColor
        
        textColor                                   = .label
        tintColor                                   = .label
        textAlignment                               = .center
        font                                        = .preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth                   = true
        minimumFontSize                             = 12

        backgroundColor                             = .tertiarySystemBackground
        autocorrectionType                          = .no
        returnKeyType                               = .go
        clearButtonMode                             = .whileEditing
    }
}
