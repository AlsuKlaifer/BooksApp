//
//  SectionHeader.swift
//  BooksApp
//
//  Created by Alsu Faizova on 30.05.2023.
//

import UIKit

final class SectionHeader: UICollectionReusableView {
    
    static let reuseId = "SectionHeader"
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 15
        layer.borderColor = CGColor(red: 250 / 255, green: 136 / 255, blue: 42 / 255, alpha: 0.8)
        layer.borderWidth = 2
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
}
