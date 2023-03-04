//
//  BookListViewModelProtocol.swift
//  NYTTestPysarenkoDev
//
//  Created by Vladimir Pisarenko on 02.03.2023.
//

import Foundation

protocol BookListViewModelProtocol {
    var books: Dynamic<[BookEntity]> { get }
    var titleName: String { get }
}
