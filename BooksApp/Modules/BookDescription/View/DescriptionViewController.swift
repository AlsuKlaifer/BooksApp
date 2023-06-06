//
//  DescriptionViewController.swift
//  BooksApp
//
//  Created by Alsu Faizova on 11.05.2023.
//

import UIKit

final class DescriptionViewController: UIViewController {

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
        button.tintColor = .systemYellow
        button.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: view.bounds.height / 9).isActive = true
        button.heightAnchor.constraint(equalToConstant: view.bounds.height / 9).isActive = true
        return button
    }()
    
    // Info View
    private lazy var infoView: UIStackView = {
        let view = UIStackView()
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
        button.addTarget(self, action: #selector(readButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: view.bounds.width / 2 - 20).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }()
    
    lazy var infoButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 15
        button.setTitle("Show info", for: .normal)
        button.setTitleColor(UIColor.systemBackground, for: .normal)
        button.backgroundColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: view.bounds.width / 2 - 20).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }()
    
    lazy var modalView = createBottomView()

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
    }
    
    @objc func infoButtonTapped() {
        if #available(iOS 15.0, *) {
            if let sheet = modalView.sheetPresentationController {
                sheet.detents = [.medium(), .large()]
                sheet.prefersScrollingExpandsWhenScrolledToEdge = false
                sheet.largestUndimmedDetentIdentifier = .medium
                sheet.preferredCornerRadius = 50
            }
            present(modalView, animated: true, completion: nil)
        } else {
            present(modalView, animated: true, completion: nil)
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setConstraints()
        reloadData()
        print(view.bounds.height)
        print(view.bounds.width)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        output.viewDidLoad()
        reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        modalView.dismiss(animated: true)
    }

    // MARK: - Constraints
    
    func setConstraints() {
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.bounds.height / 19),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        view.addSubview(favoriteButton)
        NSLayoutConstraint.activate([
            favoriteButton.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 30),
            favoriteButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: -(view.bounds.height / 15.5))
        ])

        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: view.bounds.height / 23.3)
        ])
        
        view.addSubview(authorLabel)
        NSLayoutConstraint.activate([
            authorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: view.bounds.height / 93)
        ])
        
        view.addSubview(infoView)
        NSLayoutConstraint.activate([
            infoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            infoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            infoView.heightAnchor.constraint(equalToConstant: view.bounds.height / 9),
            infoView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: view.bounds.height / 31)
        ])

        infoView.addSubview(pagesStack)
        NSLayoutConstraint.activate([
            pagesStack.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 20),
            pagesStack.topAnchor.constraint(equalTo: infoView.topAnchor, constant: view.bounds.height / 46.6)
        ])

        infoView.addSubview(ratingStack)
        NSLayoutConstraint.activate([
            ratingStack.centerXAnchor.constraint(equalTo: infoView.centerXAnchor, constant: -5),
            ratingStack.topAnchor.constraint(equalTo: infoView.topAnchor, constant: view.bounds.height / 46.6)
        ])
        
        infoView.addSubview(languageStack)
        NSLayoutConstraint.activate([
            languageStack.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -20),
            languageStack.topAnchor.constraint(equalTo: infoView.topAnchor, constant: view.bounds.height / 46.6)
        ])
        
        let stack = UIStackView(arrangedSubviews: [readButton, infoButton])
        stack.axis = .horizontal
        stack.spacing = 10
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            stack.topAnchor.constraint(equalTo: infoView.bottomAnchor, constant: view.bounds.height / 23.3)
        ])
    }
}

extension DescriptionViewController: DescriptionViewInput {
    
    func reloadData() {
        let book = output.book
        titleLabel.text = book.volumeInfo.title
        authorLabel.text = book.volumeInfo.authors?[0]
        imageView.downloadImage(from: book.volumeInfo.imageLinks?.thumbnail ?? "https://i.pinimg.com/originals/8d/b1/95/8db195a0990c29a50a63ea8e7767c6e8.jpg")
        
        // Reload read button
        let title = output.isRead ? "Remove from read" : "Add to read"
        readButton.setTitle(title, for: .normal)
        let titleColor = output.isRead ? UIColor.label : .systemBackground
        readButton.setTitleColor(titleColor, for: .normal)
        readButton.backgroundColor = output.isRead ? .systemGray6 : .label
        
        // Reload favorite button
        let imageName = output.isFavorite ? "bookmark.fill" : "bookmark"
        let config = UIImage.SymbolConfiguration(pointSize: .maximum(30, 30), weight: .medium, scale: .large)
        favoriteButton.setImage(UIImage(systemName: imageName, withConfiguration: config), for: .normal)
    }
}

extension DescriptionViewController {
    
    func createStackView(_ title: UILabel, _ value: UILabel) -> UIStackView {
        let stack = UIStackView(arrangedSubviews: [title, value])
        stack.axis = .vertical
        stack.spacing = view.bounds.height / 116.5
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
    
    func createBottomView() -> UIViewController {
        let viewController = DetailModuleBuilder(book: output.book).build()
        viewController.modalPresentationStyle = .pageSheet
        return viewController
    }
}
