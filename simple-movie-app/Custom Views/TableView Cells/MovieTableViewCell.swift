//
//  MovieTableViewCell.swift
//  test
//
//  Created by Behnam on 12/22/21.
//  Copyright © 2021 Part DP. All rights reserved.
//

import UIKit
import Anchorage
import Kingfisher

class MovieTableViewCell: UITableViewCell {

    private let backImageView:UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        return image
    }()
    
    private let coverView:UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.25)
        view.clipsToBounds = true
        return view
    }()
    
    private let bottomView:UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.8)
        return view
    }()
    
    private let bottomStack:UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.distribution = .fill
        stack.alignment = .fill
        return stack
    }()
    
    private let titleLabel:UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let releaseLabel:UILabel = {
        let label = UILabel()
        label.textColor = .lightText
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    func config(movie:Movie) {
        titleLabel.text = movie.title
        releaseLabel.text = "\(movie.year)"
        backImageView.image = UIImage(named: "movie-placeholder")
        
        guard let url = URL(string: movie.image ?? "") else { return }
        backImageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "movie-placeholder"),
            options: [
                .transition(.fade(0.3)),
                .cacheOriginalImage
            ]
        )
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureView()
        configureLayout()
    }
    
}

extension MovieTableViewCell {
    
    private func configureView() {
        addSubview(backImageView)
        addSubview(coverView)
        addSubview(bottomView)
        bottomView.addSubview(bottomStack)
        
        bottomStack.addArrangedSubview(titleLabel)
        bottomStack.addArrangedSubview(releaseLabel)
    }
    
    private func configureLayout() {
        backImageView.edgeAnchors == self.edgeAnchors
        coverView.edgeAnchors == backImageView.edgeAnchors
        
        bottomView.bottomAnchor == self.bottomAnchor
        bottomView.horizontalAnchors == self.horizontalAnchors
        
        bottomStack.verticalAnchors == bottomView.verticalAnchors + 10
        bottomStack.horizontalAnchors == bottomView.horizontalAnchors + 16
        
    }
    
}
