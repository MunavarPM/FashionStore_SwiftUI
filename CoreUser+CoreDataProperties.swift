//
//  CoreUser+CoreDataProperties.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 07/01/24.
//
//

import Foundation
import CoreData


extension CoreUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreUser> {
        return NSFetchRequest<CoreUser>(entityName: "CoreUser")
    }

    @NSManaged public var image: Data?

}

extension CoreUser : Identifiable {

}
