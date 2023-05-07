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
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let popularLabel: UILabel = {
        let label = UILabel()
        label.text = "Popular"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
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
            popularLabel.text = book.title
            popularImageView.image = UIImage(systemName: book.image)
        case .category:
            return
        }
    }

    func setConstraints () {
        NSLayoutConstraint.activate([
            popularImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            popularImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            popularImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            popularImageView.widthAnchor.constraint(equalToConstant: 100)
        ])

        NSLayoutConstraint.activate([
            popularLabel.leadingAnchor.constraint(equalTo: popularImageView.trailingAnchor, constant: 50),
            popularLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        ])
    }
}
