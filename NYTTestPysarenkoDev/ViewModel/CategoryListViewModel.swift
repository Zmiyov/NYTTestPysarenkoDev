//
//  CategoryListViewModel.swift
//  NYTTestPysarenkoDev
//
//  Created by Vladimir Pisarenko on 03.02.2023.
//

import Foundation
import CoreData

final class CategoryListViewModel {
    
//    var categories: [CategoryModel] = TempModels.categories
    
    var dataProvider = DataProvider(persistentContainer: CoreDataStack.shared.storeContainer, repository: NYTAPIManager.shared)
    
    lazy var fetchedResultsController: NSFetchedResultsController<CategoryEntity> = {
        
        let fetchRequest = NSFetchRequest<CategoryEntity>(entityName:"CategoryEntity")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "listNameEncoded", ascending:true)]
//        fetchRequest.predicate = NSPredicate(format: "category == %@", name)

        let controller = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                    managedObjectContext: dataProvider.viewContext,
                                                    sectionNameKeyPath: nil, cacheName: nil)
//        controller.delegate = delegate
        
        do {
            try controller.performFetch()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return controller
    }()
    
    var categories: [CategoryEntity] = [] {
        didSet {

            NotificationCenter.default.post(name: .loadCategories, object: nil, userInfo: nil)
        }
    }
    
    init() {
        
        dataProvider.getCategories() { [weak self] (error) in
            
            self?.fetchCategories()
        }
        
//        NYTAPIManager.shared.fetchCategories { categories in
//            self.categories = categories
//        }
    }
    
    func fetchCategories() {
        self.categories = []
        
        if let categories = fetchedResultsController.fetchedObjects {
//            print(categories, "Fetched books")
            self.categories = categories
        }
    }
    
    func categoriesCount() -> Int {
        return categories.count
    }
    
    func currentCategory(at index: Int) -> CategoryEntity {
        return categories[index]
    }
}


