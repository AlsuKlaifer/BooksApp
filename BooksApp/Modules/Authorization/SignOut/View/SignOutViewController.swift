//
//  SignOutViewController.swift
//  BooksApp
//
//  Created by Alsu Faizova on 03.04.2023.
//

import UIKit

class SignOutViewController: UIViewController {
    
    private let output: SignOutViewOutput
    
    init(output: SignOutPresenter) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var signOutButton: UIButton = {
        let button = Button()
        button.setTitle("Sign out", for: .normal)
        button.addTarget(self, action: #selector(signOutButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func signOutButtonTapped() {
        output.signOut()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setConstraint()
    }
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 60
        image.image = UIImage(systemName: "person.circle.fill")
        image.tintColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "Alsu Faizova"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        return label
    }()
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "gmail@gmail.com"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        return label
    }()
    
    lazy var changePasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Change password", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        button.titleLabel?.font = .systemFont(ofSize: 19.0, weight: .light)
        button.addTarget(self, action: #selector(changePasswordButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func changePasswordButtonTapped() {
        output.changePassword()
    }
}

extension SignOutViewController: SignOutViewInput {
    func showAlert(_ message: String) {}
    
    func setConstraint() {
        view.addSubview(signOutButton)
        view.addSubview(imageView)
        view.addSubview(nameLabel)
        view.addSubview(emailLabel)
        view.addSubview(changePasswordButton)

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 130),
            imageView.heightAnchor.constraint(equalToConstant: 120),
            imageView.widthAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5)
        ])
        
        NSLayoutConstraint.activate([
            changePasswordButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            changePasswordButton.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 100)
        ])
        
        NSLayoutConstraint.activate([
            signOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            signOutButton.topAnchor.constraint(equalTo: changePasswordButton.bottomAnchor, constant: 100)
        ])
    }
}
