//
//  CategoryListViewModel.swift
//  NYTTestPysarenkoDev
//
//  Created by Vladimir Pisarenko on 03.02.2023.
//

import Foundation
import CoreData

final class CategoryListViewModel: CategoryListViewModelProtocol {

    var dataProvider = DataProvider(persistentContainer: CoreDataStack.shared.storeContainer,
                                    repository: NYTAPIManager.shared)
    var categories = Dynamic([CategoryEntity]())

    lazy var fetchedResultsController: NSFetchedResultsController<CategoryEntity> = {
        let fetchRequest = NSFetchRequest<CategoryEntity>(entityName: "CategoryEntity")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "listNameEncoded", ascending: true)]
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                    managedObjectContext: dataProvider.viewContext,
                                                    sectionNameKeyPath: nil,
                                                    cacheName: nil)
        do {
            try controller.performFetch()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }

        return controller
    }()

    init() {
        dataProvider.getCategories { [weak self] _ in
            self?.fetchCategories()
        }
    }

    func fetchCategories() {
        self.categories.value = []

        if let categories = fetchedResultsController.fetchedObjects {
            self.categories.value = categories
        }
    }
}
