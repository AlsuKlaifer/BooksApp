//
//  Book.swift
//  BooksApp
//
//  Created by Alsu Faizova on 30.04.2023.
//

import Foundation

struct Book: Hashable, Decodable {
    let kind: String
    let id: String
    let etag: String
    let selfLink: String
    let volumeInfo: VolumeInfo
    let saleInfo: SaleInfo
    let accessInfo: AccessInfo
//    let searchInfo: String?
}

struct VolumeInfo: Hashable, Decodable {
    let title: String
    let authors: [String]?
    let publisher: String
    let publishedDate: String
    let description: String?
    let imageLinks: ImageLinks
    let pageCount: Int
    let categories: [String]?
    let averageRating: Float?
    let language: String
    let previewLink: String
}

struct SaleInfo: Hashable, Decodable {
    let saleability: String
    let isEbook: Bool
    let listPrice: ListPrice?
    let buyLink: String?
}

struct AccessInfo: Hashable, Decodable {
    let country: String
    let epub: Pdf
    let pdf: Pdf
    let webReaderLink: String
}

struct ListPrice: Hashable, Decodable {
    let amount: Float
}

struct Pdf: Hashable, Decodable {
    let isAvailable: Bool
}

struct ImageLinks: Hashable, Decodable {
    let thumbnail: String
}

//struct Book: Hashable, Decodable {
//    let title: String
//    let author: String
//    let image: String
//}
