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

    func update(with categoryModel: CategoryModel) throws {
        self.categoryName = categoryModel.categoryName
        self.oldestPublishedDate = categoryModel.oldestPublishedDate
        self.newestPublishedDate = categoryModel.newestPublishedDate
        self.listNameEncoded = categoryModel.listNameEncoded
    }
}

extension CategoryEntity: Identifiable {

}
