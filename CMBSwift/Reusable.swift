//
//  Reusable.swift
//  CMBSwift
//
//  Created by James Rochabrun on 3/28/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import Foundation
import UIKit

//////////////////////
protocol Reusable {}

extension Reusable where Self: UITableViewCell {
    static var reuseID: String {
        return String(describing: self)
    }
}

extension Reusable where Self: UICollectionViewCell  {
    static var reuseID: String {
        return String(describing: self)
    }
}

//////////////////////
extension UITableViewCell: Reusable {}
extension UICollectionViewCell: Reusable {}

/////////////////////////////////////////////
extension UITableView {
    
    func register<T: UITableViewCell>(_ cell: T.Type) where T: Reusable {
        register(cell.self, forCellReuseIdentifier: T.reuseID)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T where T: Reusable {
        
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseID, for: indexPath) as? T else {
            fatalError("could not deque cell with identifier")
        }
        return cell
    }
    
}

extension UICollectionView {
    
    func register<T: UICollectionViewCell>(_ cell: T.Type) where T: Reusable {
        register(cell.self, forCellWithReuseIdentifier: T.reuseID)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T where T: Reusable {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseID, for: indexPath) as? T else {
            fatalError("Could not deque cell with identifier")
        }
        return cell
    }
}


