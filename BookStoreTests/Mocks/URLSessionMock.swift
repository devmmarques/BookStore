//
//  URLSessionMock.swift
//  BookStoreTests
//
//  Created by marco.h.maia.marques on 24/03/19.
//  Copyright © 2019 marco.h.maia.marques. All rights reserved.
//

import Foundation

@testable import BookStore

final class URLSessionMock: URLSessionProtocol {

    private(set) var isRequestCalled = false
    private(set) var lastURL: URL?
    private(set) var lastHttpMethod: NamespaceHTTPMethod?

    var expectedData: Data?
    var expectedStatusCode: Int? = 0
    var expectedError: Error?
    var nextDataTask = URLSessionDataTaskMock()

    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        let expectedResponse: URLResponse = HTTPURLResponse(url: request.url!, statusCode: self.expectedStatusCode!, httpVersion: nil, headerFields: nil)!
        isRequestCalled = true
        lastURL = request.url
        lastHttpMethod = NamespaceHTTPMethod(rawValue: request.httpMethod!)
        completionHandler(self.expectedData, expectedResponse, self.expectedError)
        return nextDataTask
    }

}
