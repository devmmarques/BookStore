//
//  Dialogable.swift
//  BookStore
//
//  Created by Marco Marques on 27/03/19.
//  Copyright © 2019 marco.h.maia.marques. All rights reserved.
//

import UIKit


protocol Dialogable {
    func showDialog(title: String?, message: String?, image: UIImage?, buttonTitle: String, buttonStyle: BookAlertAction.Style, completion: @escaping (Bool) -> Void)
    func showDestructiveDialog(title: String?, message: String?, image: UIImage?, buttonTitle: String, completion: @escaping (Bool) -> Void)
    func showConstructiveDialog(title: String?, message: String?, image: UIImage?, buttonTitle: String, completion: @escaping (Bool) -> Void)
}


extension Dialogable where Self: UIViewController {
    
    func showDialog(title: String?, message: String?, image: UIImage?, buttonTitle: String, buttonStyle: BookAlertAction.Style = .default, completion: @escaping (Bool) -> Void) {
        let action1 = BookAlertAction(title: buttonTitle, style: buttonStyle, handler: {
            completion(true)
        })
        let action2 = BookAlertAction(title: "CANCELAR", handler: {
            completion(false)
        })
        
        let alert = BookAlertController(title: title, message: message, image: image)
        alert.addAction(action1)
        alert.addAction(action2)
        
        self.present(alert, animated: false, completion: nil)
    }
    
    func showDestructiveDialog(title: String?, message: String?, image: UIImage?, buttonTitle: String, completion: @escaping (Bool) -> Void) {
        showDialog(title: title, message: message, image: image, buttonTitle: buttonTitle, buttonStyle: .destructive, completion: completion)
    }
    
    func showConstructiveDialog(title: String?, message: String?, image: UIImage?, buttonTitle: String, completion: @escaping (Bool) -> Void) {
        showDialog(title: title, message: message, image: image, buttonTitle: buttonTitle, buttonStyle: .constructive, completion: completion)
    }
    
    func showDefaultDialog(title: String?, message: String?, image: UIImage?, buttonTitle: String, completion: @escaping (Bool) -> Void) {
        showDialog(title: title, message: message, image: image, buttonTitle: buttonTitle, completion: completion)
    }
    
}
