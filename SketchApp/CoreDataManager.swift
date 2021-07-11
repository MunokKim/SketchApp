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
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private let entity: NSEntityDescription
    private let managedObject: NSManagedObject
    
    private override init() {
        let entity = NSEntityDescription.entity(forEntityName: "DrawingEntity", in: context)!
        
        self.entity = entity
        self.managedObject = NSManagedObject(entity: entity, insertInto: context)
        
        super.init()
    }
    
    public func save(withData drawingData: Data, completion: @escaping (Error?) -> ()) {
        managedObject.setValue(UUID(), forKey: "uuid")
        managedObject.setValue(drawingData, forKey: "data")
        managedObject.setValue(Date(), forKey: "savingTime")
        
        do {
            try context.save()
            completion(nil)
        } catch {
            print(error.localizedDescription)
            completion(error)
        }
    }
    
    public func load() -> [DrawingModel] {
        return []
    }
}
