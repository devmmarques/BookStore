//
//  IndustryIdentifiers.swift
//  BookStore
//
//  Created by marco.h.maia.marques on 24/03/19.
//  Copyright © 2019 marco.h.maia.marques. All rights reserved.
//

import Foundation

struct IndustryIdentifiers: Codable {

    let type: String
    let identifier: String

    init(type: String, identifier: String) {
        self.type = type
        self.identifier = identifier
    }

    private enum CodingKeys: String, CodingKey {
        case type = "type"
        case identifier = "identifier"
    }
}
