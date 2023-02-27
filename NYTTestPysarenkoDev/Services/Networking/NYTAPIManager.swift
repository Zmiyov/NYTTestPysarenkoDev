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
    
    //MARK: - For data provider(are using)
    
    func fetchCategoriesJSON(completion: @escaping(_ categoriesDict: [[String: Any]]?, _ error: Error?) -> ()) {
        let url = "https://api.nytimes.com/svc/books/v3/lists/names.json?api-key=\(NYTAPIKey.key.rawValue)"
        AF.request(url).responseData { data in
            switch data.result {
                
            case .success(let data):
                let jsonObject = try? JSONSerialization.jsonObject(with: data, options: [])
                let jsonDictionary = jsonObject as? [String: Any]
                let categories = jsonDictionary?["results"] as? [[String: Any]]

                completion(categories, nil)
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
            case .failure(let error):
                completion(nil, error)
                print(error)
            }
        }
    }
}
