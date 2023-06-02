//
//  DetailViewIO.swift
//  BooksApp
//
//  Created by Alsu Faizova on 01.06.2023.
//

import Foundation

// view
protocol DetailViewInput: AnyObject {
    
}

// presenter
protocol DetailViewOutput: AnyObject {
    var book: Book { get }
}
