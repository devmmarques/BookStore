//
//  BookProtocol.swift
//  BookStore
//
//  Created by marco.h.maia.marques on 24/03/19.
//  Copyright © 2019 marco.h.maia.marques. All rights reserved.
//

import Foundation

protocol BookProtocol: AnyObject {
    func show()
    func showLoading()
    func dismissLoading()
    func show(error: Error)
}
