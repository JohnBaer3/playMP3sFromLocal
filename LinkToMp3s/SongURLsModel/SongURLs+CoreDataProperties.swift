//
//  SongURLs+CoreDataProperties.swift
//  
//
//  Created by John Baer on 8/31/20.
//
//

import Foundation
import CoreData


extension SongURLs {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SongURLs> {
        return NSFetchRequest<SongURLs>(entityName: "SongURLs")
    }

    @NSManaged public var songURL: String?
    @NSManaged public var songBPM: String?

}
