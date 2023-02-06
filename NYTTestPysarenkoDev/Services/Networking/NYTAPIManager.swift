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
    
    func fetchCategoriesJSON(completion: @escaping(_ categoriesDict: [[String: Any]]?, _ error: Error?) -> ()) {
        let url = "https://api.nytimes.com/svc/books/v3/lists/names.json?api-key=\(NYTAPIKey.key.rawValue)"
        AF.request(url).responseData { data in
            switch data.result {
                
            case .success(let data):
                
                let jsonObject = try? JSONSerialization.jsonObject(with: data, options: [])
                let jsonDictionary = jsonObject as? [String: Any]
//                let results = jsonDictionary?["results"] as? [String: Any]
                let categories = jsonDictionary?["results"] as? [[String: Any]]

                completion(categories, nil)
                
//                let json = try? JSON(data: data)
//                print(books)
            case .failure(let error):
                completion(nil, error)
                print(error)
            }
        }
    }
    
    
    func fetchBooksJSON(name: String, date: String, completion: @escaping(_ booksDict: [[String: Any]]?, _ error: Error?) -> ()) {
        let url = "https://api.nytimes.com/svc/books/v3/lists/\(date)/\(name).json?api-key=\(NYTAPIKey.key.rawValue)"
        AF.request(url).responseData { data in
            switch data.result {
                
            case .success(let data):
                
                let jsonObject = try? JSONSerialization.jsonObject(with: data, options: [])
                let jsonDictionary = jsonObject as? [String: Any]
                let results = jsonDictionary?["results"] as? [String: Any]
                let books = results?["books"] as? [[String: Any]]

                completion(books, nil)
                
//                let json = try? JSON(data: data)
//                print(books)
            case .failure(let error):
                completion(nil, error)
                print(error)
            }
        }
    }

    
    func fetchImage(url: String, completion: @escaping (UIImage) -> Void) {
        AF.request(url).responseImage { response in
            switch response.result {
                
            case .success(let image):
                completion(image)
            case .failure(let error):
                print(error)
            }
        }
    }
}
