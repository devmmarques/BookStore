//
//  StoryboardUtil.swift
//  BookStore
//
//  Created by Marco Marques on 26/03/19.
//  Copyright © 2019 marco.h.maia.marques. All rights reserved.
//

import UIKit

class StoryboardUtil {

    func viewControllerWith(storeBoardName: String, controllerName: String) -> UIViewController{
        let storyboard = UIStoryboard(name: storeBoardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: controllerName)
    }
    
    static func bookViewController() -> BookViewController {
        let bookViewController = StoryboardUtil().viewControllerWith(storeBoardName: "Main", controllerName: "BookViewController")
        return  bookViewController as! BookViewController
    }

}
