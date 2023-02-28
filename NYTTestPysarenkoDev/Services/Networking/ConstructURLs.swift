//
//  ConstructURLs.swift
//  NYTTestPysarenkoDev
//
//  Created by Vladimir Pisarenko on 28.02.2023.
//

import Foundation

struct ConstructURLs {
    static let baseURL = "https://api.nytimes.com/svc/books/v3/lists"
    static let apiKey = NYTAPIKey.key.rawValue

    static func categoriesURL() -> String {
        return "\(baseURL)/names.json?api-key=\(apiKey)"
    }

    static func booksURL(for name: String, date: String) -> String {
        return "\(baseURL)/\(date)/\(name).json?api-key=\(apiKey)"
    }
}
