//
//  BookCell.swift
//  BookStore
//
//  Created by marco.h.maia.marques on 24/03/19.
//  Copyright © 2019 marco.h.maia.marques. All rights reserved.
//

import UIKit

protocol BookCellDelegate: class {
    func favorite(id: String)
    func buyBook(id: String)
}

final class BookCell: UICollectionViewCell {


    @IBOutlet weak var imageBook: UIImageView!
    @IBOutlet weak var titleBook: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var buyButton: UIButton!

    private weak var delegate: BookCellDelegate?
    private var idBook: String?


    func configure(book: Book, isFavorite: Bool, delegate: BookCellDelegate) {
        self.delegate = delegate
        titleBook.text = book.volumeInfo.title
        self.idBook = book.id
        /*
         Poderia utilizar SDWebImage para ajudar no cache, mas preferi usar dessa forma simples com uma extension de UIImage ao invés de incluir um POD
        */
        imageBook.imageFromURL(urlString: book.volumeInfo.imageLinks.thumbnail)
        configureFavorite(isFavorite: isFavorite)
        configureLayoutView()

    }

    private func configureLayoutView(){

        buyButton.roundedCorner()
        buyButton.backgroundColor = UIColor.greenBook

        imageBook.roundedCorner()
        imageBook.applyFormShadow()
    }

    private func configureFavorite(isFavorite: Bool) {
        if isFavorite {
            self.favoriteButton.setImage(UIImage(named: "like"), for: .normal)
        } else {
            self.favoriteButton.setImage(UIImage(named: "unlike"), for: .normal)
        }
    }

    @IBAction func favoriteBook(_ sender: UIButton) {
        guard let id = self.idBook else { return }
        delegate?.favorite(id: id)
    }

    @IBAction func buyBook(_ sender: UIButton) {
        guard let id = self.idBook else { return }
        delegate?.buyBook(id: id)
    }
}
