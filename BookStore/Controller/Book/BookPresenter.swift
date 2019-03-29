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
    private var nameBook = ""

    private var listBook: [Book] = []
    
    init(viewProtocol: BookProtocol, serviceAPI: BookService) {
        self.viewProtocol = viewProtocol
        self.serviceAPI = serviceAPI
    }

    func fetch(name: String) {
        self.viewProtocol.showLoading()
        self.nameBook = name
        if self.validFetchBook() {
            self.serviceAPI.fetchBook(name: self.nameBook, page: currentPage) { [weak self] result in
                switch result {
                case let .success(response):
                    self?.mountBook(response: response)
                    self?.viewProtocol.show()
                    self?.viewProtocol.dismissLoading()
                case .failure(let error):
                    self?.viewProtocol.show(error: error)
                }
            }
        }
    }
    
    func fetchFavorite() {
        self.viewProtocol.showLoading()
        self.serviceAPI.fetchBookFavorite() { [weak self] result in
            switch result {
            case let .success(response):
                self?.mountFavorite(books: response)
                self?.viewProtocol.show()
                self?.viewProtocol.dismissLoading()
            case .failure(let error):
                self?.viewProtocol.show(error: error)
            }
        }
    }

    private func mountBook(response: SearchResponse) {
        self.totalBook =  response.totalItems
        self.listBook += response.items
        self.currentPage += 1
    }
    
    private func mountFavorite(books: [Book]) {
        self.listBook = books
    }

    private func validFetchBook() -> Bool {
        if self.listBook.count >= self.totalBook && self.listBook.count > 0 {
            return false
        }
        return true
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

    public func getNameSearchBook() -> String {
        return nameBook
    }

    public func cleanListBook() {
        self.listBook = []
        self.currentPage = 0
        self.totalBook = 0
    }
  
}
