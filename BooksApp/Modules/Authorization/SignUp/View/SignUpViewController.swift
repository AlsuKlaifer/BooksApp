//
//  SignUpViewController.swift
//  BooksApp
//
//  Created by Alsu Faizova on 02.04.2023.
//

import UIKit

class SignUpViewController: UIViewController {
    
    private let output: SignUpViewOutput
    
    init(output: SignUpPresenter) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setConstraints()
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "Sign up"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = TextField(imageName: "person", placeholder: "Name")
        textField.placeholder = "Name"
        return textField
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = TextField(imageName: "envelope", placeholder: "Email address")
        return textField
    }()
    
    private lazy var passwordTextField1: UITextField = {
        let textField = TextField(imageName: "lock", placeholder: "Password")
        textField.isSecureTextEntry = true
        textField.enablePasswordToggle()
        return textField
    }()
    
    private lazy var passwordTextField2: UITextField = {
        let textField = TextField(imageName: "lock", placeholder: "Password")
        textField.isSecureTextEntry = true
        textField.enablePasswordToggle()
        return textField
    }()
    
    lazy var signUpButton: UIButton = {
        let button = Button(title: "Sign up")
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        return button
    }()
        
    @objc func signUpButtonTapped() {
        guard let name = nameTextField.text,
            let email = emailTextField.text,
            let password = passwordTextField1.text,
            let password2 = passwordTextField2.text
        else {
            showAlert("Enter all fields")
            return
        }
        if password != password2 {
            showAlert("Passwords don't match, please try again")
        } else {
            output.signUp(name: name, email, password)
        }
    }
}

extension SignUpViewController: SignUpViewInput {
    func showAlert(_ message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
    func setConstraints() {
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30)
        ])
        
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.spacing = 20
        stackview.translatesAutoresizingMaskIntoConstraints = false

        stackview.addArrangedSubview(nameTextField)
        stackview.addArrangedSubview(emailTextField)
        stackview.addArrangedSubview(passwordTextField1)
        stackview.addArrangedSubview(passwordTextField2)
        
        view.addSubview(stackview)
        view.addSubview(signUpButton)

        NSLayoutConstraint.activate([
            stackview.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            stackview.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            stackview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            stackview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
        
        NSLayoutConstraint.activate([
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            signUpButton.topAnchor.constraint(equalTo: stackview.bottomAnchor, constant: 50)
        ])
    }
}
