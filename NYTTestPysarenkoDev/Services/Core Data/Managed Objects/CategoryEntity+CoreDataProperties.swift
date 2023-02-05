//
//  CategoryEntity+CoreDataProperties.swift
//  NYTTestPysarenkoDev
//
//  Created by Vladimir Pisarenko on 05.02.2023.
//
//

import Foundation
import CoreData


extension CategoryEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryEntity> {
        return NSFetchRequest<CategoryEntity>(entityName: "CategoryEntity")
    }

    @NSManaged public var categoryName: String?
    @NSManaged public var oldestPublishedDate: String?
    @NSManaged public var newestPublishedDate: String?
    @NSManaged public var listNameEncoded: String?

    
    func update(with jsonDictionary: [String: Any]) throws {
        guard let categoryName = jsonDictionary["list_name"] as? String,
              let oldestPublishedDate = jsonDictionary["oldest_published_date"] as? String,
              let newestPublishedDate = jsonDictionary["newest_published_date"] as? String,
              let listNameEncoded = jsonDictionary["list_name_encoded"] as? String
        else {
            throw NSError(domain: "", code: 100)
        }
        
        self.categoryName = categoryName
        self.oldestPublishedDate = oldestPublishedDate
        self.newestPublishedDate = newestPublishedDate
        self.listNameEncoded = listNameEncoded
    }
}

extension CategoryEntity : Identifiable {

}
