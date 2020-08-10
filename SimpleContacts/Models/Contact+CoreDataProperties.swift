//
//  Contact+CoreDataProperties.swift
//  SimpleContacts
//
//  Created by Nate Lee on 8/10/20.
//  Copyright © 2020 Nate Lee. All rights reserved.
//
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var imageId: UUID?
    @NSManaged public var name: String?

    public var wrappedName: String {
        name ?? "Unknown Name"
    }
}
