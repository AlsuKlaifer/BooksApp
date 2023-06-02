//
//  PopularCollectionViewCell.swift
//  BooksApp
//
//  Created by Alsu Faizova on 30.04.2023.
//

import UIKit

final class PopularCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = "PopularCollectionViewCell"

    var isFavorite = false
    var favoriteButtonAction: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init (coder:) has not been implemented")
    }

    private let popularImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        imageView.tintColor = .gray
        return imageView
    }()

    private let popularLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .label
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let authorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let starsView: StarRatingView = {
        let stars = StarRatingView(starsCount: 0, rating: 0.0)
        return stars
    }()

    private lazy var favoriteButton: UIButton =
    {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: .zero, weight: .medium, scale: .large)
        button.setImage(UIImage(systemName: "bookmark", withConfiguration: config), for: .normal)
        button.tintColor = .systemYellow
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        return button
    }()

    @objc func favoriteButtonTapped() {
        let config = UIImage.SymbolConfiguration(pointSize: .zero, weight: .medium, scale: .large)
        if isFavorite {
            favoriteButton.setImage(UIImage(systemName: "bookmark", withConfiguration: config), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(systemName: "bookmark.fill", withConfiguration: config), for: .normal)
            favoriteButton.tintColor = .systemYellow
        }
        isFavorite.toggle()
        favoriteButtonAction?()
    }

    func setupView() {
        backgroundColor = .systemGray6
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 1
        addSubview(popularLabel)
        addSubview(popularImageView)
        addSubview(authorLabel)
    }

    func configureCell(with book: ListItem) {
        switch book {
        case .book(let book):
            popularLabel.text = book.volumeInfo.title.uppercased()
            authorLabel.text = book.volumeInfo.authors?[0]
            popularImageView.downloadImage(from: book.volumeInfo.imageLinks?.thumbnail ?? "https://i.pinimg.com/originals/8d/b1/95/8db195a0990c29a50a63ea8e7767c6e8.jpg")
            if let stars = book.volumeInfo.averageRating {
                starsView.updateView(starsCount: 5, rating: stars)
            }

            // favorite button
            guard let bookModel = BookStorage(parser: BookParser()).getBookModel(with: book.id) else {
                isFavorite = false
                return
            }
            let imageName = bookModel.isFavorite ? "bookmark.fill" : "bookmark"
            let config = UIImage.SymbolConfiguration(pointSize: .zero, weight: .medium, scale: .large)
            favoriteButton.setImage(UIImage(systemName: imageName, withConfiguration: config), for: .normal)
            
        case .category:
            return
        }
    }

    func configureCellBookModel(with book: BookModel) {
        popularLabel.text = book.title.uppercased()
        authorLabel.text = book.author
        popularImageView.downloadImage(from: book.image ?? "")
        isFavorite = book.isFavorite
        if let stars = book.rating {
            starsView.updateView(starsCount: 5, rating: Double(truncating: stars))
        }

        // favorite button
        guard let bookModel = BookStorage(parser: BookParser()).getBookModel(with: book.id) else {
            isFavorite = false
            return
        }
        let imageName = bookModel.isFavorite ? "bookmark.fill" : "bookmark"
        let config = UIImage.SymbolConfiguration(pointSize: .zero, weight: .medium, scale: .large)
        favoriteButton.setImage(UIImage(systemName: imageName, withConfiguration: config), for: .normal)
    }

    func setConstraints () {
        let stackview = UIStackView(arrangedSubviews: [popularLabel, authorLabel, starsView])

        stackview.axis = .vertical
        stackview.spacing = 5
        stackview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackview)

        NSLayoutConstraint.activate([
            popularImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            popularImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            popularImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            popularImageView.widthAnchor.constraint(equalToConstant: 80)
        ])

        addSubview(favoriteButton)
        NSLayoutConstraint.activate([
            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            favoriteButton.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            stackview.leadingAnchor.constraint(equalTo: popularImageView.trailingAnchor, constant: 30),
            stackview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            stackview.topAnchor.constraint(equalTo: topAnchor, constant: 15)
        ])
    }
}
