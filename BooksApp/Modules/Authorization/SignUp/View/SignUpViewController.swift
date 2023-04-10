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
        title = "sign up"
    }
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Email"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var passwordTextField1: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Password"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var passwordTextField2: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Password"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign up", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
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
        }
        output.signUp(email, password)
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
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.spacing = 20
        
        stackview.addArrangedSubview(nameTextField)
        stackview.addArrangedSubview(emailTextField)
        stackview.addArrangedSubview(passwordTextField1)
        stackview.addArrangedSubview(passwordTextField2)
        
        view.addSubview(stackview)
        view.addSubview(signUpButton)
        stackview.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackview.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            stackview.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            stackview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            stackview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            signUpButton.topAnchor.constraint(equalTo: stackview.bottomAnchor, constant: 50)
        ])
    }
}
