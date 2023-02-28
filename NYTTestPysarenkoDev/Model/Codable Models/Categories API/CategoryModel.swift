//
//  CategoryModel.swift
//  NYTTestPysarenkoDev
//
//  Created by Vladimir Pisarenko on 28.02.2023.
//

import Foundation

struct CategoryModel: Hashable {
    let categoryName: String
    let oldestPublishedDate: String
    let newestPublishedDate: String
    let listNameEncoded: String

    enum CodingKeys: String, CodingKey {
        case categoryName = "list_name"
        case oldestPublishedDate = "oldest_published_date"
        case newestPublishedDate = "newest_published_date"
        case listNameEncoded = "list_name_encoded"
    }
}

// MARK: - Decodable

extension CategoryModel: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        categoryName = try container.decode(String.self, forKey: .categoryName)
        oldestPublishedDate = try container.decode(String.self, forKey: .oldestPublishedDate)
        newestPublishedDate = try container.decode(String.self, forKey: .newestPublishedDate)
        listNameEncoded = try container.decode(String.self, forKey: .listNameEncoded)
    }
}
