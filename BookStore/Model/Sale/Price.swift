//
//  Price.swift
//  BookStore
//
//  Created by marco.h.maia.marques on 24/03/19.
//  Copyright © 2019 marco.h.maia.marques. All rights reserved.
//

import Foundation

struct Price: Codable {
    let amount: Double
    let currencyCode: String

    init(amount: Double, currencyCode: String) {
        self.amount = amount
        self.currencyCode = currencyCode
    }

    private enum CodingKeys: String, CodingKey {
        case amount = "amount"
        case currencyCode = "currencyCode"
    }
}
