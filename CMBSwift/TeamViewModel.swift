//
//  TeamViewModel.swift
//  CMBSwift
//
//  Created by James Rochabrun on 3/29/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import Foundation
import UIKit

struct TeamViewModel {
    
    var avatar: String?
    var bio: String?
    var firstName: String?
    var lastName: String?
    var fullName: String?
    var title: String?
    var id: String?
    
    init(teamMember: TeamMember) {
        
        self.avatar = teamMember.avatar
        self.bio = teamMember.bio
        self.firstName = teamMember.firstName
        self.lastName = teamMember.lastName
        self.title = teamMember.title
        if let firstName = self.firstName, let lastName = self.lastName {
            self.fullName = "\(firstName) \(lastName)"
        }
        self.id = teamMember.id
    }
}
