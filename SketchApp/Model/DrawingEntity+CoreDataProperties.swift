//
//  DrawingEntity+CoreDataProperties.swift
//  SketchApp
//
//  Created by 김문옥 on 2021/07/11.
//
//

import Foundation
import CoreData


extension DrawingEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DrawingEntity> {
        return NSFetchRequest<DrawingEntity>(entityName: "DrawingEntity")
    }

    @NSManaged public var drawingData: Data
    @NSManaged public var savingTime: Date

}

extension DrawingEntity : Identifiable {

}
