//
//  BookIDEntity+CoreDataProperties.swift
//  NYTTestPysarenkoDev
//
//  Created by Vladimir Pisarenko on 09.02.2023.
//
//

import Foundation
import CoreData

extension BookIDEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookIDEntity> {
        return NSFetchRequest<BookIDEntity>(entityName: "BookIDEntity")
    }

    @NSManaged public var bookID: String?
    @NSManaged public var bookCategories: BookCategoriesEntity?

}

extension BookIDEntity: Identifiable {

}
