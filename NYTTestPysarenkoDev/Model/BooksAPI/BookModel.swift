//
//  BookModel.swift
//  NYTTestPysarenkoDev
//
//  Created by Vladimir Pisarenko on 03.02.2023.
//

import Foundation

struct BookModel: Hashable {
    let rank: String
    let publisher: String
    let description: String
    let title: String
    let author: String
    let bookImage: String
    let linkToBuyOnAmazon: String
    let buyLinks: [BuyLinks]
    
    enum CodingKeys: String, CodingKey {
        case rank
        case publisher
        case description
        case title
        case author
        case bookImage = "book_image"
        case linkToBuyOnAmazon = "amazon_product_url"
        case buyLinks = "buy_links"
    }
}

extension BookModel: Decodable {
    init(from decoder: Decoder) throws {
        let booksContainer = try decoder.container(keyedBy: CodingKeys.self)
        rank = try booksContainer.decode(String.self, forKey: .rank)
        publisher = try booksContainer.decode(String.self, forKey: .publisher)
        description = try booksContainer.decode(String.self, forKey: .description)
        title = try booksContainer.decode(String.self, forKey: .title)
        author = try booksContainer.decode(String.self, forKey: .author)
        bookImage = try booksContainer.decode(String.self, forKey: .bookImage)
        linkToBuyOnAmazon = try booksContainer.decode(String.self, forKey: .linkToBuyOnAmazon)
        buyLinks = try booksContainer.decode([BuyLinks].self, forKey: .buyLinks)
    }
}

struct BuyLinks: Hashable {
    let marketName: String
    let buyLinkUrl: String
    
    enum CodingKeys: String, CodingKey {
        case marketName = "name"
        case buyLinkUrl = "url"
    }
}

extension BuyLinks: Decodable {
    init(from decoder: Decoder) throws {
        let buyLinksContainer = try decoder.container(keyedBy: CodingKeys.self)
        marketName = try buyLinksContainer.decode(String.self, forKey: .marketName)
        buyLinkUrl = try buyLinksContainer.decode(String.self, forKey: .buyLinkUrl)
    }
}
