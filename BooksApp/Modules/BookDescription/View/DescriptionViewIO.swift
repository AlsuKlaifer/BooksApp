//
//  DescriptionViewIO.swift
//  BooksApp
//
//  Created by Alsu Faizova on 08.05.2023.
//

import Foundation

// view
protocol DescriptionViewInput: AnyObject {
    func reloadData()
}

// presenter
protocol DescriptionViewOutput: AnyObject {
    var book: Book { get }
    func viewDidLoad()
}
