//
//  NYTAPIManager.swift
//  NYTTestPysarenkoDev
//
//  Created by Vladimir Pisarenko on 04.02.2023.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

final class NYTAPIManager {

    static let shared = NYTAPIManager()

    // MARK: - For codable models

    func fetchCategories(completion: @escaping ([CategoryModel]?, _ error: Error?) -> Void) {
        let url = "https://api.nytimes.com/svc/books/v3/lists/names.json?api-key=\(NYTAPIKey.key.rawValue)"
        AF.request(url).responseDecodable(of: ResponseCategories.self) { response in
            switch response.result {
            case .success(let data):
                let categories = data.categories
                completion(categories, nil)
            case .failure(let error):
                completion(nil, error)
                print(error)
            }
        }
    }

    func fetchBooks(name: String, date: String, completion: @escaping ([BookModel]?, _ error: Error?) -> Void) {
        let url = "https://api.nytimes.com/svc/books/v3/lists/\(date)/\(name).json?api-key=\(NYTAPIKey.key.rawValue)"
        AF.request(url).responseDecodable(of: ResponseBooks.self) { response in
            switch response.result {
            case .success(let data):
                let books = data.books
                completion(books, nil)
            case .failure(let error):
                completion(nil, error)
                print(error)
            }
        }
    }
}
