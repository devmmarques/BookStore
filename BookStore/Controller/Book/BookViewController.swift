//
//  BookViewController.swift
//  BookStore
//
//  Created by marco.h.maia.marques on 24/03/19.
//  Copyright © 2019 marco.h.maia.marques. All rights reserved.
//

import UIKit

final class BookViewController: UIViewController, UISearchBarDelegate, UISearchControllerDelegate {

    // MARK: Outlets
    @IBOutlet weak var collectionView: UICollectionView!

    // Mark: Properties
    let searchController = UISearchController(searchResultsController: nil)

    private lazy var presenter: BookPresenter = {
        let presenter = BookPresenter(viewProtocol: self, serviceAPI: BookService())
        return presenter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: Const.Cell.bookCell, bundle: nil), forCellWithReuseIdentifier: Const.Cell.bookCell)
        configureSearchController()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.presenter.fetch(name: self.presenter.getNameSearchBook())
    }
}

extension BookViewController {

    private func configureSearchController() {

        let searchTextField: UITextField? = { [unowned self] in
            var textField: UITextField?
            searchController.searchBar.subviews.forEach({ view in
                view.subviews.forEach({ view in
                    if let view  = view as? UITextField {
                        textField = view
                    }
                })
            })
            return textField
        }()

        if let searchText = searchTextField?.subviews.first {
            searchText.backgroundColor = UIColor.white
            searchText.layer.cornerRadius = 10
            searchText.clipsToBounds = true
        }
        UIBarButtonItem.appearance(whenContainedInInstancesOf:[UISearchBar.self]).tintColor = UIColor.gray

        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = Const.Placeholder.searchBook
        searchController.searchBar.searchBarStyle = .prominent
        searchController.searchBar.backgroundColor = UIColor.greenBook
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true

        self.navigationController?.navigationBar.barTintColor = UIColor.greenBook
    }
}

extension BookViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {

    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let name = searchBar.text else { return }

        if name.count > 3 {
            self.presenter.cleanListBook()
            self.presenter.fetch(name: name)
        }
    }

    func didPresentSearchController(_ searchController: UISearchController) {
        self.searchController.searchBar.becomeFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.showsCancelButton = false
        searchController.searchBar.sizeToFit()
    }
}

extension BookViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter.getCountCell()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Cell.bookCell, for: indexPath) as! BookCell
        let book = self.presenter.getBook(index: indexPath.row)
        cell.configure(book: book, isFavorite: self.presenter.isFavorite(id: book.id), delegate: self)
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

    }

}

extension BookViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  20
        let collectionViewSize = collectionView.frame.size.width - padding

        return CGSize(width: collectionViewSize/2, height: 260)
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

extension BookViewController: BookProtocol {

    func show() {
        self.collectionView.reloadData()
    }

    func showLoading(message: String) {
        UIAlertController().loading(viewController: self, name: message.isEmpty ? self.presenter.getNameSearchBook() : message)
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

    }
}

extension BookViewController: BookCellDelegate {

    func favorite(id: String) {
        self.presenter.saveBook(id: id)
    }

    func buyBook(id: String) {
        self.presenter.openBuyBook(id: id)
    }
}
