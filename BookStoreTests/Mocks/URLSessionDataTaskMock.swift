//
//  URLSessionDataTaskMock.swift
//  BookStoreTests
//
//  Created by marco.h.maia.marques on 24/03/19.
//  Copyright © 2019 marco.h.maia.marques. All rights reserved.
//

import Foundation

@testable import BookStore

final class URLSessionDataTaskMock: URLSessionDataTaskProtocol {

    private(set) var isResumeCalled = false

    func resume() {
        isResumeCalled = true
    }

}
