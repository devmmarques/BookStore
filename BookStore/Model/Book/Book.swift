//
//  Book.swift
//  BookStore
//
//  Created by marco.h.maia.marques on 24/03/19.
//  Copyright © 2019 marco.h.maia.marques. All rights reserved.
//

import Foundation

struct Book: Codable {

    let kind: String
    let id: String
    let eTag: String
    let selfLink: String
    let volumeInfo: VolumeInfo
    let saleInfo: SaleInfo

    init(kind: String, id: String, eTag: String, selfLink: String, volumeInfo: VolumeInfo, saleInfo: SaleInfo) {
        self.kind = kind
        self.id = id
        self.eTag = eTag
        self.selfLink = selfLink
        self.volumeInfo = volumeInfo
        self.saleInfo = saleInfo
    }


    private enum CodingKeys: String, CodingKey {
        case kind = "kind"
        case id = "id"
        case eTag = "etag"
        case selfLink = "selfLink"
        case volumeInfo = "volumeInfo"
        case saleInfo = "saleInfo"
    }
}
