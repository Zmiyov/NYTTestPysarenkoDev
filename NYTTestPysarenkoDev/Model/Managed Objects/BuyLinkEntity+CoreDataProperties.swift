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

    func update(with jsonDictionary: [String: Any]) throws {
        guard let marketName = jsonDictionary["name"] as? String,
              let buyLinkUrl = jsonDictionary["url"] as? String
        else {
            throw NSError(domain: "", code: 100)
        }
        self.marketName = marketName
        self.buyLinkUrl = buyLinkUrl
    }

    func update(with buyLink: BuyLink) {
        self.marketName = buyLink.marketName
        self.buyLinkUrl = buyLink.buyLinkUrl
    }
}

extension BuyLinkEntity: Identifiable {

}
