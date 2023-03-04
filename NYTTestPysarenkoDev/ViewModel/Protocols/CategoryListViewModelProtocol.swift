//
//  CategoryListViewModelProtocol.swift
//  NYTTestPysarenkoDev
//
//  Created by Vladimir Pisarenko on 02.03.2023.
//

import Foundation

protocol CategoryListViewModelProtocol {
    var categories: Dynamic<[CategoryEntity]> { get }
}
