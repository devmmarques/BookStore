//
//  VolumeInfo.swift
//  BookStore
//
//  Created by marco.h.maia.marques on 24/03/19.
//  Copyright © 2019 marco.h.maia.marques. All rights reserved.
//

import Foundation

struct VolumeInfo: Codable {

    let title: String
    let authors: [String]?
    let description: String?
    let industryIdentifiers: [IndustryIdentifiers]?
    let pageCount: Int?
    let printType: String
    let categories: [String]?
    let imageLinks: ImageLinks

    init(title: String, authors: [String]?, description: String?, industryIdentifiers: [IndustryIdentifiers]?, pageCount: Int?, printType: String, categories:[String]?, imageLinks: ImageLinks) {
        self.title = title
        self.authors = authors
        self.description = description
        self.industryIdentifiers = industryIdentifiers
        self.pageCount = pageCount
        self.printType = printType
        self.categories = categories
        self.imageLinks = imageLinks
    }

    private enum CodingKeys: String, CodingKey {
        case title = "title"
        case authors = "authors"
        case description = "description"
        case industryIdentifiers = "industryIdentifiers"
        case pageCount = "pageCount"
        case printType = "printType"
        case categories = "categories"
        case imageLinks = "imageLinks"
    }
}
