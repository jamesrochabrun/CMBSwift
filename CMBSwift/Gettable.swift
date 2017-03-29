//
//  Gettable.swift
//  CMBSwift
//
//  Created by James Rochabrun on 3/28/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import Foundation

protocol Gettable {
    associatedtype T
    func get(completion: @escaping (Result<T>) -> Void)
}
