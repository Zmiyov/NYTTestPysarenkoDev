//
//  CategoriesViewController.swift
//  NYTTestPysarenkoDev
//
//  Created by Vladimir Pisarenko on 03.02.2023.
//

import UIKit

final class CategoriesViewController: UIViewController {

    var categoryListViewModel = CategoryListViewModel()
    private let refreshControl = UIRefreshControl()

    private enum CellIdentifiers: String {
        case categoryCell
    }

    private enum TextLabels: String {
        case title = "Categories"
    }

    enum Section: CaseIterable {
        case main
    }

    var dataSource: UICollectionViewDiffableDataSource<Section, CategoryEntity>!
    var filteredItemsSnapshot: NSDiffableDataSourceSnapshot<Section, CategoryEntity> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, CategoryEntity>()
        snapshot.appendSections([.main])
        snapshot.appendItems(categoryListViewModel.categories.value)
        return snapshot
    }

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.alwaysBounceVertical = true
        collectionView.register(CategoryCollectionViewCell.self,
                                forCellWithReuseIdentifier: CellIdentifiers.categoryCell.rawValue)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = TextLabels.title.rawValue.localized()
        view.backgroundColor = .secondarySystemBackground
        setConstraints()

        collectionView.delegate = self
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)

        createDataSource()
        bindViewModel()
    }

    @objc
    private func didPullToRefresh(_ sender: Any) {
        DispatchQueue.main.async {
            self.createDataSource()
        }
        refreshControl.endRefreshing()
    }

    private func bindViewModel() {
        categoryListViewModel.categories.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.createDataSource()
            }
        }
    }

// MARK: - UICollectionViewDataSource

    func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, CategoryEntity>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, category) -> UICollectionViewCell? in

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.categoryCell.rawValue,
                                                          for: indexPath) as? CategoryCollectionViewCell

            cell?.configure(category: category)

            return cell
        })
        dataSource.apply(filteredItemsSnapshot)
    }
}

// MARK: - UICollectionViewDelegate

extension CategoriesViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.width/5)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let category = categoryListViewModel.categories.value[indexPath.item]
        let booksVC = BooksViewController()
        guard let categoryNameEncoded = category.listNameEncoded,
              let categoryName = category.categoryName,
              let categoryDate = category.newestPublishedDate
        else {
            return
        }
        booksVC.bookListViewModel = BookListViewModel(encodedName: categoryNameEncoded,
                                                      titleName: categoryName,
                                                      date: categoryDate)

        navigationController?.pushViewController(booksVC, animated: true)
    }
}

// MARK: - Set Constraints

extension CategoriesViewController {

    private func setConstraints() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .secondarySystemBackground
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
