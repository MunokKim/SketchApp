//
//  DrawingEntity+CoreDataProperties.swift
//  SketchApp
//
//  Created by 김문옥 on 2021/07/12.
//
//

import Foundation
import CoreData


extension DrawingEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DrawingEntity> {
        return NSFetchRequest<DrawingEntity>(entityName: "DrawingEntity")
    }

    @NSManaged public var savingTime: Date
    @NSManaged public var drawingData: Data

}

extension DrawingEntity : Identifiable {

}
