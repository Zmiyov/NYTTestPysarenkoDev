//
//  BookCategoriesEntity+CoreDataProperties.swift
//  NYTTestPysarenkoDev
//
//  Created by Vladimir Pisarenko on 09.02.2023.
//
//

import Foundation
import CoreData

extension BookCategoriesEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookCategoriesEntity> {
        return NSFetchRequest<BookCategoriesEntity>(entityName: "BookCategoriesEntity")
    }

    @NSManaged public var bookCategoryName: String?
    @NSManaged public var bookIDs: NSOrderedSet?

    func update(name: String, bookID: String, with book: BookModel) throws {
        self.bookCategoryName = name

        if let bookIDs = self.bookIDs {
            let array = bookIDs.map { ($0 as? BookIDEntity)?.bookID as? String }
            if !array.contains(bookID) {
                guard let context = self.managedObjectContext else { return }
                let bookIDEntity = BookIDEntity(context: context)
                bookIDEntity.bookID = bookID
                self.addToBookIDs(bookIDEntity)
            }
        }
    }
}

// MARK: Generated accessors for bookIDs
extension BookCategoriesEntity {

    @objc(insertObject:inBookIDsAtIndex:)
    @NSManaged public func insertIntoBookIDs(_ value: BookIDEntity, at idx: Int)

    @objc(removeObjectFromBookIDsAtIndex:)
    @NSManaged public func removeFromBookIDs(at idx: Int)

    @objc(insertBookIDs:atIndexes:)
    @NSManaged public func insertIntoBookIDs(_ values: [BookIDEntity], at indexes: NSIndexSet)

    @objc(removeBookIDsAtIndexes:)
    @NSManaged public func removeFromBookIDs(at indexes: NSIndexSet)

    @objc(replaceObjectInBookIDsAtIndex:withObject:)
    @NSManaged public func replaceBookIDs(at idx: Int, with value: BookIDEntity)

    @objc(replaceBookIDsAtIndexes:withBookIDs:)
    @NSManaged public func replaceBookIDs(at indexes: NSIndexSet, with values: [BookIDEntity])

    @objc(addBookIDsObject:)
    @NSManaged public func addToBookIDs(_ value: BookIDEntity)

    @objc(removeBookIDsObject:)
    @NSManaged public func removeFromBookIDs(_ value: BookIDEntity)

    @objc(addBookIDs:)
    @NSManaged public func addToBookIDs(_ values: NSOrderedSet)

    @objc(removeBookIDs:)
    @NSManaged public func removeFromBookIDs(_ values: NSOrderedSet)

}

extension BookCategoriesEntity: Identifiable {

}
