//
//  BookModel.swift
//  NYTTestPysarenkoDev
//
//  Created by Vladimir Pisarenko on 28.02.2023.
//

import Foundation

struct BookModel: Hashable {
    let rank: Int
    let publisher: String
    let description: String
    let title: String
    let author: String
    let bookImage: String
    let linkToBuyOnAmazon: String
    let buyLinks: [BuyLink]
    let bookID: String

    enum CodingKeys: String, CodingKey {
        case rank
        case publisher
        case description
        case title
        case author
        case bookImage = "book_image"
        case linkToBuyOnAmazon = "amazon_product_url"
        case buyLinks = "buy_links"
        case bookID = "book_uri"
    }
}

extension BookModel: Decodable {
    init(from decoder: Decoder) throws {
        let booksContainer = try decoder.container(keyedBy: CodingKeys.self)
        rank = try booksContainer.decode(Int.self, forKey: .rank)
        publisher = try booksContainer.decode(String.self, forKey: .publisher)
        description = try booksContainer.decode(String.self, forKey: .description)
        title = try booksContainer.decode(String.self, forKey: .title)
        author = try booksContainer.decode(String.self, forKey: .author)
        bookImage = try booksContainer.decode(String.self, forKey: .bookImage)
        linkToBuyOnAmazon = try booksContainer.decode(String.self, forKey: .linkToBuyOnAmazon)
        buyLinks = try booksContainer.decode([BuyLink].self, forKey: .buyLinks)
        bookID = try booksContainer.decode(String.self, forKey: .bookID)
    }
}

struct BuyLink: Hashable {
    let marketName: String
    let buyLinkUrl: String

    enum CodingKeys: String, CodingKey {
        case marketName = "name"
        case buyLinkUrl = "url"
    }
}

extension BuyLink: Decodable {
    init(from decoder: Decoder) throws {

        let buyLinksContainer = try decoder.container(keyedBy: CodingKeys.self)
        marketName = try buyLinksContainer.decode(String.self, forKey: .marketName)
        buyLinkUrl = try buyLinksContainer.decode(String.self, forKey: .buyLinkUrl)
    }
}
