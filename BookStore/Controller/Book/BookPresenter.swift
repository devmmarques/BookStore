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

    func saveBook(id: String) {
        if var listBookIds = self.serviceAPI.loadBooks() {
            if listBookIds.contains(id) {
                let newList = listBookIds.filter { $0 != id }
                serviceAPI.removeBooks()
                serviceAPI.saveBooks(books: newList)
            } else {
                listBookIds.append(id)
                serviceAPI.removeBooks()
                serviceAPI.saveBooks(books: listBookIds)
            }
        } else {
            serviceAPI.saveBooks(books: [id])
        }
        self.viewProtocol.show()
    }

    func isFavorite(id: String) -> Bool{
        if let listBookIds = self.serviceAPI.loadBooks() {
            return listBookIds.contains(id)
        }
        return false
    }

    public func getCountCell() -> Int {
        return listBook.count
    }

    public func getBook(index: Int) -> Book {
        return self.listBook[index]
    }

}
