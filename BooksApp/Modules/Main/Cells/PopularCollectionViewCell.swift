//
//  PopularCollectionViewCell.swift
//  BooksApp
//
//  Created by Alsu Faizova on 30.04.2023.
//

import UIKit

final class PopularCollectionViewCell: UICollectionViewCell {

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
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        backgroundColor = .systemGray5
        self.layer.cornerRadius = 10
        addSubview(popularLabel)
        addSubview(popularImageView)
    }

    func configureCell(with book: ListItem) {
        switch book {
        case .book(let book):
            popularLabel.text = book.volumeInfo.title.uppercased()
            popularImageView.downloadImage(from: book.volumeInfo.imageLinks.thumbnail)
        case .category:
            return
        }
    }

    func setConstraints () {
        NSLayoutConstraint.activate([
            popularImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            popularImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            popularImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            popularImageView.widthAnchor.constraint(equalToConstant: 80)
        ])

        NSLayoutConstraint.activate([
            popularLabel.leadingAnchor.constraint(equalTo: popularImageView.trailingAnchor, constant: 30),
            popularLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            popularLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        ])
    }
}
