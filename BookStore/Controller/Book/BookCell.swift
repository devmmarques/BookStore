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
}

final class BookCell: UICollectionViewCell {


    @IBOutlet weak var imageBook: UIImageView!
    @IBOutlet weak var titleBook: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!

    private weak var delegate: BookCellDelegate?
    private var idBook: String?


    func configure(book: Book, isFavorite: Bool, delegate: BookCellDelegate) {
        self.delegate = delegate
        titleBook.text = book.volumeInfo.title
        self.idBook = book.id
        /*
         Poderia utilizar SDWebImage para ajudar no cache, mas preferi usar dessa forma simples com uma extension de UIImage
        */
        imageBook.imageFromURL(urlString: book.volumeInfo.imageLinks.thumbnail)
        configureFavorite(isFavorite: isFavorite)
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

}
