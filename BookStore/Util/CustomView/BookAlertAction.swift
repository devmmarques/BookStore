//
//  BookAlertAction.swift
//  BookStore
//
//  Created by Marco Marques on 27/03/19.
//  Copyright © 2019 marco.h.maia.marques. All rights reserved.
//
import UIKit

final class BookAlertAction {
    
    enum Style: Int {
        case `default`, destructive, constructive
        
        func apply(on button: UIButton) {
            switch self {
            case .destructive:
                button.setTitleColor(.white, for: .normal)
            case .constructive:
                button.setTitleColor(.white, for: .normal)
           
            default:
                button.setTitleColor(.greenBook, for: .normal)
            }
        }
    }
    
    typealias Handler = () -> Void
    let title: String
    let style: Style
    let handler: Handler?
    
    init(title: String, style: Style = .default, handler: Handler? = nil) {
        self.title = title
        self.style = style
        self.handler = handler
    }
}


final class BookAlertController: UIViewController {
    
    private let alertViewTitle: String?
    private let alertViewMessage: String?
    private let alertViewImage: UIImage?
    
    private var actions: [BookAlertAction] = []
    
    private var buttons: [UIButton: BookAlertAction.Style] = [:]
    
    private let canvasView: UIView = UIView(frame: .zero)
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = alertViewImage
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = alertViewTitle
        label.textAlignment = .center
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = alertViewMessage
        label.textAlignment = .center
        return label
    }()
    
    init(title: String?, message: String?, image: UIImage?) {
        self.alertViewTitle = title
        self.alertViewMessage = message
        self.alertViewImage = image
        
        super.init(nibName: nil, bundle: nil)
        
        self.modalPresentationStyle = .overCurrentContext
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        canvasView.layoutIfNeeded()
        
        buttons.forEach { button, style in style.apply(on: button) }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if actions.isEmpty {
            fatalError("O BookAlertController não contém nenhuma action.")
        }
    }
    
    override func loadView() {
        view = UIView(frame: .zero)
        
        setupLayout()
        setupHierarchy()
        setupConstraints()
        setupButtonsAndHierarchy()
    }
    
}

extension BookAlertController {
    
    private func setupLayout() {
        view.isOpaque = false
        
        canvasView.backgroundColor = .white
        canvasView.applyFormShadow()
        
        UIApplication.shared.keyWindow?.windowLevel = UIWindow.Level.statusBar + 1
    }
    
    private func setupHierarchy() {
        view.addSubview(canvasView)
        canvasView.addSubview(imageView)
        canvasView.addSubview(titleLabel)
        canvasView.addSubview(descriptionLabel)
    }
    
    private func setupButtonsAndHierarchy() {
        let buttonHeight: Float = 40.0
        var spaceRelatedToBottom: Float = -24.0 // 24 é o espaço entre o último botão e a base da containerView
        
        for action in actions.reversed() {
            let button = UIButton(type: .system)
            button.setTitle(action.title, for: .normal)
//            button.addTarget(self, action: <#T##Selector#>, for: .touchUpInside)
//            button.addAction(for: .touchUpInside) {
//                self.disableButtons()
//                button.touchAnimate { _ in
//                    self.enableButtons()
//                    UIApplication.shared.keyWindow?.windowLevel = UIWindow.Level.statusBar
//                    self.dismiss(animated: false) // de quem é a responsabilidade de fechar a tela?
//                    if let handler = action.handler {
//                        handler()
//                    }
//                }
//            }
//            
            buttons[button] = action.style
            
            canvasView.addSubview(button)
            
            setupButtonConstraints(for: button, relatedTo: canvasView, constant: spaceRelatedToBottom, with: buttonHeight)
            
            spaceRelatedToBottom -= 8.0 + buttonHeight // 8 é o espaço entre os botões
        }
        
        Array(buttons.keys).last?.topAnchor.constraint(greaterThanOrEqualTo: descriptionLabel.bottomAnchor, constant: 22).isActive = true
    }
    
    private func setupButtonConstraints(for button: UIButton, relatedTo view: UIView, constant value: Float, with height: Float) {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: CGFloat(value)).isActive = true
        button.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
    }
    
    private func setupConstraints() {
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        canvasView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        canvasView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        canvasView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: canvasView.topAnchor, constant: 21).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 133).isActive = true
        imageView.centerXAnchor.constraint(equalTo: canvasView.centerXAnchor).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 18).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: canvasView.leadingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: canvasView.trailingAnchor, constant: -16).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: canvasView.centerXAnchor).isActive = true
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 11).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: canvasView.leadingAnchor, constant: 16).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: canvasView.trailingAnchor, constant: -16).isActive = true
        descriptionLabel.centerXAnchor.constraint(equalTo: canvasView.centerXAnchor).isActive = true
    }
    
}

extension BookAlertController {
    
    func addAction(_ action: BookAlertAction) {
        actions.append(action)
    }
    
    func disableButtons() {
        buttons.keys.forEach { $0.isEnabled = false }
    }
    
    func enableButtons() {
        buttons.keys.forEach { $0.isEnabled = true }
    }
    
}

