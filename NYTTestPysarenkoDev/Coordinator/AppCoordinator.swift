//
//  AppCoordinator.swift
//  NYTTestPysarenkoDev
//
//  Created by Vladimir Pisarenko on 01.03.2023.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {

    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
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

    func goToBooks(categoryListViewModel: CategoryListViewModel, indexPath: IndexPath) {
        let category = categoryListViewModel.categories.value[indexPath.item]
        let booksVC = BooksViewController()
        booksVC.coordinator = self

        guard let categoryNameEncoded = category.listNameEncoded,
              let categoryName = category.categoryName,
              let categoryDate = category.newestPublishedDate
        else {
            return
        }
        booksVC.bookListViewModel = BookListViewModel(encodedName: categoryNameEncoded,
                                                      titleName: categoryName,
                                                      date: categoryDate)

        navigationController.pushViewController(booksVC, animated: true)
    }
}
