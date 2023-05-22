//
//  BookModel+CoreDataProperties.swift
//  BooksApp
//
//  Created by Alsu Faizova on 23.05.2023.
//
//

import Foundation
import CoreData


extension BookModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookModel> {
        return NSFetchRequest<BookModel>(entityName: "BookModel")
    }

    @NSManaged public var id: String
    @NSManaged public var title: String
    @NSManaged public var author: String?
    @NSManaged public var isFavorite: Bool
    @NSManaged public var publishedDate: String?
    @NSManaged public var descriptions: String?
    @NSManaged public var image: String?
    @NSManaged public var pages: NSNumber?
    @NSManaged public var category: String?
    @NSManaged public var rating: Double
    @NSManaged public var language: String?
    @NSManaged public var isEpub: Bool
    @NSManaged public var isPdf: Bool
    @NSManaged public var link: String?
    @NSManaged public var isReaded: Bool

}

extension BookModel : Identifiable {

}
