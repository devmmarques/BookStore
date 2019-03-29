//
//  AppearanceNavigationHelper.swift
//  BookStore
//
//  Created by Marco Marques on 27/03/19.
//  Copyright © 2019 marco.h.maia.marques. All rights reserved.
//

import UIKit

struct AppearanceNavigationHelper {
    
    static func customizeNavigationBar() {
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.isTranslucent = false
        navigationBarAppearace.tintColor = .white
        navigationBarAppearace.barTintColor = UIColor.greenBook
        navigationBarAppearace.shadowImage = UIImage.init()
        navigationBarAppearace.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationBarAppearace.setBackgroundImage(UIImage.init(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
    }
}
