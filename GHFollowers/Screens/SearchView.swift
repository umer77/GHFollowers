//
//  SearchView.swift
//  GHFollowers
//
//  Created by Muhammad Umer Farooq on 09/05/2020.
//  Copyright © 2020 Muhammad Umer Farooq. All rights reserved.
//

import UIKit

class SearchView: UIViewController {

    let logoImageView = UIImageView()
    let usernameTextField = GFTextField(placeholder: "Enter username")
    let followersButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    var isUsernameEntered: Bool {
        !usernameTextField.text!.isEmpty
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usernameTextField.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    private func configureLayout() {
        view.backgroundColor = .systemBackground
        view.addSubviews(logoImageView, usernameTextField, followersButton)
        configureLogo()
        configureUsernameTextField()
        configureFollowersButton()
        configureTapGestureToDismissKeyboard()
    }
    
    
    private func configureLogo() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = Images.ghLogo
        
        let topConstraint: CGFloat = DeviceType.isiPhoneSE || DeviceType.isiPhone8Zoomed ? 20 : 80
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraint),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    
    private func configureUsernameTextField() {
        usernameTextField.delegate = self
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    private func configureFollowersButton() {
        followersButton.addTarget(self, action: #selector(SearchView.onFollowersButtonTapped(sender:)), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            followersButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            followersButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            followersButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            followersButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    private func configureTapGestureToDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    
    @objc func onFollowersButtonTapped(sender: UIButton) {
        moveToFollowersView()
    }
    
    
    func moveToFollowersView() {
        guard isUsernameEntered else {
            presentAlert(title: "Empty Username", message: "Please enter a username. We need to know who to look for 😀.")
            return
        }
        usernameTextField.resignFirstResponder()
        let followersView = FollowersView(username: usernameTextField.text!)
        self.navigationController?.pushViewController(followersView, animated: true)
    }

}
extension SearchView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        moveToFollowersView()
        return true
    }
}

