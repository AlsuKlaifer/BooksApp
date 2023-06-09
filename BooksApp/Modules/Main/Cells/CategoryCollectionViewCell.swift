//
//  CategoryCollectionViewCell.swift
//  BooksApp
//
//  Created by Alsu Faizova on 30.04.2023.
//

import UIKit

final class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "CategoryCollectionViewCell"
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Category"
        label.font = .systemFont(ofSize: 15)
        label.tintColor = .label
        label.backgroundColor = UIColor(red: 1, green: 184 / 255, blue: 45 / 255, alpha: 1)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 15
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
        setConstraints()
    }

    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.categoryLabel.backgroundColor = UIColor(red: 250 / 255, green: 136 / 255, blue: 42 / 255, alpha: 1)
            } else {
                self.categoryLabel.backgroundColor = UIColor(red: 1, green: 184 / 255, blue: 45 / 255, alpha: 1)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init (coder:) has not been implemented")
    }

    func setupView() {
        backgroundColor = .systemBackground
        addSubview(categoryLabel)
    }

    func configureCell(with category: ListItem) {
        switch category {
        case .book:
            return
        case .category(let category):
            categoryLabel.text = category
        }
    }

    func setConstraints() {
        NSLayoutConstraint.activate([
            categoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            categoryLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            categoryLabel.heightAnchor.constraint(equalToConstant: 30),
            categoryLabel.widthAnchor.constraint(equalToConstant: 110)
        ])
    }
}
