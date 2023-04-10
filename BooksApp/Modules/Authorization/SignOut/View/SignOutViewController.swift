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
        let button = UIButton(type: .system)
        button.setTitle("Sign out", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(signOutButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func signOutButtonTapped() {
        output.signOut()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray5
        setConstraint()
    }
}

extension SignOutViewController: SignOutViewInput {
    func showAlert(_ message: String) {}
    
    func setConstraint() {
        view.addSubview(signOutButton)
        
        signOutButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            signOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            signOutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0)
        ])
    }
}
