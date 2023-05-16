//
//  BooksViewIO.swift
//  BooksApp
//
//  Created by Alsu Faizova on 08.05.2023.
//

import Foundation

// view
protocol BooksViewInput: AnyObject {
    func reloadData()
}

// presenter
protocol BooksViewOutput: AnyObject {
    var dataSourcePopular: [ListItem] { get }
    var dataSourceNew: [ListItem] { get }
    var data: [ListSection] { get set }
    func didSelectItem(item: ListItem)
    func viewDidLoad()
}
