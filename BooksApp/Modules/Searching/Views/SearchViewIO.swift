//
//  SearchViewIO.swift
//  BooksApp
//
//  Created by Alsu Faizova on 06.06.2023.
//

import UIKit

// view
protocol SearchViewInput: AnyObject {
    func reloadData()
}

// presenter
protocol SearchViewOutput: AnyObject {
    var data: [Book] { get set }
    func didSelectItem(book: Book)
    func updateFavorite(book: Book)
    func getFavorite(book: Book) -> Bool
    func viewDidLoad()
    func willDisplay(type: String, orderBy: String?, filter: String?, startIndex: Int, completion: @escaping () -> Void)
    func getBooks(type: String, orderBy: String?, filter: String?, startIndex: Int)
    func search(with: String, type: String, orderBy: String?, filter: String?, completion: @escaping ([Book]) -> Void)
}
