//
//  CategoryModel.swift
//  NYTTestPysarenkoDev
//
//  Created by Vladimir Pisarenko on 03.02.2023.
//

import Foundation

struct CategoryModel: Codable {
    let name: String
    let oldestPublishedDate: String
    let newestPublishedDate: String
}
