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
    
    var name: String
    var date: String
    
    lazy var fetchedResultsController: NSFetchedResultsController<BookEntity> = {
        
        let fetchRequest = NSFetchRequest<BookEntity>(entityName:"BookEntity")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "rank", ascending:true)]
        fetchRequest.predicate = NSPredicate(format: "category == %@", name)

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
        self.name = name
        self.date = date
        
        dataProvider.getBooks(name: name, date: date) { [weak self] (error) in
            self?.fetchBooks()
        }
    }
    
    func fetchBooks() {
        self.books = []
        
        if let books = fetchedResultsController.fetchedObjects {
            self.books = books
        }
    }
    
}
