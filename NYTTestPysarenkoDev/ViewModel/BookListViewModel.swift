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
    
    lazy var fetchedResultsController: NSFetchedResultsController<BookEntity> = {
        
        let fetchRequest = NSFetchRequest<BookEntity>(entityName:"BookEntity")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "rank", ascending:true)]
        fetchRequest.predicate = NSPredicate(format: "category == %@", encodedName)

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

        dataProvider.getBooks(name: encodedName, date: date) { [weak self] (error) in
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
