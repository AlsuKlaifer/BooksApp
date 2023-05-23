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
    func updateRead(with id: String)
    func delete(id: String)
    func deleteAll()
}

final class BookStorage: BookStorageProtocol {
    
    private let parser: BookParserProtocol
    
    init(parser: BookParserProtocol) {
        self.parser = parser
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

        parser.parseToBookModel(book: book, bookModel: bookModel)
        
        saveContext()
    }
    
    func readBooks() -> [Book] {
        let fetchRequest = BookModel.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        guard let bookModels = try? context.fetch(fetchRequest) else { return [] }

        return bookModels.map {
            parser.parseToBook(bookModel: $0)
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
        return parser.parseToBook(bookModel: bookModel)
    }
    
    func updateFavorite(with id: String) {
        let bookModel = getBookModel(with: id)
        bookModel?.isFavorite.toggle()
        saveContext()
    }
    
    func updateRead(with id: String) {
        let bookModel = getBookModel(with: id)
        bookModel?.isReaded.toggle()
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
