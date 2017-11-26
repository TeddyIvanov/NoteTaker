//
//  Note+CoreDataClass.swift
//  NoteTaker
//
//  Created by Teodor Ivanov on 11/25/17.
//  Copyright © 2017 Teodor Ivanov. All rights reserved.
//
//

import Foundation
import UIKit
import CoreData

@objc(Note)
public class Note: NSManagedObject {
    
    convenience init?(title: String?, body: String?) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            return nil
        }
        self.init(entity: Note.entity(), insertInto: managedContext)
        self.title = title
        self.body = body
    }
}
