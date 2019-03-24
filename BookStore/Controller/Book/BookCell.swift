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
    let activityIndicator = UIActivityIndicatorView(style: .gray)

    func configure(book: Book) {
        configureLoadingImage()

        /*
         Poderia utilizar SDWebImage para ajudar no cache, mas preferi usar dessa forma simples com uma extension de UIImage
        */
        imageBook.imageFromURL(urlString: book.volumeInfo.imageLinks.thumbnail)
    }

    private func configureLoadingImage() {
        activityIndicator.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        activityIndicator.color = UIColor.gray

        if self.imageBook == nil {
            self.addSubview(activityIndicator)
        }
    }
}
