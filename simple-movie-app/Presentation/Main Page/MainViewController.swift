//
//  MainViewController.swift
//  test
//
//  Created by Behnam on 12/19/21.
//

protocol MainView {
    
    func configureView()
    func configureLayout()
}

import UIKit
import Anchorage

class MainViewController: BaseViewController {
    
    let searchBar:UITextField = {
        let searchBar = UITextField()
        searchBar.layer.cornerRadius = 14
        searchBar.backgroundColor = .white.withAlphaComponent(0.4)
        searchBar.placeholder = "Search"
        searchBar.isHidden = true
        return searchBar
    }()
    
    let coverView:UIView = {
        let view = UIView()
        view.backgroundColor = .darkGaryBack
        view.layer.cornerRadius = 25
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    let scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        return scrollView
    }()
   
    let baseView = UIView()
    
    let mainStack:UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 24
        return stack
    }()
    
    let popularCollectionView:CustomCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140,height: 250)
        let collection = CustomCollectionView(frame: .zero, collectionViewLayout: layout)
        collection.collectionViewLayout = layout
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .clear
        collection.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        collection.register(MovieCollectionViewCell.self)
        return collection
    }()
    
    let topCollectionView:CustomCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140,height: 250)
        let collection = CustomCollectionView(frame: .zero, collectionViewLayout: layout)
        collection.collectionViewLayout = layout
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .clear
        collection.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        collection.register(MovieCollectionViewCell.self)
        return collection
    }()
    
    let soonCollectionView:CustomCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140,height: 250)
        let collection = CustomCollectionView(frame: .zero, collectionViewLayout: layout)
        collection.collectionViewLayout = layout
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .clear
        collection.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        collection.register(MovieCollectionViewCell.self)
        return collection
    }()
    
    private let popularHeaderView = HeaderView()
    private let topHeaderView = HeaderView()
    private let soonHeaderView = HeaderView()
    
    private var viewModel:MainPageViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = DefaultMainPageViewModel(useCase: makeUseCase())
        bindViewModel()
        viewModel.viewDidLoad()
        
        popularHeaderView.create(title: "Most Popular", buttonTitle: "See All")
        topHeaderView.create(title: "Top 250 Movies", buttonTitle: "See All")
        soonHeaderView.create(title: "Coming Soon", buttonTitle: "See All")
        
        popularHeaderView.buttonTapped = {
            let vc = DetailsMovieViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }

    }
    
    private func makeUseCase() -> MovieUseCase {
        return DefaultMovieUseCase(repository: makeFetchMovieRepository())
    }
    
    private func makeFetchMovieRepository() -> FetchMovieRepository {
        return DefaultFetchMovieRepository(service: DefaultWebService())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //navigationController?.setNavigationBarHidden(false, animated: true)
        title = "Movies"
        
        config(collectionView: popularCollectionView)
        config(collectionView: topCollectionView)
        config(collectionView: soonCollectionView)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    // MARK: - Main View Protocols
    
    override func configureView() {
        view.backgroundColor = .background
        view.addSubview(searchBar)
        view.addSubview(coverView)
        
        coverView.addSubview(scrollView)
        scrollView.addSubview(baseView)
        
        baseView.addSubview(mainStack)
        
        mainStack.addArrangedSubview(popularHeaderView)
        mainStack.addArrangedSubview(popularCollectionView)
        mainStack.addArrangedSubview(topHeaderView)
        mainStack.addArrangedSubview(topCollectionView)
        mainStack.addArrangedSubview(soonHeaderView)
        mainStack.addArrangedSubview(soonCollectionView)
    }

    override func configureLayout() {
        searchBar.horizontalAnchors == view.horizontalAnchors + 16
        searchBar.topAnchor == view.topAnchor + 44
        searchBar.heightAnchor == 36
        
        let insetsScrollView = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
        coverView.edgeAnchors == view.edgeAnchors + insetsScrollView
        
        scrollView.edgeAnchors == coverView.edgeAnchors
        
        baseView.edgeAnchors == scrollView.edgeAnchors
        baseView.widthAnchor == view.widthAnchor
        
        let insetsMainStack = UIEdgeInsets(top: 24, left: 0, bottom: 40, right: 0)
        mainStack.edgeAnchors == baseView.edgeAnchors + insetsMainStack
        
        configHeaderLayout(popularHeaderView, mainStack)
        
        
        configCollectionLayout(popularCollectionView, mainStack)
        configHeaderLayout(topHeaderView, mainStack)
        configCollectionLayout(topCollectionView, mainStack)
        
        configHeaderLayout(soonHeaderView, mainStack)
        configCollectionLayout(soonCollectionView, mainStack)
    }
    
    private func configHeaderLayout(_ headerView:HeaderView,_ stack:UIStackView) {
        headerView.heightAnchor == 40
        headerView.horizontalAnchors == stack.horizontalAnchors + 16
    }
    
    private func configCollectionLayout(_ collectionView:UICollectionView,_ stack:UIStackView) {
        collectionView.horizontalAnchors == stack.horizontalAnchors
        collectionView.heightAnchor ==  250
    }
    
    // MARK: - Initilize
    
    private func config(collectionView: UICollectionView) {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func bindViewModel() {
        viewModel.observeError = { error in
            print(error.localizedDescription)
            LocalNotification(title: error.localizedDescription).present()
        }
        
        viewModel.loading = { [weak self] section, status in
            switch section {
            case .popular: self?.popularCollectionView.isLoading = status
            case .top: self?.topCollectionView.isLoading = status
            case .comingSoon: self?.soonCollectionView.isLoading = status
            }
            print("Loading -> \(section)\(status ? "✅" : "❌")")
        }
        
        viewModel.updateList = { [weak self] section in
            switch section {
            case .popular: self?.popularCollectionView.reloadData()
            case .top: self?.topCollectionView.reloadData()
            case .comingSoon: self?.soonCollectionView.reloadData()
            }
        }
    }

    func getSection(_ collection:UICollectionView) -> MovieSection {
        if collection == popularCollectionView {
            return .popular
        } else if collection == topCollectionView {
            return .top
        }
        return .comingSoon
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getMoviesCount(section: getSection(collectionView))
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:MovieCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        
        cell.config(viewModel.getMovie(
            section: getSection(collectionView),
            index: indexPath)
        )
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailsMovieViewController()
        vc.model = viewModel.getMovie(section: getSection(collectionView), index: indexPath)
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
