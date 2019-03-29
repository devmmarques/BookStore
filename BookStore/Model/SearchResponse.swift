//
//  SearchResponse.swift
//  BookStore
//
//  Created by marco.h.maia.marques on 24/03/19.
//  Copyright © 2019 marco.h.maia.marques. All rights reserved.
//

import Foundation

struct SearchResponse: Codable {

    let kind: String
    let totalItems: Int
    let items: [Book]

    init(kind: String, totalItems: Int, items: [Book]) {
        self.kind = kind
        self.totalItems = totalItems
        self.items = items
    }

    private enum CodingKeys: String, CodingKey {
        case kind = "kind"
        case totalItems = "totalItems"
        case items = "items"
    }
}
