//
//  ReadCollectionViewCell.swift
//  BooksApp
//
//  Created by Alsu Faizova on 25.05.2023.
//

import UIKit

final class ReadCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ReadCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let deleteButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: .zero, weight: .light, scale: .small)
        button.setImage(UIImage(systemName: "xmark", withConfiguration: config), for: .normal)
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(ReadCollectionViewCell.self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init (coder:) has not been implemented")
    }

    func configureCell(with book: BookModel) {
        label.text = book.title.uppercased()
        imageView.downloadImage(from: book.image ?? "")
    }
    
    @objc func deleteButtonTapped() {
        
    }

    func setConstraints () {
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30)
        ])
        
        addSubview(deleteButton)
        NSLayoutConstraint.activate([
            deleteButton.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
        
        addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10)
        ])
    }
}
