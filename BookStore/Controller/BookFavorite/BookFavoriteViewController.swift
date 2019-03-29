//
//  BookFavoriteViewController.swift
//  BookStore
//
//  Created by Marco Marques on 29/03/19.
//  Copyright © 2019 marco.h.maia.marques. All rights reserved.
//

import UIKit

final class BookFavoriteViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    private lazy var presenter: BookFavoritePresenter = {
        let presenter = BookFavoritePresenter(viewProtocol: self, serviceAPI: BookService())
        return presenter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         collectionView.register(UINib(nibName: Const.Cell.bookCell, bundle: nil), forCellWithReuseIdentifier: Const.Cell.bookCell)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.presenter.fetchFavorite()
    }
    
}

extension BookFavoriteViewController: UICollectionViewDataSource {
    
    
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
   
}

extension BookFavoriteViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewDetailBook = StoryboardUtil.bookDetailViewController()
        viewDetailBook.idBook = self.presenter.getBook(index: indexPath.row).id
        self.present(viewDetailBook, animated: false, completion: nil)
    }

}

extension BookFavoriteViewController: UICollectionViewDelegateFlowLayout {
    
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

extension BookFavoriteViewController: BookProtocol {
    
    func show() {
        self.collectionView.reloadData()
    }
    
    func showLoading() {
         UIAlertController().loading(viewController: self, message: Const.loading)
    }
    
    func showBuyBook(url: String) {
        
    }
    
    func dismissLoading() {
        UIAlertController().dismissLoading(viewController: self)
    }
    
    func show(error: Error) {
        
    }
}
