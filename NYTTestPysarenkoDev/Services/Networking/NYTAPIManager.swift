//
//  NYTAPIManager.swift
//  NYTTestPysarenkoDev
//
//  Created by Vladimir Pisarenko on 04.02.2023.
//

import Foundation
import Alamofire

class NYTAPIManager {
    static let shared = NYTAPIManager()
    
    var categories: [CategoryModel] = []
    
    func fetchCategories(completion: @escaping ([CategoryModel]) -> Void) {
        let url = "https://api.nytimes.com/svc/books/v3/lists/names.json?api-key=\(NYTAPIKey.key.rawValue)"
        AF.request(url).responseDecodable(of: ResponseCategories.self) { response in
            guard let fetchedCategories = response.value?.categories else { return }

            completion(fetchedCategories)
        }
    }
    
    func fetchBooks(name: String, date: String, completion: @escaping ([BookModel]) -> Void) {
        let url = "https://api.nytimes.com/svc/books/v3/lists/\(date)/\(name).json?api-key=\(NYTAPIKey.key.rawValue)"
        AF.request(url).responseDecodable(of: ResponseBooks.self) { response in
            guard let fetchedBooks = response.value?.books else { return }

            completion(fetchedBooks)
        }
    }
}
