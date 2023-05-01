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
        imageView.contentMode = .center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let newLabel: UILabel = {
        let label = UILabel()
        label.text = "New"
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
        addSubview(newLabel)
        addSubview(newImageView)
    }

    func configureCell(name: String, imageName: String) {
        newLabel.text = name
        newImageView.image = UIImage(systemName: imageName)
    }

    func setConstraints () {
        NSLayoutConstraint.activate([
            newLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            newLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            newImageView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            newImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0)
        ])
    }
}
