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
        let button = UIButton()
        let imageName = output.isFavorite ? "bookmark.fill" : "bookmark"
        let config = UIImage.SymbolConfiguration(pointSize: .maximum(30, 30), weight: .bold, scale: .large)
        button.setImage(UIImage(systemName: imageName, withConfiguration: config), for: .normal)
        button.tintColor = .systemYellow
        button.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return button
    }()

    lazy var shareButton: UIButton = {
        let button = RoundButton()
        let config = UIImage.SymbolConfiguration(pointSize: .zero, weight: .bold, scale: .large)
        button.setImage(UIImage(systemName: "square.and.arrow.up", withConfiguration: config), for: .normal)
//        button.addTarget(self, action: #selector(readButtonTapped), for: .touchUpInside)
        return button
    }()

    lazy var downloadButton: UIButton = {
        let button = RoundButton()
        let config = UIImage.SymbolConfiguration(pointSize: .zero, weight: .bold, scale: .large)
        button.setImage(UIImage(systemName: "house", withConfiguration: config), for: .normal)
//        button.addTarget(self, action: #selector(readButtonTapped), for: .touchUpInside)
        return button
    }()

    lazy var readButton: UIButton = {
        let button = UIButton()
        let title = output.isRead ? "Remove from read" : "Add to read"
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: #selector(readButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 25
        let titleColor = output.isRead ? UIColor.label : .systemBackground
        button.setTitleColor(titleColor, for: .normal)
        button.backgroundColor = output.isRead ? .systemGray6 : .label
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 250).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }()

    @objc func favoriteButtonTapped() {
        let config = UIImage.SymbolConfiguration(pointSize: .maximum(30, 30), weight: .bold, scale: .large)
        if output.isFavorite {
            favoriteButton.setImage(UIImage(systemName: "bookmark", withConfiguration: config), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(systemName: "bookmark.fill", withConfiguration: config), for: .normal)
        }
        favoriteButton.tintColor = .systemYellow
        output.addToFavorite()

        print("current book id: \(output.book.id)")
    }

    @objc func readButtonTapped() {
        if output.isRead {
            readButton.setTitle("Add to read", for: .normal)
            readButton.setTitleColor(UIColor.systemBackground, for: .normal)
            readButton.backgroundColor = .label
        } else {
            readButton.setTitle("Remove from read", for: .normal)
            readButton.backgroundColor = .systemGray6
            readButton.setTitleColor(UIColor.label, for: .normal)
        }
        output.addToRead()
        print("current book id: \(output.book.id)")
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
        view.addSubview(favoriteButton)

        let stackview = UIStackView(arrangedSubviews: [downloadButton, shareButton])

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
            favoriteButton.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 30),
            favoriteButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: -60)
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
