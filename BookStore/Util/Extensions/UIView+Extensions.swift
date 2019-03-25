//
//  UIView+Extensions.swift
//  BookStore
//
//  Created by marco.h.maia.marques on 24/03/19.
//  Copyright © 2019 marco.h.maia.marques. All rights reserved.
//

import UIKit

extension UIView {

    func roundedCorner() {
        let diff: CGFloat = 2.0
        let layerBounds = CGRect(x: layer.bounds.minX, y: layer.bounds.minY-diff, width: layer.bounds.width, height: layer.bounds.height+diff)
        layer.bounds = layerBounds
        layer.masksToBounds = false
        layer.cornerRadius = 4.0
    }

    func applyFormShadow() {
        layer.masksToBounds = false
        layer.cornerRadius = 4.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 4.0
    }

}

