//
//  DataProvider.swift
//  NYTTestPysarenkoDev
//
//  Created by Vladimir Pisarenko on 05.02.2023.
//

import Foundation
import CoreData

final class DataProvider {

    private let persistentContainer: NSPersistentContainer
    private let repository: NYTAPIManager

    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    init(persistentContainer: NSPersistentContainer, repository: NYTAPIManager) {
        self.persistentContainer = persistentContainer
        self.repository = repository
    }

    // MARK: - All categories data provider

    func getCategories(completion: @escaping(Error?) -> Void) {
        repository.load(url: ConstructURLs.categoriesURL()) { (categoryResponse: ResponseCategories?, error) in
            if let error = error {
                completion(error)
                return
            }

            guard let categoriesArray = categoryResponse?.categories else {
                completion(error)
                return
            }

            let taskContext = self.persistentContainer.newBackgroundContext()
            taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy

            _ = self.syncCategories(categoriesArray: categoriesArray, taskContext: taskContext)

            completion(nil)
        }
    }

    private func syncCategories(categoriesArray: [CategoryModel], taskContext: NSManagedObjectContext) -> Bool {

        var successfull = false

        taskContext.performAndWait {
            let matchingBooksRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CategoryEntity")

            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: matchingBooksRequest)
            batchDeleteRequest.resultType = .resultTypeObjectIDs

            do {
                let batchDeleteResult = try taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult

                if let deletedBookIDs = batchDeleteResult?.result as? [NSManagedObjectID] {
                    NSManagedObjectContext.mergeChanges(fromRemoteContextSave: [NSDeletedObjectsKey: deletedBookIDs],
                                                        into: [self.persistentContainer.viewContext])
                }
            } catch {
                print("Error: \(error)\nCould not batch delete existing records.")
                return
            }

            for category in categoriesArray {
                guard let categoryEntity = NSEntityDescription.insertNewObject(forEntityName: "CategoryEntity",
                                                                         into: taskContext) as? CategoryEntity else {
                    print("Error: Failed to create a new Film object!")
                    return
                }

                do {
                    try categoryEntity.update(with: category)
                } catch {
                    print("Error: \(error)\nThe Category object will be deleted.")
                    taskContext.delete(categoryEntity)
                }

                if taskContext.hasChanges {
                    do {
                        try taskContext.save()
                    } catch {
                        print("Error: \(error)\nCould not save Core Data context.")
                    }
                    taskContext.reset()
                }
                successfull = true
            }
        }
        return successfull
    }

    // MARK: - All books data provider

    func getBooks(name: String, date: String, completion: @escaping(Error?) -> Void) {
        repository.load(url: ConstructURLs.booksURL(for: name, date: date)) { (booksResponse: ResponseBooks?, error) in
            if let error = error {
                completion(error)
                return
            }

            guard let booksArray = booksResponse?.books else {
                completion(error)
                return
            }

            let taskContext = self.persistentContainer.newBackgroundContext()
            taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy

            _ = self.syncBooks(name: name, booksArray: booksArray, taskContext: taskContext)
            _ = self.syncBookIDsInCategory(name: name, booksArray: booksArray, taskContext: taskContext)

            completion(nil)
        }
    }

    private func syncBooks(name: String,
                           booksArray: [BookModel],
                           taskContext: NSManagedObjectContext) -> Bool {

        var successfull = false

        taskContext.performAndWait {
            let matchingBooksRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BookEntity")
            let bookIDs = booksArray.map { $0.bookID }.compactMap { $0 }
            let bookIDpredicate = NSPredicate(format: "bookID in %@", argumentArray: [bookIDs])
            matchingBooksRequest.predicate = bookIDpredicate

            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: matchingBooksRequest)
            batchDeleteRequest.resultType = .resultTypeObjectIDs

            do {
                let batchDeleteResult = try taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult

                if let deletedBookIDs = batchDeleteResult?.result as? [NSManagedObjectID] {
                    NSManagedObjectContext.mergeChanges(fromRemoteContextSave: [NSDeletedObjectsKey: deletedBookIDs],
                                                        into: [self.persistentContainer.viewContext])
                }
            } catch {
                print("Error: \(error)\nCould not batch delete existing records.")
                return
            }

            for book in booksArray {
                guard let bookEntity = NSEntityDescription.insertNewObject(forEntityName: "BookEntity",
                                                                     into: taskContext) as? BookEntity else {
                    print("Error: Failed to create a new Film object!")
                    return
                }

                do {
                    try bookEntity.update(with: book)
                } catch {
                    print("Error: \(error)\nThe Book object will be deleted.")
                    taskContext.delete(bookEntity)
                }

                if taskContext.hasChanges {
                    do {
                        try taskContext.save()
                    } catch {
                        print("Error: \(error)\nCould not save Core Data context.")
                    }
                    taskContext.reset()
                }
                successfull = true
            }
        }
        return successfull
    }

    private func syncBookIDsInCategory(name: String,
                                       booksArray: [BookModel],
                                       taskContext: NSManagedObjectContext) -> Bool {

        var successfull = false

        taskContext.performAndWait {
            let matchingCategoriesRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BookCategoriesEntity")
            let bookIDs = booksArray.map { $0.bookID }.compactMap { $0 }
            let bookIDpredicate = NSPredicate(format: "bookCategoryName = %@", name)
            matchingCategoriesRequest.predicate = bookIDpredicate

            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: matchingCategoriesRequest)
            batchDeleteRequest.resultType = .resultTypeObjectIDs

            do {
                let batchDeleteResult = try taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult

                if let deletedBookIDs = batchDeleteResult?.result as? [NSManagedObjectID] {
                    NSManagedObjectContext.mergeChanges(fromRemoteContextSave: [NSDeletedObjectsKey: deletedBookIDs],
                                                        into: [self.persistentContainer.viewContext])
                }
            } catch {
                print("Error: \(error)\nCould not batch delete existing records.")
                return
            }

            for book in booksArray {
                // swiftlint:disable line_length
                guard let category = NSEntityDescription.insertNewObject(forEntityName: "BookCategoriesEntity",
                                                                         into: taskContext) as? BookCategoriesEntity else {
                    // swiftlint:enable line_length
                    print("Error: Failed to create a new Film object!")
                    return
                }

                do {
                    for id in bookIDs {
                        try category.update(name: name, bookID: id, with: book)
                    }
                } catch {
                    print("Error: \(error)\nThe Book object will be deleted.")
                    taskContext.delete(category)
                }

                if taskContext.hasChanges {
                    do {
                        try taskContext.save()
                    } catch {
                        print("Error: \(error)\nCould not save Core Data context.")
                    }
                    taskContext.reset()
                }
                successfull = true
            }
        }
        return successfull
    }
}
