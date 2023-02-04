//
//  CategoryListViewModel.swift
//  NYTTestPysarenkoDev
//
//  Created by Vladimir Pisarenko on 03.02.2023.
//

import Foundation

final class CategoryListViewModel {
    
//    var categories: [CategoryModel] = TempModels.categories
    
    var categories: [CategoryModel] = [] {
        didSet {
//            print("DidSet")
//            print(categories, "Cater")
            //need notify
            NotificationCenter.default.post(name: .loadCategories, object: nil, userInfo: nil)
        }
    }
    
    init() {
        NYTAPIManager.shared.fetchCategories { categories in
            self.categories = categories
        }
    }
    
    func categoriesCount() -> Int {
        return categories.count
    }
    
    func currentCategory(at index: Int) -> CategoryModel {
        return categories[index]
    }
}


