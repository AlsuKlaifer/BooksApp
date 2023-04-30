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

        self.layer.cornerRadius = 23
        self.tintColor = .white
        self.backgroundColor = .black
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: 250).isActive = true
        self.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
