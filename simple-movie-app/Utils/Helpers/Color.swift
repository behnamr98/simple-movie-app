//
//  Color.swift
//  test
//
//  Created by Behnam on 12/19/21.
//

import UIKit


extension UIColor {
    
    static let lightGrayText:UIColor = #colorLiteral(red: 0.415831089, green: 0.4559647441, blue: 0.4953870773, alpha: 1)
    static let darkGaryBack:UIColor = #colorLiteral(red: 0.1724646688, green: 0.2236852348, blue: 0.2859599292, alpha: 1)
    static let darkerGaryBack:UIColor = #colorLiteral(red: 0.1882352941, green: 0.1882352941, blue: 0.1882352941, alpha: 1)
    static let whiteText:UIColor = .white
    static let background:UIColor = #colorLiteral(red: 0.2063242594, green: 0.2497031283, blue: 0.572568621, alpha: 1)
    static let yellow = #colorLiteral(red: 0.9932717681, green: 0.8276680112, blue: 0.03543454036, alpha: 1)
    static let darkRed = #colorLiteral(red: 0.9593196511, green: 0.4359480739, blue: 0.4239535034, alpha: 1)
    
    
    public class func dynamicColor(light: UIColor, dark:UIColor) -> UIColor {
        return UIColor {
            switch $0.userInterfaceStyle {
            case .dark:
                return dark
            default:
                return light
            }
        }
    }
    
}
