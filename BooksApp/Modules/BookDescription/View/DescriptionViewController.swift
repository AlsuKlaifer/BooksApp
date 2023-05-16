//
//  DescriptionViewController.swift
//  BooksApp
//
//  Created by Alsu Faizova on 11.05.2023.
//

import UIKit

class DescriptionViewController: UIViewController {

    // Dependencies
    private let output: DescriptionViewOutput

    // MARK: - Initialization

    init(presenter: DescriptionViewOutput) {
        self.output = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.image = UIImage(systemName: "book")
        image.tintColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 10
        return image
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "Book title".uppercased()
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var authorLabel: UILabel = {
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
        reloadData()
    }
    
    func setConstraints() {
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(authorLabel)
        view.addSubview(readButton)
        
        let stackview = UIStackView(arrangedSubviews: [favoriteButton, downloadButton, shareButton])
        
        stackview.axis = .horizontal
        stackview.spacing = 40
        stackview.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackview)

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40)
        ])
        
        NSLayoutConstraint.activate([
            authorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            stackview.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            stackview.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            readButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            readButton.topAnchor.constraint(equalTo: stackview.bottomAnchor, constant: 40)
        ])
    }
}

extension DescriptionViewController: DescriptionViewInput {
    func reloadData() {
        let book = output.book
        titleLabel.text = book.volumeInfo.title
        authorLabel.text = book.volumeInfo.authors?[0]
        imageView.downloadImage(from: book.volumeInfo.imageLinks.thumbnail)
    }
}
