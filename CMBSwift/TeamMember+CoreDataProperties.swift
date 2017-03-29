//
//  TeamMember+CoreDataProperties.swift
//  CMBSwift
//
//  Created by James Rochabrun on 3/28/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import Foundation
import CoreData


extension TeamMember {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TeamMember> {
        return NSFetchRequest<TeamMember>(entityName: "TeamMember");
    }

    @NSManaged public var avatar: String?
    @NSManaged public var bio: String?
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var title: String?
    @NSManaged public var id: String?
    
    static func createTeamMemberFrom(_ dictionary: [String: String]) -> TeamMember? {
        
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        if let teamMemberEntity = NSEntityDescription.insertNewObject(forEntityName: String(describing: TeamMember.self), into: context) as? TeamMember {
            teamMemberEntity.avatar = dictionary[Key.avatar]
            teamMemberEntity.bio = dictionary[Key.bio]
            teamMemberEntity.firstName = dictionary[Key.firstName]
            teamMemberEntity.lastName = dictionary[Key.lastName]
            teamMemberEntity.title = dictionary[Key.title]
            teamMemberEntity.id = dictionary[Key.id]
            return teamMemberEntity
        }
        return nil
    }
}


fileprivate struct Key {
    static let avatar = "avatar"
    static let bio = "bio"
    static let firstName = "firstName"
    static let lastName = "lastName"
    static let title = "title"
    static let id = "id"
}


