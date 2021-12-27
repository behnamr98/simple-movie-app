//
//  UITableView+EX.swift
//  test
//
//  Created by Behnam on 12/21/21.
//

import UIKit

extension UITableView {
    
    func register<T: UITableViewCell>(_: T.Type){
        register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T
        else { fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)") }
        return cell
    }
    
    
}
