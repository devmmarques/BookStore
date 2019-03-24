//
//  BookService.swift
//  BookStore
//
//  Created by marco.h.maia.marques on 24/03/19.
//  Copyright © 2019 marco.h.maia.marques. All rights reserved.
//

import Foundation.NSObject

protocol BookServiceProtocol {
    func fetchBook(name: String, page: Int, completion: @escaping (APIResult<SearchResponse>) -> Void)
}

final class BookService: NSObject, BookServiceProtocol {

    private let apiClient: APIClientProtocol

    override init() {
        self.apiClient = APIClient()
    }

    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }

    func fetchBook(name: String, page: Int, completion: @escaping (APIResult<SearchResponse>) -> Void) {
        let router = BookRouter.search(name: name, page: page)
        apiClient.request(router: router){ (response: APIResult<SearchResponse>) in
            switch response {
            case let .success(value):
                completion(.success(value))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}

extension BookService {

    func saveBooks(books: [Int]) {
        books.store(key: Const.UserDefault.booksFavorite)
    }

    func loadBooks() -> [Int]? {
        return [Int].load(key: Const.UserDefault.booksFavorite)
    }

    func removeBooks() {
        [Int].remove(key: Const.UserDefault.booksFavorite)
    }


}
