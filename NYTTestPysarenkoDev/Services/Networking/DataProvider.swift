//
//  DataProvider.swift
//  NYTTestPysarenkoDev
//
//  Created by Vladimir Pisarenko on 05.02.2023.
//

import Foundation
import CoreData

class DataProvider {
    
    private let persistentContainer: NSPersistentContainer
    private let repository: NYTAPIManager
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init(persistentContainer: NSPersistentContainer, repository: NYTAPIManager) {
        self.persistentContainer = persistentContainer
        self.repository = repository
    }
    
    func getBooks(name: String, date: String, completion: @escaping(Error?) -> Void) {
        repository.fetchBooksJSON(name: name, date: date) { jsonDictionary, error in
            if let error = error {
                completion(error)
                return
            }
            
            guard let jsonDictionary = jsonDictionary else {
//                let error = NSError(domain: dataErrorDomain, code: DataErrorCode.wrongDataFormat.rawValue, userInfo: nil)
                completion(error)
                return
            }
            
            let taskContext = self.persistentContainer.newBackgroundContext()
            taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            taskContext.undoManager = nil
            
            _ = self.syncBooks(jsonDictionary: jsonDictionary, taskContext: taskContext)
            
            completion(nil)
        }
    }
    
    private func syncBooks(jsonDictionary: [[String: Any]], taskContext: NSManagedObjectContext) -> Bool {
        
        var successfull = false
        
        taskContext.performAndWait {
            let matchingEpisodeRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BookEntity")
            
        }
        
        return successfull
    }
}
