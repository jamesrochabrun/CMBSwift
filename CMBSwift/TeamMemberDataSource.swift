//
//  TeamMemberDataSource.swift
//  CMBSwift
//
//  Created by James Rochabrun on 3/29/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import Foundation
import UIKit

class TeamMemberDataSource: NSObject, UITableViewDataSource {
    
    private var teamMember: TeamMember?
    private let numberOfFields: Int = 2
    
    override init() {
        super.init()
    }
    
    convenience init(teamMember: TeamMember) {
        self.init()
        self.teamMember = teamMember
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let teamMate = self.teamMember else {
            return BaseCell()
        }
        
        let teamModel = TeamViewModel(teamMember: teamMate)
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as MainCell
            cell.setCellWith(model: teamModel)
            return cell
        }
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as BioCell
        cell.displayBioInCell(using: teamModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfFields
    }
}
