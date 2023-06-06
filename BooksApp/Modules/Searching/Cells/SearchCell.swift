//
//  SearchCell.swift
//  BooksApp
//
//  Created by Alsu Faizova on 05.06.2023.
//

import UIKit

final class SearchCell: UITableViewCell {
    
    static let reuseIdentifier = "SearchCell"

    var isFavorite = false
    var favoriteButtonAction: (() -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init (coder:) has not been implemented")
    }
    
    private let view: UIView = {
        let content = UIView()
        content.translatesAutoresizingMaskIntoConstraints = false
        content.backgroundColor = .clear
        content.layer.cornerRadius = 10
        content.layer.borderColor = UIColor.gray.cgColor
        content.layer.borderWidth = 1
        return content
    }()

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
    
    override func layoutSubviews() {
        let margins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        contentView.frame = contentView.frame.inset(by: margins)
        contentView.layer.cornerRadius = 8
        super.layoutSubviews()
    }
    
    func configureCell(with book: Book) {
        popularLabel.text = book.volumeInfo.title.uppercased()
        authorLabel.text = book.volumeInfo.authors?[0]
        popularImageView.downloadImage(from: book.volumeInfo.imageLinks?.thumbnail ?? "")
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
    }

    func setConstraints () {
        addSubview(view)
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            view.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
                
        view.addSubview(popularImageView)
        NSLayoutConstraint.activate([
            popularImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            popularImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            popularImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5),
            popularImageView.widthAnchor.constraint(equalToConstant: 80)
        ])
        
        let stackview = UIStackView(arrangedSubviews: [popularLabel, authorLabel, starsView])
        stackview.axis = .vertical
        stackview.spacing = 5
        stackview.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackview)
        NSLayoutConstraint.activate([
            stackview.leadingAnchor.constraint(equalTo: popularImageView.trailingAnchor, constant: 30),
            stackview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            stackview.topAnchor.constraint(equalTo: view.topAnchor, constant: 15)
        ])
        
        addSubview(favoriteButton)
        NSLayoutConstraint.activate([
            favoriteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            favoriteButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10)
        ])
    }
}
