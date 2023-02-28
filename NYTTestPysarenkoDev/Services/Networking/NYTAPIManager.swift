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

    func load<T: Decodable>(url: String, completion: @escaping (T?, Error?) -> Void) {
        AF.request(url).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(data, nil)
            case .failure(let error):
                completion(nil, error)
                print(error)
            }
        }
    }
}
