//
//  NewCollectionViewCell.swift
//  BooksApp
//
//  Created by Alsu Faizova on 30.04.2023.
//

import UIKit

final class NewCollectionViewCell: UICollectionViewCell {

    private let newImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let newLabel: UILabel = {
        let label = UILabel()
        label.text = "New"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
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
        addSubview(newImageView)
        addSubview(newLabel)
    }

    func configureCell(with book: ListItem) {
        switch book {
        case .book(let book):
            newLabel.text = book.volumeInfo.title.uppercased()
            newImageView.image = UIImage(systemName: "sun.max.fill")
        case .category:
            return
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newImageView.image = UIImage(systemName: "sun.max.fill") // не работает
        newLabel.text = nil
    }

    func setConstraints () {
        NSLayoutConstraint.activate([
            newImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            newImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            newImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            newImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            newLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            newLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        ])
    }
}
