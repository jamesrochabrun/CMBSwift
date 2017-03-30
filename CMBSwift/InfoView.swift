//
//  InfoView.swift
//  CMBSwift
//
//  Created by James Rochabrun on 3/29/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import Foundation
import UIKit

class InfoView: BaseView {
    
    var teamMember: TeamViewModel? {
        didSet {
            if let name = teamMember?.fullName {
                self.nameLabel.text = name
            }
            if let title = teamMember?.title {
                self.titleLabel.text = title
            }
            if let avatarURL = teamMember?.avatar {
                avatarImageView.loadImageUsingCacheWithURLString(avatarURL, placeHolder: nil)
            }
        }
    }

    let avatarImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = UIScreen.main.bounds.width * 0.7 * 0.7 / 2
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label  = UILabel()
        label.textColor = UIColor.hexStringToUIColor(Constants.Colors.textWhiteColor)
        label.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let dividerLine: UIView = {
        let dv = UIView()
        dv.translatesAutoresizingMaskIntoConstraints = false
        dv.backgroundColor = UIColor.hexStringToUIColor(Constants.Colors.textWhiteColor)
        return dv
    }()
    
    let titleLabel: UILabel = {
        let label  = UILabel()
        label.textColor = UIColor.hexStringToUIColor(Constants.Colors.textWhiteColor)
        label.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override func setUpViews() {
        
        addSubview(avatarImageView)
        avatarImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7).isActive = true
        avatarImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7).isActive = true
        avatarImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.UI.cellPaddingVertical).isActive = true
        
        addSubview(nameLabel)
        nameLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: Constants.UI.cellPaddingVertical).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(titleLabel)
        titleLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Constants.UI.cellPaddingVertical).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(dividerLine)
        dividerLine.heightAnchor.constraint(equalToConstant: Constants.UI.dividerLineHeight).isActive = true
        dividerLine.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8).isActive = true
        dividerLine.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -5).isActive = true
        dividerLine.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
}







