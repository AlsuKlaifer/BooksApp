//
//  BookStorage.swift
//  BooksApp
//
//  Created by Alsu Faizova on 22.05.2023.
//

import Foundation
import CoreData

protocol BookStorageProtocol {
    func create(_ book: Book)
    func readBooks() -> [Book]
    func readBookModels() -> [BookModel]
    func getBookModel(with id: String) -> BookModel?
    func getBook(with id: String) -> Book?
    func updateFavorite(with id: String)
    func delete(id: String)
    func deleteAll()
}

final class BookStorage: BookStorageProtocol {
    
    private let conversion: ConversionProtocol
    
    init(conversion: ConversionProtocol) {
        self.conversion = conversion
    }
    
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                context.rollback()
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func create(_ book: Book) {
        guard let bookModel = NSEntityDescription.insertNewObject(
            forEntityName: "BookModel",
            into: self.context
        ) as? BookModel else {
            return
        }

//        conversion.converseToBookModel(book: book)
        bookModel.id = book.id
        bookModel.title = book.volumeInfo.title
        bookModel.author = book.volumeInfo.authors?.first
        bookModel.publishedDate = book.volumeInfo.publishedDate
        bookModel.descriptions = book.volumeInfo.description
        bookModel.image = book.volumeInfo.imageLinks.thumbnail
        bookModel.pages = book.volumeInfo.pageCount as? NSNumber
        bookModel.category = book.volumeInfo.categories?.first
        bookModel.rating = book.volumeInfo.averageRating ?? 4.0
        bookModel.language = book.volumeInfo.language
        bookModel.isEpub = book.accessInfo.epub.isAvailable
        bookModel.isPdf = book.accessInfo.pdf.isAvailable
        bookModel.link = book.selfLink
        
        saveContext()
    }
    
    func readBooks() -> [Book] {
        let fetchRequest = BookModel.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        guard let bookModels = try? context.fetch(fetchRequest) else { return [] }

        return bookModels.map {
            conversion.converseToBook(bookModel: $0)
        }
    }
    
    func readBookModels() -> [BookModel] {
        let fetchRequest = BookModel.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        guard let bookModels = try? context.fetch(fetchRequest) else { return [] }

        return bookModels
    }
    
    func getBookModel(with id: String) -> BookModel? {
        let fetchRequest = BookModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "%K == %@", "id", id as CVarArg
        )
        guard let bookModel = try? context.fetch(fetchRequest).first else { return nil }
        return bookModel
    }
    
    func getBook(with id: String) -> Book? {
        guard let bookModel = getBookModel(with: id) else { return nil }
        return conversion.converseToBook(bookModel: bookModel)
    }
    
    func updateFavorite(with id: String) {
        let bookModel = getBookModel(with: id)
        bookModel?.isFavorite.toggle()
        saveContext()
    }
    
    func delete(id: String) {
        let fetchRequest = BookModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "%K == %@", "id", id as CVarArg
        )
        guard let bookModel = try? context.fetch(fetchRequest).first else { return }
        context.delete(bookModel)
        saveContext()
    }
    
    func deleteAll() {
        let fetchRequest = BookModel.fetchRequest()
        guard let bookModels = try? context.fetch(fetchRequest) else { return }
        bookModels.forEach { context.delete($0) }
        saveContext()
    }
}
