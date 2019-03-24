//
//  Storable.swift
//  BookStore
//
//  Created by marco.h.maia.marques on 24/03/19.
//  Copyright © 2019 marco.h.maia.marques. All rights reserved.
//

import Foundation

protocol Storable {
    func store(key: String)
    static func isStored(key: String) -> Bool
    static func load(key: String) -> Self?
    static func remove(key: String)
}

extension Storable {

    func store(key: String) {
        let defaults = UserDefaults.standard
        defaults.set(self, forKey: key)
    }

    static func isStored(key: String) -> Bool {
        let defaults = UserDefaults.standard
        return (defaults.object(forKey: key) as? Codable != nil)
    }

    static func load(key: String) -> Self? {
        let defaults = UserDefaults.standard
        return defaults.object(forKey: key) as? Self
    }

    static func remove(key: String) {
        let defaults = UserDefaults.standard
        return defaults.removeObject(forKey: key)
    }

}

extension Array: Storable { }
