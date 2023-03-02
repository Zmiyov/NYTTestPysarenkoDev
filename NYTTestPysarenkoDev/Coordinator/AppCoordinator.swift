//
//  AppCoordinator.swift
//  NYTTestPysarenkoDev
//
//  Created by Vladimir Pisarenko on 01.03.2023.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {

    var navigationController: UINavigationController

    init(navCon: UINavigationController) {
        self.navigationController = navCon
    }

    func start() {
        goToCategories()
    }

    func goToCategories() {
        let viewModel = CategoryListViewModel()
        let viewController = CategoriesViewController(categoryListViewModel: viewModel)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }

    func goToBooks(categoryListViewModel: CategoryListViewModelProtocol, indexPath: IndexPath) {
        let category = categoryListViewModel.categories.value[indexPath.item]

        guard let categoryNameEncoded = category.listNameEncoded,
              let categoryName = category.categoryName,
              let categoryDate = category.newestPublishedDate
        else {
            return
        }
        let bookListViewModel = BookListViewModel(categoryNameEncoded: categoryNameEncoded,
                                                      titleName: categoryName,
                                                      date: categoryDate)

        let booksVC = BooksViewController(bookListViewModel: bookListViewModel)
        booksVC.coordinator = self

        navigationController.pushViewController(booksVC, animated: true)
    }
}
