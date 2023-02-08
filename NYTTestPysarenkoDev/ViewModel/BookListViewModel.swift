//
//  BookViewModel.swift
//  NYTTestPysarenkoDev
//
//  Created by Vladimir Pisarenko on 03.02.2023.
//

import Foundation
import CoreData

final class BookListViewModel {

    var dataProvider = DataProvider(persistentContainer: CoreDataStack.shared.storeContainer, repository: NYTAPIManager.shared)
    
    var encodedName: String
    var titleName: String
    var date: String
    var bookIDs: [String]?
    
    lazy var fetchedResultsController: NSFetchedResultsController<BookEntity> = {
        
        let fetchRequest = NSFetchRequest<BookEntity>(entityName: "BookEntity")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "rank", ascending:true)]
        fetchRequest.predicate = NSPredicate(format: "ANY categories.bookCategoryName != nil AND ANY categories.bookCategoryName CONTAINS [cd] %@", encodedName)
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                    managedObjectContext: dataProvider.viewContext,
                                                    sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try controller.performFetch()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return controller
    }()
    
    var books = Dynamic([BookEntity]())
    
    init(encodedName: String, titleName: String, date: String) {
        self.encodedName = encodedName
        self.titleName = titleName
        self.date = date
        
//        setBookID()

        dataProvider.getBooks(name: encodedName, date: date) { [weak self] (bookIDsArray, error) in
            if let bookIDsArray = bookIDsArray {
                self?.bookIDs = bookIDsArray
                
                for bookID in bookIDsArray {
                    _ = self?.updateCategories(bookID: bookID, with: encodedName)
                }
                
            }
            self?.fetchBooks()
        }
    }
    
    func fetchBooks() {
        self.books.value = []
        
        if let books = fetchedResultsController.fetchedObjects {
            self.books.value = books
        }
        
    }
    
    func setBookID() {
        print("SetBokID1")
        guard let bookIDs = self.bookIDs else { return }
        print("SetBokID")
        for bookID in bookIDs {
            _ = updateCategories(bookID: bookID, with: encodedName)
        }
    }
    
    func updateCategories(bookID: String, with name: String) -> Bool {
        var success = false
        
        let managedContext = dataProvider.viewContext
        let fetchRequest = NSFetchRequest<BookEntity>(entityName: "BookEntity")
        fetchRequest.predicate = NSPredicate(format: "bookID = %@", bookID)
        
        do {
            let test = try managedContext.fetch(fetchRequest)
            if test.count == 1 {
                let objectUpdate = test[0] as BookEntity
                
                let bookCategory = BookCategoriesEntity(context: managedContext)
                bookCategory.bookCategoryName = name
                objectUpdate.addToCategories(bookCategory)
                try managedContext.save()
                success = true
            }
        } catch {
            print(error)
        }
        return success
    }
}
