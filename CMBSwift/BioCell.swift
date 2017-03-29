//
//  BioCell.swift
//  CMBSwift
//
//  Created by James Rochabrun on 3/29/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import Foundation
import UIKit

class BioCell: BaseCell {
    
    let summaryText: UITextView = {
        let tv =  UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.isUserInteractionEnabled = false
        tv.isScrollEnabled = false
        tv.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        tv.textColor = UIColor.hexStringToUIColor(Constants.Colors.textWhiteColor)
        tv.backgroundColor = .clear
        return tv
    }()
    
    override func setUPViews() {
        
        contentView.addSubview(summaryText)
        let marginGuide = contentView.layoutMarginsGuide
        summaryText.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor, constant: 10).isActive = true
        summaryText.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor, constant: -10).isActive = true
        summaryText.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        summaryText.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
    }
    
    func displayBioInCell(using viewModel: TeamViewModel) {
        if let bio = viewModel.bio {
            summaryText.text = bio
        }
    }
}
