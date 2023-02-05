//
//  BookViewModel.swift
//  NYTTestPysarenkoDev
//
//  Created by Vladimir Pisarenko on 03.02.2023.
//

import Foundation
import CoreData

final class BookListViewModel {

    let networkManager = NYTAPIManager.shared
    
    
    var dataProvider = DataProvider(persistentContainer: CoreDataStack(modelName: "NYTTestPysarenkoDev").storeContainer, repository: NYTAPIManager.shared)
    
    lazy var fetchedResultsController: NSFetchedResultsController<BookEntity> = {
        let fetchRequest = NSFetchRequest<BookEntity>(entityName:"BookEntity")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "rank", ascending:true)]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                    managedObjectContext: dataProvider.viewContext,
                                                    sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = delegate
        
        do {
            try controller.performFetch()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return controller
    }()
    
    
    var delegate: NSFetchedResultsControllerDelegate?
    
    var books: [BookEntity] = [] {
        didSet {
            NotificationCenter.default.post(name: .loadBooks, object: nil, userInfo: nil)
        }
    }
    
    init(name: String, date: String, delegate: NSFetchedResultsControllerDelegate) {
        
        self.delegate = delegate
        
//[        networkManager.fetchBooks(name: name, date: date) { books in
//            self.books = books
//        }
//        networkManager.fetchBooksJSON(name: name, date: date) { book, error in
//            
//        }]
        
        dataProvider.getBooks(name: name, date: date) { (error) in
            // Handle Error by displaying it in UI
        }
        
        self.books = fetchedResultsController.fetchedObjects ?? []
    }
    
    func booksCount() -> Int {
        return books.count
    }
    

}
