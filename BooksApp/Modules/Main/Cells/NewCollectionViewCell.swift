//
//  NewCollectionViewCell.swift
//  BooksApp
//
//  Created by Alsu Faizova on 30.04.2023.
//

import UIKit

final class NewCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = "NewCollectionViewCell"
    
    private let newImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let newLabel: UILabel = {
        let label = UILabel()
        label.text = "New"
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.backgroundColor = UIColor(red: 10 / 255, green: 10 / 255, blue: 10 / 255, alpha: 0.5)
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
        addSubview(newImageView)
        addSubview(newLabel)
    }

    func configureCell(with book: ListItem) {
        switch book {
        case .book(let book):
            newLabel.text = book.volumeInfo.title.uppercased()
            newImageView.downloadImage(from: book.volumeInfo.imageLinks?.thumbnail ?? "https://i.pinimg.com/originals/8d/b1/95/8db195a0990c29a50a63ea8e7767c6e8.jpg")
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
            newImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            newLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            newLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            newLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        ])
    }
}
