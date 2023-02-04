//
//  ResponseBooks.swift
//  NYTTestPysarenkoDev
//
//  Created by Vladimir Pisarenko on 04.02.2023.
//

import Foundation

struct ResponseBooks {
    var books: [BookModel]?
    
    enum CodingKeys: String, CodingKey {
        case results
        case books
    }
}

// MARK: - Decodable

extension ResponseBooks: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let booksContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .books)
        self.books = try booksContainer.decode([BookModel].self, forKey: .books )
    }
}
