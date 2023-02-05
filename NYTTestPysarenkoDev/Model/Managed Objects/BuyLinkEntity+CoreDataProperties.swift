//
//  BuyLinkEntity+CoreDataProperties.swift
//  NYTTestPysarenkoDev
//
//  Created by Vladimir Pisarenko on 05.02.2023.
//
//

import Foundation
import CoreData


extension BuyLinkEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BuyLinkEntity> {
        return NSFetchRequest<BuyLinkEntity>(entityName: "BuyLinkEntity")
    }

    @NSManaged public var marketName: String?
    @NSManaged public var buyLinkUrl: String?
    @NSManaged public var book: BookEntity?

}

extension BuyLinkEntity : Identifiable {

}
