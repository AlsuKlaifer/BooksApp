//
//  DescriptionViewController.swift
//  BooksApp
//
//  Created by Alsu Faizova on 11.05.2023.
//

import UIKit

class DescriptionViewController: UIViewController {

    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.image = UIImage(systemName: "book")
        image.tintColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "Book title".uppercased()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        return label
    }()
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "Author"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        return label
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = RoundButton()
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.addTarget(self, action: #selector(readButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var shareButton: UIButton = {
        let button = RoundButton()
        button.setImage(UIImage(systemName: "person"), for: .normal)
        button.addTarget(self, action: #selector(readButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var downloadButton: UIButton = {
        let button = RoundButton()
        button.setImage(UIImage(systemName: "house"), for: .normal)
        button.addTarget(self, action: #selector(readButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var readButton: UIButton = {
        let button = UIButton()
        button.setTitle("START READING", for: .normal)
        button.addTarget(self, action: #selector(readButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 25
        button.tintColor = .white
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 250).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }()
    
    @objc func readButtonTapped() {
//        output.changePassword(password: password, newPassword: newPassword)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setConstraints()
    }
    
    func setConstraints() {
        view.addSubview(imageView)
        view.addSubview(nameLabel)
        view.addSubview(emailLabel)
        view.addSubview(readButton)
        
        let stackview = UIStackView(arrangedSubviews: [favoriteButton, downloadButton, shareButton])
        
        stackview.axis = .horizontal
        stackview.spacing = 40
        stackview.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackview)

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 110),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            stackview.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            stackview.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            readButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            readButton.topAnchor.constraint(equalTo: stackview.bottomAnchor, constant: 40)
        ])
    }
}

// MARK: - SwiftUI

import SwiftUI

struct DescriptionProvider: PreviewProvider {
    static var previews: some View {
        ContainterView().edgesIgnoringSafeArea(.all)
    }

    struct ContainterView: UIViewControllerRepresentable {
        func updateUIViewController(_ uiViewController: DescriptionViewController, context: Context) { }

        let descriptionVC = DescriptionViewController()
        func makeUIViewController(
            context: UIViewControllerRepresentableContext<DescriptionProvider.ContainterView>
        ) -> DescriptionViewController {
            return descriptionVC
        }
    }
}
