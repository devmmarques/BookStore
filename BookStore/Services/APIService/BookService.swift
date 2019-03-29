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
    
    func fetchBookBy(completion: @escaping (APIResult<[Book]>) -> Void) {
        guard let bookIds = loadBooks(), !bookIds.isEmpty else {
            completion(.success([]))
            return
        }
        
        var books = [Book]()
        var alreadyFailed = false
        
        for id in bookIds {
            let router = BookRouter.fetch(id: id)
            apiClient.request(router: router){ (response: APIResult<Book>) in
                guard alreadyFailed == false else { return }
                
                switch response {
                case let .success(value):
                    
                    books.append(value)
                    if books.count == bookIds.count {
                        completion(.success(books))
                    }
                case let .failure(error):
                    alreadyFailed = true
                    completion(.failure(error))
                }
            }
        }
    }
}

extension BookService {

    func saveBooks(books: [String]) {
        books.store(key: Const.UserDefault.booksFavorite)
    }

    func loadBooks() -> [String]? {
        return [String].load(key: Const.UserDefault.booksFavorite)
    }

    func removeBooks() {
        [String].remove(key: Const.UserDefault.booksFavorite)
    }


}
