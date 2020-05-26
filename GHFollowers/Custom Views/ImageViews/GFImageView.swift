//
//  GFImageView.swift
//  GHFollowers
//
//  Created by Muhammad Umer Farooq on 16/05/2020.
//  Copyright © 2020 Muhammad Umer Farooq. All rights reserved.
//

import UIKit

class GFImageView: UIImageView {
    
    let cache = NetworkManager.shared.cache
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        clipsToBounds = true
        image = Images.placeholderImage
    }
    
    
    func downloadImage(from url: String) {
        NetworkManager.shared.downloadImage(with: url) { image in
            guard let image = image else { return }
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
