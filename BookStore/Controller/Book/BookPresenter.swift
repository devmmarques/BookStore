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
    private var currentPage = 0
    private var totalBook = 0
    private var firstFetch = true

    private var listBook: [Book] = []

    init(viewProtocol: BookProtocol, serviceAPI: BookService) {
        self.viewProtocol = viewProtocol
        self.serviceAPI = serviceAPI
    }

    func fetch(name: String) {
        self.viewProtocol.showLoading()

        if self.validFetchBook() {
            self.serviceAPI.fetchBook(name: name, page: currentPage) { [weak self] result in
                switch result {
                case let .success(response):
                    self?.mountBook(response: response)
                    self?.viewProtocol.show()
                    self?.viewProtocol.dismissLoading()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }

    private func mountBook(response: SearchResponse) {
        self.totalBook =  response.totalItems
        self.listBook += response.items
        self.currentPage += 1
        self.firstFetch = false
    }

    private func validFetchBook() -> Bool {
        if self.listBook.count >= self.totalBook && !firstFetch{
            return false
        }
        return true
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

    public func getTotalBooks() -> Int {
        return totalBook
    }

    public func openBuyBook(id: String) {
        if let book = listBook.first(where: { $0.id == id}) {
            guard let buyLink = book.saleInfo.buyLink else { return }
            self.viewProtocol.showBuyBook(url: buyLink)
        }
    }
}
