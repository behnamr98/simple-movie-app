//
//  MainView.swift
//  test
//
//  Created by Behnam on 12/19/21.
//


import UIKit
import Anchorage

class HeaderView:UIView {
    
    // MARK: - Views
    
    private let stackView:UIStackView = {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        return stack
    }()

    private let titleLabel:UILabel = {
        let label = UILabel()
        label.text = "Most Popular"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .whiteText
        return label
    }()
    
    private let seeButton:UIButton = {
        let button = UIButton()
        button.setTitle("See All", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.contentHorizontalAlignment = .right
        button.setTitleColor(.lightGrayText, for: .normal)
        button.isHidden = true
        return button
    }()
    
    
    var buttonTapped: (() ->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func create(title:String, buttonTitle:String) {
        titleLabel.text = title
        seeButton.setTitle(buttonTitle, for: .normal)
    }
    
    @objc
    func seeButtonTapped(_ sender:UIButton) {
        print(#function)
        buttonTapped?()
    }
    
    // MARK: - Config Views
    
    private func configureView() {
        self.addSubview(stackView)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(UIView())
        stackView.addArrangedSubview(seeButton)
        
        seeButton.addTarget(self, action: #selector(seeButtonTapped(_:)), for: .touchUpInside)
    }
    
    private func configureLayout() {
        stackView.edgeAnchors == self.edgeAnchors
    }
    
    
}
