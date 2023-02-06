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
    
    private enum CellIdentifiers: String {
        case bookCollectionViewCell
    }

    enum Section: CaseIterable {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, BookEntity>!
    var filteredItemsSnapshot: NSDiffableDataSourceSnapshot<Section, BookEntity> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, BookEntity>()
        snapshot.appendSections([.main])
        snapshot.appendItems(bookListViewModel?.books ?? [])
        return snapshot
    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: CellIdentifiers.bookCollectionViewCell.rawValue)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = bookListViewModel?.name
        view.backgroundColor = .secondarySystemBackground
        
        setConstraints()
      
        collectionView.delegate = self
        createDataSource()
        
        NotificationCenter.default.addObserver(self, selector: #selector(obserber(notification: )), name: .loadBooks, object: nil)
    }
    
    @objc private func obserber(notification: Notification) {

        createDataSource()
    }
    
// MARK: - UICollectionViewDataSource
    
    func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, BookEntity>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, book) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.bookCollectionViewCell.rawValue, for: indexPath) as! BookCollectionViewCell
            
            cell.urlString = book.linkToBuyOnAmazon
            cell.bookNameLabel.text = book.title
            cell.descriptionLabel.text = book.description
//            cell.imageView.af.setImage(withURL: URL(string: book.bookImageURL!)!, placeholderImage: UIImage(named: "placeholderLightPortrait"))
            if let imageUrl = book.bookImageURL,
               let url = URL(string: imageUrl) {
                cell.imageView.af.setImage(withURL: url, placeholderImage: UIImage(named: "placeholderLightPortrait"))
            }

//            cell.imageView.af.setImage(withURL: url, placeholderImage: UIImage(named: "placeholder"))

            return cell
        })
        dataSource.apply(filteredItemsSnapshot)
    }
}
// MARK: - UICollectionViewDelegateFlowLayout

extension BooksViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.width/3)
    }
}

//MARK: - Set Constraints

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

extension BooksViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
//        createDataSource()
    }
}
