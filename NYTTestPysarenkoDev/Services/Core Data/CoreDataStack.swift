//
//  CoreDataStack.swift
//  NYTTestPysarenkoDev
//
//  Created by Vladimir Pisarenko on 05.02.2023.
//

import Foundation
import CoreData

final class CoreDataStack {

    static var shared = CoreDataStack(modelName: "NYTTestPysarenkoDev")

    private let modelName: String
    lazy var managedContext: NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()

    init(modelName: String) {
        self.modelName = modelName
    }

    lazy var storeContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.automaticallyMergesChangesFromParent = true

        return container
    }()

    func saveContext() {
        guard managedContext.hasChanges else { return }

        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
}
