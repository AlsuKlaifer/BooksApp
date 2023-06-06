//
//  Button.swift
//  BooksApp
//
//  Created by Alsu Faizova on 23.04.2023.
//

import UIKit

class Button: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(title: String) {
        super.init(frame: .zero)
        self.layer.cornerRadius = 15
        self.setTitle(title, for: .normal)
        self.setTitleColor(.systemBackground, for: .normal)
        self.backgroundColor = .label
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: 250).isActive = true
        self.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
