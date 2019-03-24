//
//  SaleInfo.swift
//  BookStore
//
//  Created by marco.h.maia.marques on 24/03/19.
//  Copyright © 2019 marco.h.maia.marques. All rights reserved.
//

import Foundation

struct SaleInfo: Codable {

    let country: String
    let saleAbility: String
    let listPrice: Price
    let retailPrice: Price
    let buyLink: String

    init(country: String, saleAbility: String, listPrice: Price, retailPrice: Price, buyLink: String) {
        self.country = country
        self.saleAbility = saleAbility
        self.listPrice = listPrice
        self.retailPrice = retailPrice
        self.buyLink = buyLink
    }

    private enum CodingKeys: String, CodingKey {
        case country = "country"
        case saleAbility = "saleAbility"
        case listPrice = "listPrice"
        case retailPrice = "retailPrice"
        case buyLink = "buyLink"
    }
}


