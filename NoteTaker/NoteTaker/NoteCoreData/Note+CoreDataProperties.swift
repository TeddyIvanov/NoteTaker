//
//  Note+CoreDataProperties.swift
//  NoteTaker
//
//  Created by Teodor Ivanov on 11/25/17.
//  Copyright © 2017 Teodor Ivanov. All rights reserved.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var title: String?
    @NSManaged public var body: String?

}
