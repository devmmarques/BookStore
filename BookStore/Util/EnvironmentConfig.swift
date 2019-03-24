//
//  EnvironmentConfig.swift
//  BookStore
//
//  Created by marco.h.maia.marques on 24/03/19.
//  Copyright © 2019 marco.h.maia.marques. All rights reserved.
//

import Foundation


struct EnvironmentConfig {

    private static var environments: [String: Any]? {
        guard let dict: [String: Any] = Bundle.main.infoDictionary?["EnvironmentConfig"] as? [String: Any] else { return nil }
        return dict
    }

    static var host: String {
        guard let value = environments?["HOST"] as? String else { return "" }
        return value
    }
}
