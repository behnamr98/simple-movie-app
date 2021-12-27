//
//  ProfileViewController.swift
//  test
//
//  Created by Behnam on 12/20/21.
//

import UIKit
import Anchorage


class ProfileViewController: BaseViewController {

    private let topStack:UIStackView =  {
        let stack = UIStackView()
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 12
        stack.axis = .vertical
        return stack
    }()
    
    private let profileImageView:UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "placeholder")
        image.layer.borderWidth = 4
        image.layer.borderColor = UIColor.darkerGaryBack.cgColor
        return image
    }()
    
    private let nameLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .lightGrayText
        label.text = "No login info"
        return label
    }()
    
    private let roleLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .darkRed
        label.text = "No role detected"
        return label
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray.withAlphaComponent(0.25)
        return view
    }()
    
    private let tableView:UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self)
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        tableView.separatorColor = .lightGray.withAlphaComponent(0.25)
        tableView.separatorInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        return tableView
    }()
    
    private var viewModel:ProfileViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        
        viewModel = DefaultProfileViewModel()
        viewModel.viewDidLoad()
        config(tableView: tableView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        profileImageView.layer.cornerRadius = 140/2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: - Main View Protocols
    
    override func configureView() {
        view.backgroundColor = .darkGaryBack
        view.addSubview(topStack)
        topStack.addArrangedSubview(profileImageView)
        topStack.addArrangedSubview(nameLabel)
        topStack.addArrangedSubview(roleLabel)
        
        view.addSubview(lineView)
        view.addSubview(tableView)
    }
    
    override func configureLayout() {
        topStack.topAnchor == view.topAnchor + 110
        topStack.horizontalAnchors == view.horizontalAnchors
        
        profileImageView.heightAnchor == 140
        profileImageView.widthAnchor == profileImageView.heightAnchor
        
        lineView.heightAnchor == 0.5
        lineView.horizontalAnchors == view.horizontalAnchors
        lineView.topAnchor == topStack.bottomAnchor + 35
        
        tableView.topAnchor == lineView.bottomAnchor
        tableView.horizontalAnchors == view.horizontalAnchors
        tableView.bottomAnchor == view.bottomAnchor
    }

    // MARK: - Initilize
    
    func config(tableView:UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getItemsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath)
        config(
            cell: cell,
            item: viewModel.getItem(index: indexPath)
        )
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            let vc = BookmarkListViewController()
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    private func config(cell:UITableViewCell,item: ProfileItem) {
        cell.backgroundColor = .clear
        cell.tintColor = .darkRed
        cell.imageView?.image = item.image
        cell.textLabel?.text = item.title
        cell.textLabel?.textColor = .whiteText
        cell.selectionStyle = .none
    }
}
