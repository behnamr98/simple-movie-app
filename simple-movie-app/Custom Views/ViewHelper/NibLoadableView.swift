//
//  NibLoadableView.swift
//  RodiniaWallet
//
//  Created by Babak Afsheh on 2/24/21.
//

import UIKit

protocol NibLoadableView: AnyObject { }

extension NibLoadableView where Self: UIView {

    static var nibName: String {
        return String(describing: self)
    }

}

extension UITableViewCell: NibLoadableView { }

