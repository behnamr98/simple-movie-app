//
//  ProfileVIewModel.swift
//  test
//
//  Created by Behnam on 12/21/21.
//

import Foundation

protocol ProfileViewModel:MainViewModel {
    
    func getItemsCount() -> Int
    func getItem(index:IndexPath) -> ProfileItem
    
}


final class DefaultProfileViewModel: ProfileViewModel {
    
    private var items:[ProfileItem] = []
    
    func viewDidLoad() {
        
        self.items = getListItems()
    }
    
    
    // MARK: - Private Functions
    
    private func getListItems() -> [ProfileItem] {
        var items = [ProfileItem]()
        items.append(
            ProfileItem(title: "Login or Signup", image: "person.crop.square.fill")
        )
        items.append(
            ProfileItem(title: "Bookmarks", image: "bookmark.square.fill")
        )
        items.append(
            ProfileItem(title: "Settings", image: "gearshape.fill")
        )
        
        return items
    }
    
    
    // MARK: - Protocol Fucntions
    
    func getItemsCount() -> Int { items.count }
    
    func getItem(index:IndexPath) -> ProfileItem {
        items[index.row]
    }
}

