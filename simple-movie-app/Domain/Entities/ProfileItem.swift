//
//  ProfileItem.swift
//  test
//
//  Created by Behnam on 12/21/21.
//

import Foundation
import UIKit


struct ProfileItem {
    
    let title:String
    let image:UIImage
    
    init(title:String, image:String) {
        self.title = title
        self.image = UIImage(systemName: image)!
    }
}
