//
//  ResponseCategories.swift
//  NYTTestPysarenkoDev
//
//  Created by Vladimir Pisarenko on 04.02.2023.
//

import Foundation

struct ResponseCategories {
    var categories: [CategoryModel]?
    
    enum CodingKeys: String, CodingKey {
        case categories = "results"
    }
}

// MARK: - Decodable

extension ResponseCategories: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.categories = try container.decode([CategoryModel].self, forKey: .categories )
    }
}
