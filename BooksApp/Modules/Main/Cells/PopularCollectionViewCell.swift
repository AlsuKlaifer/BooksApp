//
//  PopularCollectionViewCell.swift
//  BooksApp
//
//  Created by Alsu Faizova on 30.04.2023.
//

import UIKit
import Combine

final class PopularCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = "PopularCollectionViewCell"

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
        label.text = "Popular"
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.text = "Author"
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

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init (coder:) has not been implemented")
    }

    func setupView() {
        backgroundColor = .systemGray6
        self.layer.cornerRadius = 10
        addSubview(popularLabel)
        addSubview(popularImageView)
        addSubview(authorLabel)
    }

    func configureCell(with book: ListItem) {
        switch book {
        case .book(let book):
            popularLabel.text = book.volumeInfo.title.uppercased()
            authorLabel.text = book.volumeInfo.authors?[0]
            popularImageView.downloadImage(from: book.volumeInfo.imageLinks.thumbnail)
            guard let stars = book.volumeInfo.averageRating else { return }
            starsView.updateView(starsCount: 5, rating: stars)
        case .category:
            return
        }
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

        NSLayoutConstraint.activate([
            stackview.leadingAnchor.constraint(equalTo: popularImageView.trailingAnchor, constant: 30),
            stackview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            stackview.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        ])
    }
}
