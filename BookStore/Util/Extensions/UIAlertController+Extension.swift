//
//  UIAlertController+Extension.swift
//  BookStore
//
//  Created by marco.h.maia.marques on 25/03/19.
//  Copyright © 2019 marco.h.maia.marques. All rights reserved.
//

import UIKit

extension UIAlertController {

    func loading(viewController: UIViewController) {
        let alert = UIAlertController(title: nil, message: "Aguarde...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.color = UIColor.greenBook
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        viewController.present(alert, animated: true, completion: nil)
    }

    func dismissLoading(viewController: UIViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }

}
