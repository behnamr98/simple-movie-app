//
//  UIViewController + EX.swift
//  test
//
//  Created by Behnam on 12/21/21.
//  Copyright © 2021 Part DP. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func topViewController() -> UIViewController! {
        if self.isKind(of: UITabBarController.self) {
            let tabbarController =  self as! UITabBarController
            return tabbarController.selectedViewController!.topViewController()
        } else if (self.isKind(of: UINavigationController.self)) {
            let navigationController = self as! UINavigationController
            return navigationController.visibleViewController!.topViewController()
        } else if ((self.presentedViewController) != nil){
            let controller = self.presentedViewController
            return controller!.topViewController()
        }
        return self
    }
}
