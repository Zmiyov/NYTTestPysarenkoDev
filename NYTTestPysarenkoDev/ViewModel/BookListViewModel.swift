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
        
        let fetchRequest = NSFetchRequest<BookEntity>(entityName:"BookEntity")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "rank", ascending:true)]

//        fetchRequest.predicate = NSPredicate(format: "bookID in %@", argumentArray: [bookIDs ?? []])
//        fetchRequest.predicate = NSPredicate(format: "categories == %@", encodedName)
//        fetchRequest.predicate = NSPredicate(format: "SUBQUERY(categories, $category, $category.bookCategoryName = $@).@count>0", encodedName)
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

        dataProvider.getBooks(name: encodedName, date: date) { [weak self] (bookIDsArray, error) in
            if let bookIDsArray = bookIDsArray {
                self?.bookIDs = bookIDsArray
                
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
    
}
