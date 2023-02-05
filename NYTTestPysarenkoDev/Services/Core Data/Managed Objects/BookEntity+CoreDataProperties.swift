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
    @NSManaged public var buyLinks: BuyLinkEntity?

}

extension BookEntity : Identifiable {

}
