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
    func getListSections(sections: [ListSection])
}

// presenter
protocol BooksViewOutput: AnyObject {
    var dataSource: [ListItem] { get }
    var data: [ListSection] { get set }
    func viewDidLoad()
}
