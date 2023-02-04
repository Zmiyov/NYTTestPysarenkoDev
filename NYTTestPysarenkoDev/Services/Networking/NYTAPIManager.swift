//
//  NYTAPIManager.swift
//  NYTTestPysarenkoDev
//
//  Created by Vladimir Pisarenko on 04.02.2023.
//

import Foundation

class NYTAPIManager {
    static let shared = NYTAPIManager()
    
    func fetchCategories() {
        let url = "https://api.nytimes.com/svc/books/v3/lists/names.json?api-key=\(NYTAPIKey.key.rawValue)"
    }
    
    func fetchBooks(date: String, name: String) {
        let url = "https://api.nytimes.com/svc/books/v3/lists/\(date)/\(name).json?api-key=\(NYTAPIKey.key.rawValue)"
    }
}
