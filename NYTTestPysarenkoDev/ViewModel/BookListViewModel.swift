//
//  BookViewModel.swift
//  NYTTestPysarenkoDev
//
//  Created by Vladimir Pisarenko on 03.02.2023.
//

import Foundation

class BookListViewModel {
    let books: [BookModel] = TempModels.books
    
    
    func booksCount() -> Int {
        return books.count
    }
}
