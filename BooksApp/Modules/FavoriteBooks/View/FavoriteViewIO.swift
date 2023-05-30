//
//  FavoriteViewIO.swift
//  BooksApp
//
//  Created by Alsu Faizova on 25.05.2023.
//

import Foundation

// view
protocol FavoriteViewInput: AnyObject {
    func reloadData()
}

// presenter
protocol FavoriteViewOutput: AnyObject {
    var data: [Section] { get set }
    func didSelectItem(item: BookModel)
    func updateFavorite(item: BookModel)
    func deleteFromRead(item: BookModel)
    func viewDidLoad()
}
