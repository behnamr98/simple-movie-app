//
//  DetailsMovieViewController.swift
//  test
//
//  Created by Behnam on 12/21/21.
//  Copyright © 2021 Part DP. All rights reserved.
//

import UIKit
import Anchorage
import Kingfisher

class DetailsMovieViewController: BaseViewController {

    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
      
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private let firstStack:UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    
    private let rateStack:UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.spacing = 12
        stack.distribution = .fill
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
        label.textColor = .lightGrayText
        label.text = "5.6"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private let bookmarkButton:UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(
            pointSize: 20, weight: .regular, scale: .medium)
        button.setImage(UIImage(systemName: "bookmark", withConfiguration: config), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(bookmarkTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private let lineView:UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray.withAlphaComponent(0.25)
        return view
    }()
    
    private let bottomStackView:UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 12
        return stack
    }()
    
    private let titlesStack:UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        return stack
    }()
    
    private let valuesStack:UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        return stack
    }()
    
    private let rankTitleLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        label.text = "Rank"
        return label
    }()
    
    private let directorTitleLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        label.text = "Director"
        return label
    }()
    
    private let fullTitleTitleLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        label.text = "Full title"
        return label
    }()
    
    private let releaseTitleLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        label.text = "Release"
        return label
    }()
    
    private let rankLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .lightGrayText
        return label
    }()
    
    private let directorLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .lightGrayText
        return label
    }()
    
    private let fullTitleLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .lightGrayText
        return label
    }()
    
    private let releaseLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .lightGrayText
        return label
    }()
    
    private var viewModel:DetailsMovieViewModel!
    var model:MovieModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = DefaultDetailsMovieViewModel(movie: self.model, useCase: makeUseCase())
        bindViewModel()
        viewModel.viewDidLoad()
        setupMovie()
    }
    
    private func makeUseCase() -> MovieDBUseCase {
        return DefaultMovieDBUseCase(repository: makeRepository())
    }
    
    private func makeRepository() -> MoviesDBRepository {
        return DefaultMoviesDBRepository()
    }
    
    // MARK: - Actions
    
    @objc private func bookmarkTapped(_ sender:UIButton) {
        viewModel.bookmarkTapped()
    }

    private func setupMovie() {
        guard let movie = self.model else { return }
        titleLabel.text = movie.title
        rankLabel.text = "\(movie.rank)"
        rateLabel.text = "\(movie.imDbRating) - \(movie.imDbRatingCount.seprated) votes"
        directorLabel.text = movie.director
        fullTitleLabel.text = movie.fullTitle
        releaseLabel.text = "\(movie.year)"
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
    
    // MARK: - Main View Protocols
    
    override func configureView() {
        view.backgroundColor = .darkerGaryBack
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(firstStack)
        
        firstStack.addArrangedSubview(rateStack)
        firstStack.addArrangedSubview(UIView())
        firstStack.addArrangedSubview(bookmarkButton)
        
        rateStack.addArrangedSubview(rateImageView)
        rateStack.addArrangedSubview(rateLabel)
        
        view.addSubview(lineView)
        
        view.addSubview(bottomStackView)
        bottomStackView.addArrangedSubview(titlesStack)
        bottomStackView.addArrangedSubview(valuesStack)
        
        titlesStack.addArrangedSubview(rankTitleLabel)
        titlesStack.addArrangedSubview(directorTitleLabel)
        titlesStack.addArrangedSubview(fullTitleTitleLabel)
        titlesStack.addArrangedSubview(releaseTitleLabel)
        
        valuesStack.addArrangedSubview(rankLabel)
        valuesStack.addArrangedSubview(directorLabel)
        valuesStack.addArrangedSubview(fullTitleLabel)
        valuesStack.addArrangedSubview(releaseLabel)
    }

    override func configureLayout() {
        imageView.topAnchor == view.topAnchor
        imageView.horizontalAnchors == view.horizontalAnchors
        imageView.heightAnchor == view.heightAnchor/2.2
        
        titleLabel.topAnchor == imageView.bottomAnchor + 24
        titleLabel.horizontalAnchors == view.horizontalAnchors + 16
        
        firstStack.horizontalAnchors == view.horizontalAnchors + 16
        firstStack.topAnchor == titleLabel.bottomAnchor + 12
        
        lineView.horizontalAnchors == view.horizontalAnchors
        lineView.topAnchor == firstStack.bottomAnchor + 32
        lineView.heightAnchor == 0.5
        
        bottomStackView.horizontalAnchors == firstStack.horizontalAnchors
        bottomStackView.topAnchor == lineView.bottomAnchor + 24
        
        titlesStack.widthAnchor == 80
    }
    
    
    // MARK: - Initilize

    private func bindViewModel() {
        viewModel.observeBookmarkState = { isMarked in
            let imageName = isMarked ? "bookmark.fill" : "bookmark"
            self.bookmarkButton.setImage(UIImage(systemName: imageName)!, for: .normal)
        }
    }
}
