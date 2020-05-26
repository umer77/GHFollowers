//
//  UIViewController+Extension.swift
//  GHFollowers
//
//  Created by Muhammad Umer Farooq on 09/05/2020.
//  Copyright © 2020 Muhammad Umer Farooq. All rights reserved.
//

import UIKit
import SafariServices

fileprivate var containerView: UIView!

extension UIViewController {
    
    func presentAlert(title: String, message: String) {
        DispatchQueue.main.async {
            let alertview = GFAlertView(alertTitle: title, alertMessage: message)
            alertview.modalPresentationStyle = .overFullScreen
            alertview.modalTransitionStyle = .crossDissolve
            self.present(alertview, animated: true, completion: nil)
        }
    }
    
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25, animations: { containerView.alpha = 0.8 })
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        activityIndicator.startAnimating()
    }
    
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
    
    
    func presentSafariViewController(with url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.preferredControlTintColor = .systemGreen
        present(safariViewController, animated: true)
    }
    
    
    func showEmptyStateView(with message: String) {
        DispatchQueue.main.async {
            if containerView != nil {
                self.view.bringSubviewToFront(containerView)
                return
            }
            containerView = GFEmptyStateView(message: message)
            containerView.frame = self.view.bounds
            self.view.addSubview(containerView)
        }
    }
}
