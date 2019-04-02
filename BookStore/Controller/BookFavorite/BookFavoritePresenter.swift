//
//  BookFavoritePresenter.swift
//  BookStore
//
//  Created by Marco Marques on 29/03/19.
//  Copyright © 2019 marco.h.maia.marques. All rights reserved.
//

import Foundation

final class BookFavoritePresenter {
    
    private let viewProtocol: BookProtocol
    private let serviceAPI: BookService


    private var listBook: [Book] = []
    
    init(viewProtocol: BookProtocol, serviceAPI: BookService) {
        self.viewProtocol = viewProtocol
        self.serviceAPI = serviceAPI
    }
    
    func fetchFavorite() {
        self.viewProtocol.showLoading()
        self.serviceAPI.fetchBookFavorite() { [weak self] result in
            switch result {
            case let .success(response):
                self?.listBook = response
                self?.viewProtocol.show()
                self?.viewProtocol.dismissLoading()
            case .failure(let error):
                self?.viewProtocol.show(error: error)
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
