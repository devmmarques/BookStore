//
//  APIResult.swift
//  BookStore
//
//  Created by marco.h.maia.marques on 24/03/19.
//  Copyright © 2019 marco.h.maia.marques. All rights reserved.
//

import Foundation

enum APIResult<T> {
    case success(T)
    case failure(Swift.Error)
}

extension APIResult {
    var isSuccess: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
    }

    var isFailure: Bool {
        return !isSuccess
    }

    var value: T? {
        switch self {
        case .success(let value):
            return value
        case .failure:
            return nil
        }
    }

    var error: Swift.Error? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }
}

extension APIResult: CustomStringConvertible {
    var description: String {
        switch self {
        case .success:
            return "SUCCESS"
        case .failure:
            return "FAILURE"
        }
    }
}

extension APIResult: CustomDebugStringConvertible {
    var debugDescription: String {
        switch self {
        case .success(let value):
            return "SUCCESS: \(value)"
        case .failure(let error):
            return "FAILURE: \(error)"
        }
    }
}

extension APIResult where T == Void {
    static var success: APIResult {
        return .success(())
    }
}
