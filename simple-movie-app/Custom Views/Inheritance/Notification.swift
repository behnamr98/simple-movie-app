//
//  Notification.swift
//  RodiniaWallet
//
//  Created by Behnam on 7/19/21.
//

import Foundation
import UIKit
import Anchorage

class LocalNotification {
    
    struct NotificationModel {
        let title:String
        let body:String
    }
    
    private let model:NotificationModel
    
    
    init(title:String) {
        self.model = NotificationModel(title: title, body: "")
    }
    
    init(title:String, body:String) {
        self.model = NotificationModel(title: title, body: body)
    }
    
    init(model:NotificationModel) {
        self.model = model
    }
    
    var topConstraint:NSLayoutConstraint!
    var view:UIView!
    var stackView:UIStackView!
    var title:UILabel!
    var body:UILabel!
    var vc:UIViewController!
    
    func present() {
        guard let rootvc = AppDelegate.shared.window?.rootViewController else {
            return
        }
        guard let presenter = rootvc.topViewController() else {
            return
        }
        
        view = baseView()
        stackView = makeStackView()
        title = titleLabel(text: model.title)
        body = bodyLabel(text: model.body)
        
        vc = presenter.tabBarController ?? presenter.navigationController ?? presenter
        vc.view.addSubview(view)
        view.addSubview(stackView)
        stackView.addArrangedSubview(title)
        stackView.addArrangedSubview(body)
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.panGestureRegongnizer(_:))))
        
        topConstraint = view.bottomAnchor.constraint(equalTo: vc.view.topAnchor, constant: -80)
        
        NSLayoutConstraint.activate(
            [topConstraint,
             view.heightAnchor.constraint(equalToConstant: 40),
             view.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor, constant: 16),
             view.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor, constant: -16)]
        )
        
        NSLayoutConstraint.activate(
            [stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
             stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
             stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
             stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)]
        )
        
        
        title.isHidden = model.title.isEmpty
        body.isHidden = model.body.isEmpty
        
        topConstraint.constant = 100
        UIView.animate(withDuration: 0.3) {
            //view.alpha = 1
            self.vc.view.layoutIfNeeded()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+5.0) {
            self.removeNotification()
        }
    }
    
    private func removeNotification() {
        topConstraint.constant = -60
        UIView.animate(withDuration: 0.3) {
            self.vc.view.layoutIfNeeded()
        } completion: { _ in
            self.body.removeFromSuperview()
            self.title.removeFromSuperview()
            self.stackView.removeFromSuperview()
            self.view.removeFromSuperview()
        }
    }
    
    @objc func panGestureRegongnizer(_ gesture:UIPanGestureRecognizer) {
        if gesture.state == .changed {
            let translation = gesture.translation(in: view)
            if translation.y < 0 {
                let trans = CGAffineTransform(translationX: 0, y: translation.y)
                view.transform = trans
            }
        } else if gesture.state == .ended {
            let y = view.transform.ty
            if y > -10 {
                view.transform = .identity
            } else {
                removeNotification()
            }
        }
    }
    
    
    private func baseView() -> UIView {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.alpha = 1
        view.clipsToBounds = true
        view.layer.cornerRadius = 14
        return view
    }
    
    private func makeStackView() -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fill
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 8
        return stack
    }
    
    private func titleLabel(text:String) -> UILabel {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = text
        title.numberOfLines = 0
        title.font = .systemFont(ofSize: 14)
        title.textColor = .darkText
        return title
    }
    
    private func bodyLabel(text:String) -> UILabel {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = text
        title.numberOfLines = 0
        title.font = .systemFont(ofSize: 12)
        title.textColor = .lightGrayText
        return title
    }
    
    private func iconImageView(image:UIImage)-> UIImageView  {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.image = image
        return icon
    }
}
