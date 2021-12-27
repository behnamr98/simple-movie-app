//
//  BookmarkListViewController.swift
//  test
//
//  Created by Behnam on 12/22/21.
//  Copyright © 2021 Part DP. All rights reserved.
//

import UIKit
import Anchorage

class BookmarkListViewController: BaseViewController {

    
    private let tableView:UITableView = {
        let tableView = UITableView()
        tableView.register(MovieTableViewCell.self)
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    private var viewModel:BookmarkListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Bookmarks"

        initTableView()
        viewModel = DefaultBookmarkListViewModel(useCase: makeUseCase())
        bindViewModel()
    }
    
    private func makeUseCase() -> MovieDBUseCase {
        return DefaultMovieDBUseCase(repository: makeRepository())
    }
    
    private func makeRepository() -> MoviesDBRepository {
        return DefaultMoviesDBRepository()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.viewWillAppear()
    }
    
    // MARK: - Actions

    
    // MARK: - Main View Protocols
    
    override func configureView() {
        view.addSubview(tableView)
        
    }
    
    override func configureLayout() {
        tableView.edgeAnchors == view.edgeAnchors
    }
    
    // MARK: - Initilize
    
    private func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func bindViewModel() {
        viewModel.updateList = {
            self.tableView.reloadData()
        }
    }
    
}

extension BookmarkListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getBookmarksCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MovieTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        
        cell.config(movie: viewModel.getBookmark(indexPath))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailsMovieViewController()
        vc.model = viewModel.getBookmark(indexPath).toDomain()
        navigationController?.pushViewController(vc, animated: true)
    }
}
