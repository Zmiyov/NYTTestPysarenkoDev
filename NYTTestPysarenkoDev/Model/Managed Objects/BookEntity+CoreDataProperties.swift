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
    @NSManaged public var bookImageURL: String?
    @NSManaged public var linkToBuyOnAmazon: String?
    @NSManaged public var buyLinks: NSOrderedSet?
    @NSManaged public var bookID: String?
    @NSManaged public var category: String?
    
    func update(with jsonDictionary: [String: Any]) throws {
        guard let rank = jsonDictionary["rank"] as? Int16,
              let publisher = jsonDictionary["publisher"] as? String,
              let bookDescription = jsonDictionary["description"] as? String,
              let title = jsonDictionary["title"] as? String,
              let author = jsonDictionary["author"] as? String,
              let bookImage = jsonDictionary["book_image"] as? String,
              let linkToBuyOnAmazon = jsonDictionary["amazon_product_url"] as? String,
              let buyLinksArray = jsonDictionary["buy_links"] as? [[String: Any]],
              let bookID = jsonDictionary["book_uri"] as? String
        else {
            throw NSError(domain: "", code: 100)
        }

        self.rank = rank
        self.publisher = publisher
        self.bookDescription = bookDescription
        self.title = title
        self.author = author
        self.bookImageURL = bookImage
        self.linkToBuyOnAmazon = linkToBuyOnAmazon
//        let linksIDs = self.buyLinks as? [BuyLinkEntity]
//        print(buyLinksArray)
        try buyLinksArray.forEach { value in
//            print(value)
            guard let context = self.managedObjectContext else { return }
            let buyLink = BuyLinkEntity(context: context)
            try buyLink.update(with: value)
            self.addToBuyLinks(buyLink)
        }
        
        self.bookID = bookID
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

extension BookEntity : Identifiable {

}
