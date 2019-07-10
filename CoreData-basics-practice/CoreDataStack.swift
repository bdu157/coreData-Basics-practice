//
//  CoreDataStack.swift
//  CoreData-basics-practice
//
//  Created by Dongwoo Pae on 7/9/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    static let shared = CoreDataStack()
    
    let container: NSPersistentContainer
    let mainContext: NSManagedObjectContext
    
    init() {
        /*
         old way
         1.managedObjectModel
         2.PersistentStoreCoordinator
         3.add a persistent store
         4.create our context
         */
//        guard let managedObjectModel = NSManagedObjectModel.mergedModel(from: nil) else {
//            fatalError("Cannot find a model to load")
//        }
//
//        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
//        let documentFolder = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
//        let datastoreFile = documentFolder.appendingPathComponent("tasks.db")
//        _ = try! persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: datastoreFile, options: nil)
//        let mainContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
//        mainContext.persistentStoreCoordinator = persistentStoreCoordinator
        
        
        //alternative way with NSPersistentStore container
        container = NSPersistentContainer(name: "Tasks")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Could not load the data store: \(error)")
            } else {
                print("\(description)")
            }
        }
        mainContext = container.viewContext
    }
}
