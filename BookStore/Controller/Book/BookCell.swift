//
//  BookCell.swift
//  BookStore
//
//  Created by marco.h.maia.marques on 24/03/19.
//  Copyright © 2019 marco.h.maia.marques. All rights reserved.
//

import UIKit

final class BookCell: UICollectionViewCell {


    @IBOutlet weak var imageBook: UIImageView!
    @IBOutlet weak var titleBook: UILabel!

    @IBOutlet weak var favoriteButton: UIButton!

    func configure(book: Book) {
        titleBook.text = book.volumeInfo.title

        /*
         Poderia utilizar SDWebImage para ajudar no cache, mas preferi usar dessa forma simples com uma extension de UIImage
        */
        imageBook.imageFromURL(urlString: book.volumeInfo.imageLinks.thumbnail)
    }


    @IBAction func favoriteBook(_ sender: UIButton) {

        
    }

}
