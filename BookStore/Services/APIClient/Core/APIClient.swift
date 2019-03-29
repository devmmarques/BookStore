//
//  APIClient.swift
//  BookStore
//
//  Created by marco.h.maia.marques on 24/03/19.
//  Copyright © 2019 marco.h.maia.marques. All rights reserved.
//

import class Foundation.URLSession
import class Foundation.URLSessionConfiguration

import class Foundation.NSError
import class Foundation.HTTPURLResponse
import class Dispatch.DispatchQueue

struct APIClient: APIClientProtocol {
    private let session: URLSessionProtocol
    private let queue: DispatchQueue?

    init(session: URLSessionProtocol? = nil, queue: DispatchQueue? = nil) {
        if let session = session {
            self.session = session
        } else {
            let configuration = URLSessionConfiguration.default
            configuration.requestCachePolicy = .reloadRevalidatingCacheData
            configuration.httpShouldSetCookies = true
            configuration.allowsCellularAccess = true
            configuration.networkServiceType = .default
            self.session = URLSession(configuration: configuration)
        }

        self.queue = queue
    }

    func request<T: Codable>(router: APIRouter, completion: @escaping Completion<T>) {
        guard let request = router.asURLRequest() else {
            dispatchAsync(completion, with: .failure(APIError.unknown))
            return
        }

        let task = session.dataTask(with: request) { data, response, error in
            if let error = APIError.handleError(error: error as NSError?) {
                self.dispatchAsync(completion, with: .failure(error))
                return
            }
            if let error = APIError.handleHttpStatus(response: response as? HTTPURLResponse) {
                self.dispatchAsync(completion, with: .failure(error))
                return
            }
            guard let data = data else {
                self.dispatchAsync(completion, with: .failure(APIError.invalidData))
                return
            }
            do {
                let decoded = try T.decode(from: data)
                self.dispatchAsync(completion, with: .success(decoded))
            } catch {
                print(">>> Erro de parse: \(error)")
                self.dispatchAsync(completion, with: .failure(APIError.invalidData))
            }
        }

        task.resume()
    }

    func request(router: APIRouter, completion: @escaping Completion<Void>) {
        guard let request = router.asURLRequest() else {
            dispatchAsync(completion, with: .failure(APIError.unknown))
            return
        }

        let task = session.dataTask(with: request) { _, response, error in
            if let error = APIError.handleError(error: error as NSError?) {
                self.dispatchAsync(completion, with: .failure(error))
                return
            }
            if let error = APIError.handleHttpStatus(response: response as? HTTPURLResponse) {
                self.dispatchAsync(completion, with: .failure(error))
                return
            }

            self.dispatchAsync(completion, with: .success)
        }

        task.resume()
    }

    typealias Completion<T> = (APIResult<T>) -> Void
}

// MARK: - Private methods

private extension APIClient {

    func dispatchAsync<T>(_ completion: @escaping Completion<T>, with result: APIResult<T>) {
        (queue ?? .main).async {
            completion(result)
        }
    }

}

