//
//  SignOutViewController.swift
//  BooksApp
//
//  Created by Alsu Faizova on 03.04.2023.
//

import UIKit
import PhotosUI

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
        let button = Button(title: "Sign out")
        button.addTarget(self, action: #selector(signOutButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func signOutButtonTapped() {
        output.signOut()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        reloadData()
        setConstraint()
    }
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 70
        image.image = UIImage(systemName: "person.circle.fill")
        image.tintColor = .gray
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        return label
    }()
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        return label
    }()
    
    lazy var changePasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Change password", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 19.0, weight: .light)
        button.addTarget(self, action: #selector(changePasswordButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var addPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add photo", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 19.0, weight: .light)
        button.addTarget(self, action: #selector(addPhotoButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func changePasswordButtonTapped() {
        output.changePassword()
    }
    
    @objc func addPhotoButtonTapped() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        
        if #available(iOS 15.0, *) {
            if let sheet = picker.presentationController as? UISheetPresentationController {
                sheet.detents = [.medium(), .large()]
                sheet.prefersScrollingExpandsWhenScrolledToEdge = false
                sheet.largestUndimmedDetentIdentifier = .medium
            }
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func reloadData() {
        output.getUser { user in
            self.nameLabel.text = user?.name
            self.emailLabel.text = user?.email
        }
    }
}

extension SignOutViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        if results.isEmpty {
            picker.dismiss(animated: true)
            return
        }
        
        for item in results {
            item.itemProvider.loadObject(ofClass: UIImage.self) { image, _ in
                if let image = image as? UIImage {
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
            }
        }
        if #available(iOS 15.0, *) { 
            if let sheet = picker.presentationController as? UISheetPresentationController {
                sheet.animateChanges {
                    sheet.selectedDetentIdentifier = .medium
                }
            }
        } else {
            dismiss(animated: true)
        }
    }
}

extension SignOutViewController: SignOutViewInput {
    
    func showAlert(_ message: String) {}
    
    func setConstraint() {
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 130),
            imageView.heightAnchor.constraint(equalToConstant: 140),
            imageView.widthAnchor.constraint(equalToConstant: 140)
        ])

        view.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30)
        ])

        view.addSubview(emailLabel)
        NSLayoutConstraint.activate([
            emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5)
        ])

        view.addSubview(changePasswordButton)
        NSLayoutConstraint.activate([
            changePasswordButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            changePasswordButton.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 100)
        ])

        view.addSubview(addPhotoButton)
        NSLayoutConstraint.activate([
            addPhotoButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            addPhotoButton.topAnchor.constraint(equalTo: changePasswordButton.bottomAnchor, constant: 10)
        ])

        view.addSubview(signOutButton)
        NSLayoutConstraint.activate([
            signOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            signOutButton.topAnchor.constraint(equalTo: addPhotoButton.bottomAnchor, constant: 100)
        ])
    }
}
