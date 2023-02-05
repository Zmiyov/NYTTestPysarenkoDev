//
//  BookEntity+CoreDataProperties.swift
//  NYTTestPysarenkoDev
//
//  Created by Vladimir Pisarenko on 05.02.2023.
//
//

import Foundation
import CoreData


extension BookEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookEntity> {
        return NSFetchRequest<BookEntity>(entityName: "BookEntity")
    }

    @NSManaged public var rank: Int16
    @NSManaged public var publisher: String?
    @NSManaged public var bookDescription: String?
    @NSManaged public var title: String?
    @NSManaged public var author: String?
    @NSManaged public var bookImage: String?
    @NSManaged public var linkToBuyOnAmazon: String?
    @NSManaged public var buyLinks: NSOrderedSet?
    
    func update(with jsonDictionary: [String: Any]) throws {
        guard let rank = jsonDictionary["rank"] as? Int16,
              let publisher = jsonDictionary["publisher"] as? String,
              let bookDescription = jsonDictionary["description"] as? String,
              let title = jsonDictionary["title"] as? String,
              let author = jsonDictionary["author"] as? String,
              let bookImage = jsonDictionary["book_image"] as? String,
              let linkToBuyOnAmazon = jsonDictionary["amazon_product_url"] as? String,
              let buyLinks = jsonDictionary["buy_links"] as? NSOrderedSet
        else {
            throw NSError(domain: "", code: 100)
        }

        self.rank = rank
        self.publisher = publisher
        self.bookDescription = bookDescription
        self.title = title
        self.author = author
        self.bookImage = bookImage
        self.linkToBuyOnAmazon = linkToBuyOnAmazon
        self.buyLinks = buyLinks
    }
    
    func fetchImage() {
        
    }
    
//    func update(with bookModel: BookModel) throws {
//        guard let rank = bookModel.rank as? Int32,
//              let publisher = bookModel.publisher as? String,
//              let bookDescription = bookModel.description as? String,
//              let title = bookModel.title as? String,
//              let author = bookModel.author as? String,
//              let bookImage = bookModel.bookImage as? String,
//              let linkToBuyOnAmazon = bookModel.linkToBuyOnAmazon as? String,
//              let buyLinks = bookModel.buyLinks as? NSOrderedSet
//        else {
//            throw NSError(domain: "", code: 100)
//        }
//
//        self.rank = rank
//        self.publisher = publisher
//        self.bookDescription = bookDescription
//        self.title = title
//        self.author = author
//        self.bookImage = bookImage
//        self.linkToBuyOnAmazon = linkToBuyOnAmazon
//        self.buyLinks = buyLinks
//    }

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

extension BookEntity : Identifiable {

}
