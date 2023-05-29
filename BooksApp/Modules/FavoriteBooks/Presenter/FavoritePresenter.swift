//
//  FavoritePresenter.swift
//  BooksApp
//
//  Created by Alsu Faizova on 25.05.2023.
//

import Foundation

final class FavoritePresenter: FavoriteViewOutput {
    
    // Dependencies
    weak var view: FavoriteViewInput?
    private let output: FavoriteModuleOutput
    var bookStorage: BookStorageProtocol
    var bookParser: BookParserProtocol

    // Properties
    var data: [Section] = [Section.read([]), Section.favorite([])]

    // MARK: - Initialization

    init(output: FavoriteModuleOutput, bookStorage: BookStorageProtocol, bookParser: BookParserProtocol) {
        self.output = output
        self.bookStorage = bookStorage
        self.bookParser = bookParser
    }

    // MARK: - Presenter

    func viewDidLoad() {
        setBooks()
    }
    
    func setBooks() {
        let read = bookStorage.getReadBooks()
        data[0] = Section.read(read)
        
        let favorite = bookStorage.getFavoriteBooks()
        data[1] = Section.favorite(favorite)
        
        DispatchQueue.main.async {
            self.view?.reloadData()
        }
    }
    
    func didSelectItem(item: BookModel) {
        let book = bookParser.parseToBook(bookModel: item)
        output.didSelectBook(module: self, book: book)
    }
}

extension FavoritePresenter: FavoriteModuleInput {}
