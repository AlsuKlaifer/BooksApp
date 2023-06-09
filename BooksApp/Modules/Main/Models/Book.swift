//
//  Book.swift
//  BooksApp
//
//  Created by Alsu Faizova on 30.04.2023.
//

import Foundation

struct Book: Hashable, Decodable {
    let id: String
    let selfLink: String
    let volumeInfo: VolumeInfo
//    let saleInfo: SaleInfo
    let accessInfo: AccessInfo
//    let searchInfo: String?
}

struct VolumeInfo: Hashable, Decodable {
    let title: String
    let authors: [String]?
    let publishedDate: String?
    let description: String?
    let imageLinks: ImageLinks?
    let pageCount: Int?
    let categories: [String]?
    let averageRating: Double?
    let language: String
}

struct SaleInfo: Hashable, Decodable {
    let saleability: String
    let isEbook: Bool
    let listPrice: ListPrice?
    let buyLink: String?
}

struct AccessInfo: Hashable, Decodable {
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
