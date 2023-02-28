//
//  BookEntity+CoreDataProperties.swift
//  NYTTestPysarenkoDev
//
//  Created by Vladimir Pisarenko on 08.02.2023.
//
//

import Foundation
import CoreData

extension BookEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookEntity> {
        return NSFetchRequest<BookEntity>(entityName: "BookEntity")
    }

    @NSManaged public var author: String?
    @NSManaged public var bookDescription: String?
    @NSManaged public var bookID: String?
    @NSManaged public var bookImageURL: String?
    @NSManaged public var linkToBuyOnAmazon: String?
    @NSManaged public var publisher: String?
    @NSManaged public var rank: Int16
    @NSManaged public var title: String?
    @NSManaged public var buyLinks: NSOrderedSet?

    func update(with book: BookModel) throws {
        self.rank = Int16(book.rank)
        self.publisher = book.publisher
        self.bookDescription = book.description
        self.title = book.title
        self.author = book.author
        self.bookImageURL = book.bookImage
        self.linkToBuyOnAmazon = book.linkToBuyOnAmazon

        book.buyLinks.forEach { value in
            guard let context = self.managedObjectContext else { return }
            let buyLink = BuyLinkEntity(context: context)
            buyLink.update(with: value)
            self.addToBuyLinks(buyLink)
        }

        self.bookID = book.bookID
    }
}

// MARK: Generated accessors for buyLinks
extension BookEntity {

    @objc(insertObject:inBuyLinksAtIndex:)
    @NSManaged public func insertIntoBuyLinks(_ value: BuyLinkEntity, at idx: Int)

    @objc(removeObjectFromBuyLinksAtIndex:)
    @NSManaged public func removeFromBuyLinks(at idx: Int)

    @objc(insertBuyLinks:atIndexes:)
    @NSManaged public func insertIntoBuyLinks(_ values: [BuyLinkEntity], at indexes: NSIndexSet)

    @objc(removeBuyLinksAtIndexes:)
    @NSManaged public func removeFromBuyLinks(at indexes: NSIndexSet)

    @objc(replaceObjectInBuyLinksAtIndex:withObject:)
    @NSManaged public func replaceBuyLinks(at idx: Int, with value: BuyLinkEntity)

    @objc(replaceBuyLinksAtIndexes:withBuyLinks:)
    @NSManaged public func replaceBuyLinks(at indexes: NSIndexSet, with values: [BuyLinkEntity])

    @objc(addBuyLinksObject:)
    @NSManaged public func addToBuyLinks(_ value: BuyLinkEntity)

    @objc(removeBuyLinksObject:)
    @NSManaged public func removeFromBuyLinks(_ value: BuyLinkEntity)

    @objc(addBuyLinks:)
    @NSManaged public func addToBuyLinks(_ values: NSOrderedSet)

    @objc(removeBuyLinks:)
    @NSManaged public func removeFromBuyLinks(_ values: NSOrderedSet)

}

// MARK: Generated accessors for categories
extension BookEntity {

    @objc(insertObject:inCategoriesAtIndex:)
    @NSManaged public func insertIntoCategories(_ value: BookCategoriesEntity, at idx: Int)

    @objc(removeObjectFromCategoriesAtIndex:)
    @NSManaged public func removeFromCategories(at idx: Int)

    @objc(insertCategories:atIndexes:)
    @NSManaged public func insertIntoCategories(_ values: [BookCategoriesEntity], at indexes: NSIndexSet)

    @objc(removeCategoriesAtIndexes:)
    @NSManaged public func removeFromCategories(at indexes: NSIndexSet)

    @objc(replaceObjectInCategoriesAtIndex:withObject:)
    @NSManaged public func replaceCategories(at idx: Int, with value: BookCategoriesEntity)

    @objc(replaceCategoriesAtIndexes:withCategories:)
    @NSManaged public func replaceCategories(at indexes: NSIndexSet, with values: [BookCategoriesEntity])

    @objc(addCategoriesObject:)
    @NSManaged public func addToCategories(_ value: BookCategoriesEntity)

    @objc(removeCategoriesObject:)
    @NSManaged public func removeFromCategories(_ value: BookCategoriesEntity)

    @objc(addCategories:)
    @NSManaged public func addToCategories(_ values: NSOrderedSet)

    @objc(removeCategories:)
    @NSManaged public func removeFromCategories(_ values: NSOrderedSet)

}

extension BookEntity: Identifiable {

}
