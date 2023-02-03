//
//  CategoriesViewController.swift
//  NYTTestPysarenkoDev
//
//  Created by Vladimir Pisarenko on 03.02.2023.
//

import UIKit

final class CategoriesViewController: UIViewController {
    
    let categoryListViewModel = CategoryListViewModel()
    
    private enum CellIdentifiers: String {
        case categoryCollectionViewCell
    }
    
    enum Section: CaseIterable {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, CategoryModel>!
    var filteredItemsSnapshot: NSDiffableDataSourceSnapshot<Section, CategoryModel> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, CategoryModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(categoryListViewModel.categories)
        return snapshot
    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CellIdentifiers.categoryCollectionViewCell.rawValue)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Categories"
        view.backgroundColor = .secondarySystemBackground
        
        setConstraints()
      
        collectionView.delegate = self
        createDataSource()
    }
    
// MARK: - UICollectionViewDataSource
    
    func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, CategoryModel>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, category) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.categoryCollectionViewCell.rawValue, for: indexPath) as! CategoryCollectionViewCell
            
            cell.nameLabel.text = category.name
            cell.publishedDateLabel.text = category.oldestPublishedDate
            
            return cell
        })
        dataSource.apply(filteredItemsSnapshot)
    }
}
// MARK: - UICollectionViewDelegate

extension CategoriesViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.width/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        let currentEvent = categoryListViewModel.categories[indexPath.item]
        let booksVC = BooksViewController()
//        let navVC = UINavigationController(rootViewController: booksVC)
//        navVC.modalPresentationStyle = .popover
//
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithDefaultBackground()
//
//        navVC.navigationBar.standardAppearance = appearance
//        navVC.navigationBar.scrollEdgeAppearance = appearance
        
//        present(booksVC, animated: true)
        navigationController?.pushViewController(booksVC, animated: true)
    }
}

//MARK: - Set Constraints

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
