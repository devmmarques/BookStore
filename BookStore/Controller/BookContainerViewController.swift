//
//  BookContainerViewController.swift
//  BookStore
//
//  Created by Marco Marques on 26/03/19.
//  Copyright © 2019 marco.h.maia.marques. All rights reserved.
//

import UIKit

enum BookType: Int {
    case home = 0
    case favorite = 1
}

final class BookContainerViewController: UIViewController {
    
    private let bookViewController: BookViewController
    private let favoriteViewController: BookFavoriteViewController
    
    init() {
        
        bookViewController = StoryboardUtil.bookViewController()
        favoriteViewController = StoryboardUtil.bookFavoriteViewController()
        
        super.init(nibName: nil, bundle: nil)
        
        bookViewController.containerController = self
        setupHierarchy()
        setupConstraints()
        setupNavigationBar()
        
        configureChildViewController(with: .home)
        segmentedControl.selectedSegmentIndex = BookType.home.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var containerSegmentedControl: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.greenBook
        return view
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: ["Home", "Favoritos"])
        segmentControl.addTarget(self, action: #selector(segmentedTouched), for: .valueChanged)
        segmentControl.tintColor = .white
        return segmentControl
    }()
    
    
    private lazy var containerBookView = {
        return UIView(frame: .zero)
    }()
    
    @objc private func segmentedTouched() {
        changeChildController()
    }
    
    private func changeChildController() {
        if let bookType = BookType(rawValue: segmentedControl.selectedSegmentIndex) {
            switch bookType {
            case .home:
                configureChildViewController(with: .home)
            case .favorite:
                configureChildViewController(with: .favorite)
            }
        }
    }
    
    private func setupNavigationBar() {
        bookViewController.navigationController?.navigationBar.topItem?.title = "Home"
        favoriteViewController.navigationController?.navigationItem.title = "Favoritos"
    }
    
    private func removePreviousControlle(controller: UIViewController) {
        controller.view.removeFromSuperview()
        controller.removeFromParent()
    }
    
    private func configureChildViewController(with bookType: BookType) {
        let viewController: UIViewController
        
        switch bookType {
        case .home:
            removePreviousControlle(controller: favoriteViewController)
            viewController = bookViewController
        case .favorite:
            removePreviousControlle(controller: bookViewController)
            viewController = favoriteViewController
        }
        
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        viewController.willMove(toParent: self)
        
        addChild(viewController)
        containerBookView.addSubview(viewController.view)
        
        NSLayoutConstraint.activate([
            viewController.view.leadingAnchor.constraint(equalTo: containerBookView.leadingAnchor),
            viewController.view.trailingAnchor.constraint(equalTo: containerBookView.trailingAnchor),
            viewController.view.topAnchor.constraint(equalTo: containerBookView.topAnchor),
            viewController.view.bottomAnchor.constraint(equalTo: containerBookView.bottomAnchor),
            ])
        
        viewController.didMove(toParent: self)
    }
    
    private func setupHierarchy() {
        view.addSubview(containerSegmentedControl)
        containerSegmentedControl.addSubview(segmentedControl)
        view.addSubview(containerBookView)
    }
    
    private func setupConstraints() {
        containerSegmentedControl.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        containerSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        containerSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        containerSegmentedControl.heightAnchor.constraint(equalToConstant: 48.0).isActive = true
        containerSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        segmentedControl.centerYAnchor.constraint(equalTo: containerSegmentedControl.centerYAnchor).isActive = true
        segmentedControl.centerXAnchor.constraint(equalTo: containerSegmentedControl.centerXAnchor).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 28).isActive = true
        segmentedControl.widthAnchor.constraint(equalToConstant: 194).isActive = true
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        containerBookView.topAnchor.constraint(equalTo: containerSegmentedControl.bottomAnchor).isActive = true
        containerBookView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        containerBookView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        containerBookView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        containerBookView.translatesAutoresizingMaskIntoConstraints = false
    }
}
