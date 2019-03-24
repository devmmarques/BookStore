//
//  BookPresenter.swift
//  BookStore
//
//  Created by marco.h.maia.marques on 24/03/19.
//  Copyright © 2019 marco.h.maia.marques. All rights reserved.
//

import Foundation

final class BookPresenter {

    private let viewProtocol: BookProtocol
    private let serviceAPI: BookService
    private let currentPage = 0

    private var listBook: [Book] = []

    init(viewProtocol: BookProtocol, serviceAPI: BookService) {
        self.viewProtocol = viewProtocol
        self.serviceAPI = serviceAPI
    }

    func fetch(name: String) {
        self.viewProtocol.showLoading()
        self.serviceAPI.fetchBook(name: name, page: currentPage) { [weak self] result in
            switch result {
            case let .success(response):
                self?.listBook = response.items
                self?.viewProtocol.show()
            case .failure(let error):
                print(error)
            }
        }
    }

    public func getCountCell() -> Int {
        return listBook.count
    }

    public func getBook(index: Int) -> Book {
        return self.listBook[index]
    }

}
