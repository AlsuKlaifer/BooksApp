//
//  ChangePasswordViewController.swift
//  BooksApp
//
//  Created by Alsu Faizova on 23.04.2023.
//

import UIKit

class ChangePasswordViewController: UIViewController {
    
    private let output: ChangePasswordViewOutput
    
    init(output: ChangePasswordViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setConstraints()
        title = "Change password"
    }
    
    private lazy var passwordTextField1: UITextField = {
        let textField = TextField()
        textField.placeholder = "Current password"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var passwordTextField2: UITextField = {
        let textField = TextField()
        textField.placeholder = "New password"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var passwordTextField3: UITextField = {
        let textField = TextField()
        textField.placeholder = "New password"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var chagePasswordButton: UIButton = {
        let button = Button()
        button.setTitle("Save", for: .normal)
        button.addTarget(self, action: #selector(chagePasswordButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func chagePasswordButtonTapped() {
        guard
            let password = passwordTextField1.text,
            let newPassword = passwordTextField2.text,
            let newPasswordRepeat = passwordTextField3.text
        else {
            showAlert("Enter all fields")
            return
        }
        if newPassword != newPasswordRepeat {
            showAlert("Passwords don't match, please try again")
        }
        output.changePassword(password: password, newPassword: newPassword)
    }
    
    func showAlert(_ message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
    func setConstraints() {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.spacing = 20
        stackview.translatesAutoresizingMaskIntoConstraints = false

        stackview.addArrangedSubview(passwordTextField1)
        stackview.addArrangedSubview(passwordTextField2)
        stackview.addArrangedSubview(passwordTextField3)
        
        view.addSubview(stackview)
        view.addSubview(chagePasswordButton)
        
        NSLayoutConstraint.activate([
            stackview.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            stackview.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            stackview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            stackview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
        
        NSLayoutConstraint.activate([
            chagePasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            chagePasswordButton.topAnchor.constraint(equalTo: stackview.bottomAnchor, constant: 50)
        ])
    }
}

extension ChangePasswordViewController: ChangePasswordViewInput {}
