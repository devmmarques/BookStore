//
//  BookDetailPresenter.swift
//  BookStore
//
//  Created by Marco Marques on 29/03/19.
//  Copyright © 2019 marco.h.maia.marques. All rights reserved.
//

import Foundation


class BookDetailPresenter {
    
    private let viewProtocol: BookProtocol
    private let serviceAPI: BookService
    private var book: Book?
    
    init(viewProtocol: BookProtocol, serviceAPI: BookService) {
        self.viewProtocol = viewProtocol
        self.serviceAPI = serviceAPI
    }
    
    
    func fetchFavorite(id: String) {
        self.serviceAPI.fetchBookBy(id: id) { [weak self] result in
            switch result {
            case let .success(response):
                self?.book = response
                self?.viewProtocol.show()
            case .failure(let error):
                self?.viewProtocol.show(error: error)
            }
        }
    }
    
    
    func saveBook() {
        guard let book = book else { return }
        if var listBookIds = self.serviceAPI.loadBooks() {
            if listBookIds.contains(book.id) {
                let newList = listBookIds.filter { $0 != book.id }
                serviceAPI.removeBooks()
                serviceAPI.saveBooks(books: newList)
            } else {
                listBookIds.append(book.id)
                serviceAPI.removeBooks()
                serviceAPI.saveBooks(books: listBookIds)
            }
        } else {
            serviceAPI.saveBooks(books: [book.id])
        }
        self.viewProtocol.show()
    }
    
    func isFavorite() -> Bool{
        if let listBookIds = self.serviceAPI.loadBooks(), let book = book {
            return listBookIds.contains(book.id)
        }
        return false
    }
    
    
    func getBook() -> Book {
        return book!
    }
    
    func buyBook() {
        self.viewProtocol.showBuyBook(url: book!.selfLink)
    }
}
