//
//  TempModels.swift
//  NYTTestPysarenkoDev
//
//  Created by Vladimir Pisarenko on 03.02.2023.
//

import Foundation

class TempModels {
    static let categories = [CategoryModel(name: "Fiction", oldestPublishedDate: "1 Jan", newestPublishedDate: "2Jan"),
                             CategoryModel(name: "Electronic", oldestPublishedDate: "1 Feb", newestPublishedDate: "2 Feb"),
                             CategoryModel(name: "Magazine", oldestPublishedDate: "1 Mar", newestPublishedDate: "2 Mar")]
    
    static let books = [BookModel(title: "Book1", description: "Description1", author: "Author1", publisher: "Publisher1", image: "Image1",                          rank: "Rank1", linkToBuy: "URL1"),
                        BookModel(title: "Book2", description: "Description2", author: "Author2", publisher: "Publisher2", image: "Image2", rank: "Rank2", linkToBuy: "URL2"),
                        BookModel(title: "Book3", description: "Description3", author: "Author3", publisher: "Publisher3", image: "Image3", rank: "Rank3", linkToBuy: "URL3")]
}
