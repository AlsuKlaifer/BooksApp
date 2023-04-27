//
//  CategoryCollectionViewCell.swift
//  BooksApp
//
//  Created by Alsu Faizova on 27.04.2023.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Category"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init (frame: frame)
        
        setupView()
        setConstraints ()
    }
    
    required init?(coder: NSCoder) {
        fatalError ("init (coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = .systemBackground
        addSubview(categoryLabel)
    }
    
    func configureCell(categoryName: String) {
        categoryLabel.text = categoryName
    }
    
    func setConstraints () {
        NSLayoutConstraint.activate([
            categoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            categoryLabel.trailingAnchor.constraint (equalTo: trailingAnchor, constant: -5),
            categoryLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            categoryLabel.topAnchor.constraint(equalTo: bottomAnchor, constant: 5),
            categoryLabel.heightAnchor.constraint(equalToConstant: 15)
        ])
    }
}
