//
//  BooksViewController.swift
//  NYTTestPysarenkoDev
//
//  Created by Vladimir Pisarenko on 03.02.2023.
//

import UIKit
import AlamofireImage
import CoreData

final class BooksViewController: UIViewController {

    var bookListViewModel: BookListViewModel?
    private let refreshControl = UIRefreshControl()
    private enum CellIdentifiers: String {
        case bookCell
    }

    enum Section: CaseIterable {
        case main
    }
    private enum BookVCTextLabels: String {
        case publisher = "Publisher: "
        case rank = "Rank: "
    }

    var dataSource: UICollectionViewDiffableDataSource<Section, BookEntity>!
    var filteredItemsSnapshot: NSDiffableDataSourceSnapshot<Section, BookEntity> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, BookEntity>()
        snapshot.appendSections([.main])
        snapshot.appendItems(bookListViewModel?.books.value ?? [])
        return snapshot
    }

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(BookCollectionViewCell.self,
                                forCellWithReuseIdentifier: CellIdentifiers.bookCell.rawValue)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = bookListViewModel?.titleName
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
        bookListViewModel?.books.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.createDataSource()
            }
        }
    }

// MARK: - UICollectionViewDataSource

    func createDataSource() {
        // swiftlint:disable line_length
        dataSource = UICollectionViewDiffableDataSource<Section, BookEntity>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, book) -> UICollectionViewCell? in
            // swiftlint:enable line_length
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.bookCell.rawValue,
                                                          for: indexPath) as? BookCollectionViewCell
            cell?.configure(with: book,
                            publisherLabel: BookVCTextLabels.publisher.rawValue.localized(),
                            rankLabel: BookVCTextLabels.rank.rawValue.localized())

            return cell
        })
        dataSource.apply(filteredItemsSnapshot)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension BooksViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.width/2.5)
    }
}

// MARK: - Set Constraints

extension BooksViewController {

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
