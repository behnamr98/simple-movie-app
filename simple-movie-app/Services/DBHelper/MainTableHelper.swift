//
//  MainTableHelper.swift
//  RodiniaWallet
//
//  Created by Behnam on 9/16/21.
//

import Foundation
import CoreData

class MainTableHelper {
    
    let persistenceManager: PersistenceManager
    fileprivate(set) var mainContextInstance: NSManagedObjectContext
    
    init() {
        self.persistenceManager = PersistenceManager.sharedInstance
        self.mainContextInstance = persistenceManager.getMainContextInstance()
    }
    
    func deleteEntity(tableName:String) {
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: tableName)
        let deleteReq = NSBatchDeleteRequest(fetchRequest: fetchReq)
        do {
            try mainContextInstance.execute(deleteReq)
            try mainContextInstance.save()
        } catch {
            print("error in delete entity \(tableName)")
        }
    }
}
