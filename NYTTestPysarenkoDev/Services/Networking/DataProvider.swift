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
    
    func getBooks(name: String, date: String, completion: @escaping([String]?, Error?) -> Void) {
        repository.fetchBooksJSON(name: name, date: date) { jsonDictionary, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let jsonDictionary = jsonDictionary else {
                completion(nil, error)
                return
            }
            
            let taskContext = self.persistentContainer.newBackgroundContext()
            taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            
            _ = self.syncBooks(name: name, jsonDictionary: jsonDictionary, taskContext: taskContext)
            
            let bookIDs = jsonDictionary.map { $0["book_uri"] as? String }.compactMap{ $0 }
            
            completion(bookIDs, nil)
        }
    }
    
    private func syncBooks(name: String, jsonDictionary: [[String: Any]], taskContext: NSManagedObjectContext) -> Bool {
        
        var successfull = false
        
        taskContext.performAndWait {
            let matchingBooksRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BookEntity")
            let bookIDs = jsonDictionary.map { $0["book_uri"] as? String }.compactMap{ $0 }
            let bookIDpredicate = NSPredicate(format: "bookID in %@", argumentArray: [bookIDs])
            let nonEmptyPredicate = NSPredicate(format: "ANY categories.bookCategoryName != nil AND ANY categories.bookCategoryName CONTAINS [cd] %@", name)
            let andPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [bookIDpredicate, nonEmptyPredicate])
            matchingBooksRequest.predicate = andPredicate
            
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: matchingBooksRequest)
            batchDeleteRequest.resultType = .resultTypeObjectIDs
            
            do {
                let batchDeleteResult = try taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult
                
                if let deletedBookIDs = batchDeleteResult?.result as? [NSManagedObjectID] {
                    NSManagedObjectContext.mergeChanges(fromRemoteContextSave: [NSDeletedObjectsKey: deletedBookIDs], into: [self.persistentContainer.viewContext])
                }
            } catch {
                print("Error: \(error)\nCould not batch delete existing records.")
                return
            }
            
            for bookDictionary in jsonDictionary {
                guard let book = NSEntityDescription.insertNewObject(forEntityName: "BookEntity", into: taskContext) as? BookEntity else {
                    print("Error: Failed to create a new Film object!")
                    return
                }
                
                do {
//                    if let bookCategories = book.categories {
//                        let array = bookCategories.map{ ($0 as? BookCategoriesEntity)?.bookCategoryName as? String }
//                        if !array.contains(name) {
//                            let bookCategory = BookCategoriesEntity(context: taskContext)
//                            bookCategory.bookCategoryName = name
//                            book.addToCategories(bookCategory)
//                            try book.update(with: bookDictionary)
//                            print("Add cat")
//                        }
//                    }
                    
                    try book.update(name: name, with: bookDictionary)
                } catch {
                    print("Error: \(error)\nThe Book object will be deleted.")
                    taskContext.delete(book)
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
    
    
    
    
    
    func getCategories(completion: @escaping(Error?) -> Void) {
        repository.fetchCategoriesJSON() { jsonDictionary, error in
            if let error = error {
                completion(error)
                return
            }
            
            guard let jsonDictionary = jsonDictionary else {
                completion(error)
                return
            }
            
            let taskContext = self.persistentContainer.newBackgroundContext()
            taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            
            _ = self.syncCategories(jsonDictionary: jsonDictionary, taskContext: taskContext)
            
            completion(nil)
        }
    }
    
    private func syncCategories(jsonDictionary: [[String: Any]], taskContext: NSManagedObjectContext) -> Bool {
        
        var successfull = false
        
        taskContext.performAndWait {
            let matchingBooksRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CategoryEntity")
            
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: matchingBooksRequest)
            batchDeleteRequest.resultType = .resultTypeObjectIDs
            
            do {
                let batchDeleteResult = try taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult
                
                if let deletedBookIDs = batchDeleteResult?.result as? [NSManagedObjectID] {
                    NSManagedObjectContext.mergeChanges(fromRemoteContextSave: [NSDeletedObjectsKey: deletedBookIDs], into: [self.persistentContainer.viewContext])
                }
            } catch {
                print("Error: \(error)\nCould not batch delete existing records.")
                return
            }
            
            for categoryDictionary in jsonDictionary {
                guard let category = NSEntityDescription.insertNewObject(forEntityName: "CategoryEntity", into: taskContext) as? CategoryEntity else {
                    print("Error: Failed to create a new Film object!")
                    return
                }
                
                do {
                    try category.update(with: categoryDictionary)
                } catch {
                    print("Error: \(error)\nThe Category object will be deleted.")
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
