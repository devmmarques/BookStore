//
//  BookDetailViewController.swift
//  BookStore
//
//  Created by Marco Marques on 28/03/19.
//  Copyright © 2019 marco.h.maia.marques. All rights reserved.
//

import UIKit

final class BookDetailViewController: UIViewController {
    
    //MARK : Outlets
    
    @IBOutlet weak var viewGray: UIView!
    @IBOutlet weak var viewDetail: UIView!
    @IBOutlet weak var closerButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bookDetailImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var constraintTopDetailView: NSLayoutConstraint!
    
    // MARK: Properties
    var idBook = ""
    
    private lazy var presenter: BookDetailPresenter = {
        let presenter = BookDetailPresenter(viewProtocol: self, serviceAPI: BookService())
        return presenter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        constraintTopDetailView.constant = CGFloat(700)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.presenter.fetchFavorite(id: idBook)
        viewDetail.roundedCorner()
        showView()
        configureDismiss()
    }
    
    @IBAction func closerView(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addFavorite(_ sender: UIButton) {
        self.presenter.saveBook()
    }
    
    @IBAction func buyBook(_ sender: UIButton) {
        self.presenter.buyBook()
    }
    
    private func configureBook () {
        self.titleLabel.text = self.presenter.getBook().volumeInfo.title
        
        if let description = self.presenter.getBook().volumeInfo.description {
            self.descriptionLabel.attributedText = description.html2Attributed
        }
        
        if let _ = self.presenter.getBook().saleInfo.buyLink {
            self.buyButton.alpha = 1.0
        } else {
            self.buyButton.alpha = 0.0
        }
        
        if let image = self.presenter.getBook().volumeInfo.imageLinks {
            self.bookDetailImage.imageFromURL(urlString: image.thumbnail)
        }
        
        if self.presenter.isFavorite() {
            self.favoriteButton.setImage(UIImage(named: "like"), for: .normal)
        } else {
            self.favoriteButton.setImage(UIImage(named: "unlike"), for: .normal)
        }
        
        buyButton.roundedCorner()
        buyButton.backgroundColor = UIColor.greenBook
        
        bookDetailImage.roundedCorner()
        bookDetailImage.applyFormShadow()
        
        self.viewDetail.layoutSubviews()
    }
}

extension BookDetailViewController {
    
    private func showView() {
        
        self.constraintTopDetailView.constant = CGFloat(100)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 3, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
            self.viewGray.alpha = 0.5
        }, completion: nil)
    }
    
    final func configureDismiss() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismiss(_:)))
        tap.cancelsTouchesInView = true
        self.viewGray.addGestureRecognizer(tap)
    }
    
    @objc final func dismiss(_ tap: UIGestureRecognizer) {
        self.dismissView()
    }
    
    func dismissView(completion: (() -> Void)? = nil) {
        self.constraintTopDetailView.constant = 0.0
        UIView.animate(withDuration: 0.5, animations: {
            self.viewGray.alpha = 0
            self.view.layoutIfNeeded()
        }) { _ in
            self.dismiss(animated: false, completion: completion)
        }
    }
}

extension BookDetailViewController: BookProtocol {
    
    
    func show() {
        self.configureBook()
    }
    
    func showLoading() {
       UIAlertController().loading(viewController: self, message: Const.loading)
    }
    
    func showBuyBook(url: String) {
        guard let urlBook = URL(string: url) else { return }
        UIApplication.shared.open(urlBook, options: [:], completionHandler: nil)
    }
    
    func dismissLoading() {
        UIAlertController().dismissLoading(viewController: self)
    }
    
    func show(error: Error) {
     
    }
}

extension String {
    var html2Attributed: NSAttributedString? {
        do {
            guard let data = data(using: String.Encoding.utf8) else {
                return nil
            }
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
}
