//
//  RoundButton.swift
//  BooksApp
//
//  Created by Alsu Faizova on 12.05.2023.
//

import UIKit

class RoundButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.tintColor = .init(red: 1, green: 184 / 255, blue: 45 / 255, alpha: 1)
        self.layer.borderWidth = 3
        self.layer.cornerRadius = 28
        self.layer.borderColor = .init(red: 1, green: 184 / 255, blue: 45 / 255, alpha: 1)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: 56).isActive = true
        self.heightAnchor.constraint(equalToConstant: 56).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
