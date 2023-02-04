//
//  BookViewModel.swift
//  NYTTestPysarenkoDev
//
//  Created by Vladimir Pisarenko on 03.02.2023.
//

import Foundation

final class BookListViewModel {
//    let books: [BookModel] = TempModels.books
    var books: [BookModel] = []
    
    init(name: String, date: String) {
        NYTAPIManager.shared.fetchBooks(name: name, date: date) { books in
            self.books = books
        }
    }
    
    func booksCount() -> Int {
        return books.count
    }
}
