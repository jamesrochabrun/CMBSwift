//
//  FooterView.swift
//  MoviesApp
//
//  Created by James Rochabrun on 3/20/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import Foundation
import UIKit

protocol FooterViewDelegate: class {
    func showAnimation()
}

class FooterView: BaseView {
    
    weak var delegate: FooterViewDelegate?
    
    lazy var likeButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = UIColor.hexStringToUIColor(Constants.Colors.redColor)
        b.setTitle("LIKE", for: .normal)
        b.addTarget(self, action: #selector(handleTrigger), for: .touchUpInside)
        return b
    }()
    
    override func setUpViews() {
        translatesAutoresizingMaskIntoConstraints = true
        addSubview(likeButton)
        likeButton.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        likeButton.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        likeButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        likeButton.heightAnchor.constraint(equalToConstant: Constants.UI.likeButtonHeight).isActive = true
    }
    
    @objc private func handleTrigger() {
        delegate?.showAnimation()
    }
    
}











