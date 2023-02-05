//
//  BookViewModel.swift
//  NYTTestPysarenkoDev
//
//  Created by Vladimir Pisarenko on 03.02.2023.
//

import Foundation

final class BookListViewModel {

    let networkManager = NYTAPIManager.shared
    
    var books: [BookModel] = [] {
        didSet {
            NotificationCenter.default.post(name: .loadBooks, object: nil, userInfo: nil)
        }
    }
    
    init(name: String, date: String) {
        networkManager.fetchBooks(name: name, date: date) { books in
            self.books = books
        }
        networkManager.fetchBooksJSON(name: name, date: date) { book, error in
            
        }
    }
    
    func booksCount() -> Int {
        return books.count
    }
    
//    func bookImage() -> UIImage {
//        let image = UIImage()
//        networkManager.fetchImage(url: <#T##String#>) { <#UIImage#> in
//            <#code#>
//        }
//        return image
//    }
}
