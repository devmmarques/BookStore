//
//  ImageLinks.swift
//  BookStore
//
//  Created by marco.h.maia.marques on 24/03/19.
//  Copyright © 2019 marco.h.maia.marques. All rights reserved.
//

import Foundation

struct ImageLinks: Codable {

    let smallThumbnail: String
    let thumbnail: String

    init(smallThumbnail: String, thumbnail: String) {
        self.smallThumbnail = smallThumbnail
        self.thumbnail = thumbnail
    }

    private enum CodingKeys: String, CodingKey {
        case smallThumbnail = "smallThumbnail"
        case thumbnail = "thumbnail"
    }
}
