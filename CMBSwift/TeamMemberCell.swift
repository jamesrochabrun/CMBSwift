//
//  TeamMemberCell.swift
//  CMBSwift
//
//  Created by James Rochabrun on 3/28/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import Foundation
import UIKit

class TeamMemberCell: BaseCell {
    
    let backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.blur(with: .light)
        iv.opaque(with: Constants.Colors.backGroundColor, alpha: 0.2)
        return iv
    }()
        
    let infoView: InfoView = {
        let iv = InfoView()
        return iv
    }()
    
    override func setUPViews() {
        
        selectionStyle = .none

        addSubview(backgroundImageView)
        backgroundImageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        backgroundImageView.heightAnchor.constraint(equalTo: widthAnchor).isActive = true
        backgroundImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        backgroundImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        addSubview(infoView)
        infoView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7).isActive = true
        infoView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        infoView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        infoView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7).isActive = true
    }
    
    func setCellWith(model: TeamViewModel) {
        infoView.teamMember = model
        if let avatar = model.avatar {
            backgroundImageView.loadImageUsingCacheWithURLString(avatar, placeHolder: nil)
        }
    }
}







