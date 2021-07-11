//
//  CoreDataManager.swift
//  SketchApp
//
//  Created by 김문옥 on 2021/07/11.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {
    public static let shared = CoreDataManager()
    
    private var context: NSManagedObjectContext { persistentContainer.viewContext }
    
    private lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "SketchApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    public func save(withData drawingData: Data, completion: @escaping (Error?) -> ()) {
        guard let entity = NSEntityDescription.entity(forEntityName: "DrawingEntity", in: self.context)
        else { fatalError("Couldn't found entity") }
        let managedObject = NSManagedObject(entity: entity, insertInto: context)
        managedObject.setValue(drawingData, forKey: "drawingData")
        managedObject.setValue(Date(), forKey: "savingTime")
        
        do {
            try context.save()
            completion(nil)
        } catch {
            print(error.localizedDescription)
            completion(error)
        }
    }
    
    public func load() -> [DrawingModel]? {
        do {
            let drawings = try context.fetch(DrawingEntity.fetchRequest()) as! [DrawingEntity]
            return drawings.map { DrawingModel(drawingData: $0.drawingData, savingTime: $0.savingTime) }
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
}
