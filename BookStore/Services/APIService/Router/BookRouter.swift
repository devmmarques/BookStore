//
//  BookRouter.swift
//  BookStore
//
//  Created by marco.h.maia.marques on 24/03/19.
//  Copyright © 2019 marco.h.maia.marques. All rights reserved.
//

enum BookRouter {
    case search(name: String, page: Int)
    case fetch(id: String)
}

extension BookRouter: APIRouter {

    var path: String {
        switch self {
        case .fetch(let id):
            return "volumes/\(id)"
        case .search(let name, let page):
            return "volumes?q=\(name)&maxResults=10&startIndex=\(page)"
        }
    }

    var method: NamespaceHTTPMethod {
        return .get
    }
}
