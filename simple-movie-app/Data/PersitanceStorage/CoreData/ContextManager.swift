//
//  ContextManager.swift
//  CoreDataCRUD
//
//  Created by Behnam on 12/22/21.
//  Copyright © 2021 Part DP. All rights reserved.
//

import Foundation
import CoreData

/**
    The Context Manager that will manage the merging of child contexts with Master ManagedObjectContext
*/
class ContextManager: NSObject {

    let datastore: DatastoreCoordinator!

    override init() {
        self.datastore = AppDelegate.shared.datastoreCoordinator
        super.init()
    }

    // Create master context reference, with PrivateQueueConcurrency Type.
    lazy var masterManagedObjectContextInstance: NSManagedObjectContext = {
        var masterManagedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        masterManagedObjectContext.persistentStoreCoordinator = self.datastore.persistentStoreCoordinator

        return masterManagedObjectContext
    }()

    //Create main context reference, with MainQueueuConcurrency Type.
    lazy var mainManagedObjectContextInstance: NSManagedObjectContext = {
        var mainManagedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        mainManagedObjectContext.persistentStoreCoordinator = self.datastore.persistentStoreCoordinator

        return mainManagedObjectContext
    }()

    // MARK: - Core Data Saving support

    /**
        Saves changes from the Main Context to the Master Managed Object Context.
    
        - Returns: Void
    */
    func saveContext() {
        defer {
            do {
                try masterManagedObjectContextInstance.save()
            } catch let masterMocSaveError as NSError {
                print("Master Managed Object Context save error: \(masterMocSaveError.localizedDescription)")
            } catch {
                print("Master Managed Object Context save error.")
            }
        }

        if mainManagedObjectContextInstance.hasChanges {
            mergeChangesFromMainContext()
        }
    }

    /**
        Merge Changes on the Main Context to the Master Context.
    
        - Returns: Void
    */
    fileprivate func mergeChangesFromMainContext() {
        DispatchQueue.main.async(execute: {
            do {
                try self.mainManagedObjectContextInstance.save()
            } catch let mocSaveError as NSError {
                print("Master Managed Object Context error: \(mocSaveError.localizedDescription)")
            }
        })
    }

}

extension NSManagedObjectContext {
    
    func getLastId(table:String, attribute:String)-> Int32 {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: table)
        fetchRequest.fetchLimit = 1
        
        let sortDescriptor = NSSortDescriptor(key: attribute, ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            let items = try self.fetch(fetchRequest)
            if let max = items.first {
                if let lastId = max.value(forKey: attribute) as? Int32 {
                    return lastId + 1
                }
                return 0
            }
        } catch let error as NSError {
            debugPrint("Could not fetch. \(error), \(error.userInfo)")
        }
        return 0
    }
    
}
