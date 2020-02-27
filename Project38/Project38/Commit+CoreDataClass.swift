//
//  Commit+CoreDataClass.swift
//  Project38
//
//  Created by Mohammed Hamdi on 10/7/19.
//  Copyright © 2019 Mohammed Hamdi. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Commit)
public class Commit: NSManagedObject {
    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
        print("Init called!")
    }
}
