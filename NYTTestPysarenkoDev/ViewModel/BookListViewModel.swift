//
//  BookViewModel.swift
//  NYTTestPysarenkoDev
//
//  Created by Vladimir Pisarenko on 03.02.2023.
//

import Foundation
import CoreData

final class BookListViewModel: BookListViewModelProtocol {

    var dataProvider = DataProvider(persistentContainer: CoreDataStack.shared.storeContainer,
                                    repository: NYTAPIManager.shared)
    var books = Dynamic([BookEntity]())

    var categoryNameEncoded: String
    var titleName: String
    var date: String
    var bookIDs: [String]?

    lazy var fetchedResultsController: NSFetchedResultsController<BookEntity> = {
        let fetchRequest = NSFetchRequest<BookEntity>(entityName: "BookEntity")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "rank", ascending: true)]
        fetchRequest.predicate = NSPredicate(format: "bookID in %@", argumentArray: [bookIDs ?? []])
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

    init(categoryNameEncoded: String, titleName: String, date: String) {
        self.categoryNameEncoded = categoryNameEncoded
        self.titleName = titleName
        self.date = date

        dataProvider.getBooks(name: categoryNameEncoded, date: date) { [weak self] _ in
            self?.fetchCategories(categoryNameEncoded: categoryNameEncoded)
            self?.fetchBooks()
        }
    }

    func fetchBooks() {
        self.books.value = []
        if let books = fetchedResultsController.fetchedObjects {
            self.books.value = books
        }
    }

    func fetchCategories(categoryNameEncoded: String) {
        let managedContext = dataProvider.viewContext
        let fetchRequest = NSFetchRequest<BookCategoriesEntity>(entityName: "BookCategoriesEntity")
        fetchRequest.predicate = NSPredicate(format: "bookCategoryName = %@", categoryNameEncoded)

        self.bookIDs = []
        let category = try? managedContext.fetch(fetchRequest)
        guard let category, category != [] else { return }

        if let bookIdEntityArray = category[0].bookIDs?.array as? [BookIDEntity] {
            let idStringArray = bookIdEntityArray.compactMap { $0.bookID }
            self.bookIDs = idStringArray
        }
    }
}
