//
//  BookModel.swift
//  NYTTestPysarenkoDev
//
//  Created by Vladimir Pisarenko on 03.02.2023.
//

import Foundation

struct BookModel: Codable {
    let title: String
    let description: String
    let author: String
    let publisher: String
    let image: String
    let rank: String
    let linkToBuy: String
}
