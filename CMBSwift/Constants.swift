//
//  Constants.swift
//  CMBSwift
//
//  Created by James Rochabrun on 3/29/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import Foundation
import UIKit


struct Constants {
    struct UI {
        static let labelHeight: CGFloat = 20.0
        static let dividerLineHeight: CGFloat = 1.0
        static let cellPaddingVertical: CGFloat = 10.0
        static let infoViewHeight: CGFloat = (Constants.UI.labelHeight * 2) + Constants.UI.dividerLineHeight + (Constants.UI.cellPaddingVertical * 3)
        static let statusBarHeight: CGFloat = 22.0
        static let dismissButtonWidth: CGFloat = 44.0
        static let dismissButtonHeight: CGFloat = 48.0
    }
    
    struct Colors {
        //change this values to change the whole aspect of the app
        static let textWhiteColor: String = "#ffffff"
        static let backGroundColor: String = "#3f3f3f"
        static let blueColor: String = "#007cd5"
        static let redColor: String = "#ff348c"
    }
    
    struct  Font {
        static let medium = "HelveticaNeue-Medium"
        static let regular = "HelveticaNeue"
        static let thin = "HelveticaNeue-Thin"
        static let light = "HelveticaNeue-Light"
    }
}


