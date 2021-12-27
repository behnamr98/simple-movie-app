//
//  MovieCollectionViewCell.swift
//  test
//
//  Created by Behnam on 12/20/21.
//

import UIKit
import Anchorage
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Views
    
    let mainStack:UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 12
        stack.alignment = .fill
        return stack
    }()
    
    let imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    let rateStack:UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .fill
        return stack
    }()
    
    let rateImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .yellow
        return imageView
    }()
    
    let rateLabel:UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "5.6"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    func config(_ movie:MovieModel) {
        titleLabel.text = movie.title
        rateLabel.text = "  \(movie.imDbRating)"
        self.imageView.image = UIImage(named: "movie-placeholder")
        
        guard let url = URL(string: movie.image) else { return }
        imageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "movie-placeholder"),
            options: [
                .transition(.fade(0.3)),
                .cacheOriginalImage
            ]
        )
    }
 
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configureView()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureView()
        configureLayout()
    }
    
}

private extension MovieCollectionViewCell {
    
    // MARK: - Configure Views
    
    func configureView() {
        contentView.addSubview(mainStack)
        
        mainStack.addArrangedSubview(imageView)
        mainStack.addArrangedSubview(titleLabel)
        mainStack.addArrangedSubview(rateStack)
        
        rateStack.addArrangedSubview(rateImageView)
        rateStack.addArrangedSubview(rateLabel)
        
    }

    func configureLayout() {
        mainStack.edgeAnchors == contentView.edgeAnchors
        titleLabel.heightAnchor == 18
        rateStack.heightAnchor == 18
        
    }
}
