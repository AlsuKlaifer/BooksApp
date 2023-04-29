//
//  NewCollectionViewCell.swift
//  BooksApp
//
//  Created by Alsu Faizova on 27.04.2023.
//

import UIKit

class NewCollectionViewCell: UICollectionViewCell {
    
    private let newImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let newLabel: UILabel = {
        let label = UILabel()
        label.text = "new"
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
        backgroundColor = .systemBackground
        addSubview(newLabel)
        addSubview(newImageView)
    }
    
    func configureCell(newName: String, imageName: String) {
        newLabel.text = newName
        newImageView.image = UIImage(systemName: imageName)
    }
    
    func setConstraints () {
        NSLayoutConstraint.activate([
            newImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            newImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            newImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            newImageView.topAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }
}
