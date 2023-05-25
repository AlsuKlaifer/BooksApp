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

    // MARK: - Outlets
    
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
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        return label
    }()

    lazy var favoriteButton: UIButton = {
        let button = UIButton()
        let imageName = output.isFavorite ? "bookmark.fill" : "bookmark"
        let config = UIImage.SymbolConfiguration(pointSize: .maximum(30, 30), weight: .medium, scale: .large)
        button.setImage(UIImage(systemName: imageName, withConfiguration: config), for: .normal)
        button.tintColor = .systemYellow
        button.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return button
    }()
    
    // Info View
    private lazy var infoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()

    lazy var pagesStack = createStackView(pagesTitle, pagesLabel)
    
    lazy var pagesTitle = createTitleLabel("Pages")
    
    lazy var pagesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        guard let pages = output.book.volumeInfo.pageCount else {
            label.text = "-"
            return label
        }
        label.text = "\(pages)"
        return label
    }()
    
    lazy var ratingStack = createStackView(ratingTitle, ratingLabel)
    
    lazy var ratingTitle = createTitleLabel("Rating")
    
    lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        guard let rating = output.book.volumeInfo.averageRating else {
            label.text = "-"
            return label }
        label.text = "\(rating)"
        return label
    }()
    
    lazy var languageStack = createStackView(languageTitle, languageLabel)
    
    lazy var languageTitle = createTitleLabel("Language")
    
    lazy var languageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = String(describing: output.book.volumeInfo.language).uppercased()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
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

    // MARK: - Buttons Action
    
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

    // MARK: - Constraints
    
    func setConstraints() {
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        view.addSubview(favoriteButton)
        NSLayoutConstraint.activate([
            favoriteButton.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 30),
            favoriteButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: -60)
        ])

        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40)
        ])
        
        view.addSubview(authorLabel)
        NSLayoutConstraint.activate([
            authorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10)
        ])
        
        view.addSubview(infoView)
        NSLayoutConstraint.activate([
            infoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            infoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            infoView.heightAnchor.constraint(equalToConstant: 90),
            infoView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 30)
        ])

        infoView.addSubview(pagesStack)
        NSLayoutConstraint.activate([
            pagesStack.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 20),
            pagesStack.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 20)
        ])

        infoView.addSubview(ratingStack)
        NSLayoutConstraint.activate([
            ratingStack.centerXAnchor.constraint(equalTo: infoView.centerXAnchor, constant: 0),
            ratingStack.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 20)
        ])
        
        infoView.addSubview(languageStack)
        NSLayoutConstraint.activate([
            languageStack.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -20),
            languageStack.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 20)
        ])
        
        view.addSubview(readButton)
        NSLayoutConstraint.activate([
            readButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            readButton.topAnchor.constraint(equalTo: infoView.bottomAnchor, constant: 40)
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

extension DescriptionViewController {
    
    func createStackView(_ title: UILabel, _ value: UILabel) -> UIStackView {
        let stack = UIStackView(arrangedSubviews: [title, value])
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }
    
    func createTitleLabel(_ title: String) -> UILabel {
        let label = UILabel()
        label.textColor = .label
        label.text = title
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        return label
    }
}
