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
    
    func configure(thumbnail: String) {
        
        /*
         Poderia utilizar SDWebImage para ajudar no cache, mas preferi usar dessa forma simples com uma extension de UIImage ao invés de incluir um POD
        */
        imageBook.imageFromURL(urlString: thumbnail)
        configureLayoutView()
    }

    private func configureLayoutView(){
        imageBook.roundedCorner()
        imageBook.applyFormShadow()
    }
}
