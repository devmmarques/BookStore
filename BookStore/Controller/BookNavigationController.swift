//
//  BookNavigationController.swift
//  BookStore
//
//  Created by Marco Marques on 26/03/19.
//  Copyright © 2019 marco.h.maia.marques. All rights reserved.
//

import UIKit

public class BookNavigationController: UINavigationController {
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        AppearanceNavigationHelper.customizeNavigationBar()
        
        let controller = BookContainerViewController()
        self.pushViewController(controller, animated: true)
    }
}
