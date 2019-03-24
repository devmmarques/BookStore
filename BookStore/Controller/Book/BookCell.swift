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


    func configure() {
        imageBook.image = UIImage(named: "placeholder")
    }
}
