//
//  BookServiceSpec.swift
//  BookStoreTests
//
//  Created by marco.h.maia.marques on 24/03/19.
//  Copyright © 2019 marco.h.maia.marques. All rights reserved.
//

import Nimble
import Quick

@testable import BookStore

final class BookServiceSpec: QuickSpec {


    override func spec() {
        super.spec()

        var apiClient: APIClientProtocol!
        var sut: BookService!
        var session: URLSessionMock!
        var expectedDataBook: Data!
        var resultBook: APIResult<SearchResponse>!

        describe("fetch Book Sucesss") {

            beforeSuite {
                expectedDataBook = JSONAPIParse().get(fileName: "book_status_200")
            }

            beforeEach {
                session = URLSessionMock()
                apiClient = APIClient(session: session)
                sut = BookService(apiClient: apiClient)
            }

            context("Sucess") {

                it("should make an fetch request books with success"){
                    session.expectedData = expectedDataBook
                    session.expectedStatusCode = 200

                    sut.fetchBook(name: "ios", page: 1) { resultBook = $0 }
                    expect(session.isRequestCalled).to(beTrue())
                    expect(resultBook.value).toEventuallyNot(beNil())
                    expect(resultBook.value?.items).toEventuallyNot(beNil())
                    expect(resultBook.value?.totalItems).toEventually(equal(383))
                }

            }

            context("error") {
                it("should return error") {
                    session.expectedStatusCode = 401
                    sut.fetchBook(name: "ios", page: 1) { resultBook = $0 }
                    expect(resultBook.error as? APIError).toEventually(equal(APIError.unauthorized))
                }
            }
        }
    }
}
