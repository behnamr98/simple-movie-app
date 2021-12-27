//
//  CustomCollectionView.swift
//  test
//
//  Created by Behnam on 12/22/21.
//  Copyright © 2021 Part DP. All rights reserved.
//

import UIKit
import Anchorage


class CustomCollectionView: UICollectionView {

    var spinner = UIActivityIndicatorView()
    
    var isLoading: Bool = false {
        didSet {
            isLoading ?  spinner.startAnimating() : spinner.stopAnimating()
        }
    }

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        setupSpinner()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupSpinner()
    }
    
    func setupSpinner(){
        spinner.color = .darkRed
        spinner.style = .medium
        spinner.hidesWhenStopped = true
        
        self.addSubview(spinner)
        
        spinner.heightAnchor == 100
        spinner.widthAnchor == 100 //CGSize(width: 120, height: 120)
        spinner.centerAnchors == self.centerAnchors
    }
}
