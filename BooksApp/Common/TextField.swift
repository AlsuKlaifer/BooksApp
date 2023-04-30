//
//  TextField.swift
//  BooksApp
//
//  Created by Alsu Faizova on 30.04.2023.
//

import UIKit

class TextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    func setup() {
        self.borderStyle = .roundedRect
        self.translatesAutoresizingMaskIntoConstraints = false
        self.autocapitalizationType = .none
        self.autocorrectionType = .no
        self.backgroundColor = .systemBackground
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
