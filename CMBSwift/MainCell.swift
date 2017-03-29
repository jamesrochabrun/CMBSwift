//
//  MainCell.swift
//  CMBSwift
//
//  Created by James Rochabrun on 3/29/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import Foundation
import UIKit

class MainCell: TeamMemberCell {
    
    let dismissButton: CustomDismissButton = {
        let dbv = CustomDismissButton()
        return dbv
    }()
    
    override func setUPViews() {
        
        selectionStyle = .none
        backgroundColor = .clear
        addSubview(infoView)
        infoView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7).isActive = true
        infoView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        infoView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        infoView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7).isActive = true
        
        addSubview(dismissButton)
        dismissButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        dismissButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        dismissButton.heightAnchor.constraint(equalToConstant: Constants.UI.dismissButtonHeight).isActive = true
        dismissButton.widthAnchor.constraint(equalToConstant: Constants.UI.dismissButtonWidth).isActive = true
    }
    
    override func setCellWith(model: TeamViewModel) {
        infoView.teamMember = model
    }
}
