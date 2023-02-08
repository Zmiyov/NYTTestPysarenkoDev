//
//  BookCategoriesEntity+CoreDataProperties.swift
//  NYTTestPysarenkoDev
//
//  Created by Vladimir Pisarenko on 08.02.2023.
//
//

import Foundation
import CoreData


extension BookCategoriesEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookCategoriesEntity> {
        return NSFetchRequest<BookCategoriesEntity>(entityName: "BookCategoriesEntity")
    }

    @NSManaged public var bookCategoryName: String?
    @NSManaged public var book: BookEntity?

}

extension BookCategoriesEntity : Identifiable {

}
