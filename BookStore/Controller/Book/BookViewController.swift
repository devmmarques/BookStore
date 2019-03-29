//
//  BookViewController.swift
//  BookStore
//
//  Created by marco.h.maia.marques on 24/03/19.
//  Copyright © 2019 marco.h.maia.marques. All rights reserved.
//

import UIKit

final class BookViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var topConstraintCollectionView: NSLayoutConstraint!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // Mark: Properties
    let searchController = UISearchController(searchResultsController: nil)
    public var containerController: UIViewController!
    public var bookType: BookType?

    private lazy var presenter: BookPresenter = {
        let presenter = BookPresenter(viewProtocol: self, serviceAPI: BookService())
        return presenter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: Const.Cell.bookCell, bundle: nil), forCellWithReuseIdentifier: Const.Cell.bookCell)
        self.searchBar.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.configure()
    }
    
    
    private func configure() {
    
        guard let bookType = self.bookType else { return }
        
        switch bookType {
        case .home:
            self.presenter.fetch(name: self.presenter.getNameSearchBook())
            self.searchBar.isHidden = false
            topConstraintCollectionView.constant = CGFloat(40.0)
        case .favorite:
            topConstraintCollectionView.constant = CGFloat(0.0)
            self.searchBar.isHidden = true
            self.presenter.fetchFavorite()
        }
    }
}

extension BookViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter.getCountCell()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Cell.bookCell, for: indexPath) as! BookCell
        let book = self.presenter.getBook(index: indexPath.row)
        if let image = book.volumeInfo.imageLinks {
            cell.configure(thumbnail: image.thumbnail )
        }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        if self.presenter.getTotalBooks() > Const.limitBookFetch {
            let lastElement = self.presenter.getCountCell() - 1
            if indexPath.row == lastElement {
                self.presenter.fetch(name: self.presenter.getNameSearchBook())
            }
        }
    }
}

extension BookViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewDetailBook = StoryboardUtil.bookDetailViewController()
        viewDetailBook.idBook = self.presenter.getBook(index: indexPath.row).id
        self.present(viewDetailBook, animated: false, completion: nil)
    }

}

extension BookViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  20
        let collectionViewSize = collectionView.frame.size.width - padding

        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 1, bottom: 1, right: 1) //.zero
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

extension BookViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
         print("searchBarTextDidBeginEditing")
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
       print("searchBarTextDidEndEditing")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
       
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let text = searchBar.text, text.count > 3 {
           self.presenter.fetch(name: text)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
    }
    
    
}

extension BookViewController: BookProtocol {

    func show() {
        self.collectionView.reloadData()
    }

    func showLoading() {
        UIAlertController().loading(viewController: self, message: Const.loading)
    }

    func showBuyBook(url: String) {
        guard let urlBook = URL(string: url) else { return }
        UIApplication.shared.open(urlBook, options: [:], completionHandler: nil)
    }

    func dismissLoading() {
        self.searchController.dismiss(animated: false) {
            UIAlertController().dismissLoading(viewController: self)
        }
        UIAlertController().dismissLoading(viewController: self)
    }

    func show(error: Error) {
        dismissLoading()
        let alert = BookAlertController(title: "Error", message: error.localizedDescription, image: nil)
        self.present(alert, animated: true, completion: nil)
    }
}
