//
//  PopularCollectionViewCell.swift
//  BooksApp
//
//  Created by Alsu Faizova on 27.04.2023.
//

import UIKit

class PopularCollectionViewCell: UICollectionViewCell {
    
    private let popularImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints=false
        return imageView
    }()
    
    private let popularLabel: UILabel = {
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
        addSubview(popularLabel)
        addSubview(popularImageView)
    }
    
    func configureCell(popularName: String, imageName: String) {
        popularLabel.text = popularName
        popularImageView.image = UIImage(systemName: imageName)
    }
    
    func setConstraints () {
        NSLayoutConstraint.activate([
            popularImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            popularImageView.topAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            popularImageView.widthAnchor.constraint(equalToConstant: 100),
            
            popularLabel.leadingAnchor.constraint(equalTo: popularImageView.trailingAnchor, constant: 50),
            popularLabel.topAnchor.constraint(equalTo: bottomAnchor, constant: 15)
        ])
    }
    
}
