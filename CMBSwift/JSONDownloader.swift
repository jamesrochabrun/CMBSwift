//
//  JSONDownloader.swift
//  CMBSwift
//
//  Created by James Rochabrun on 3/28/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import Foundation
import UIKit

struct JSONDownloader {
    
    typealias JSON = [[String: String]]
    typealias JSONTaskCompletionHandler = (Result<JSON>) -> Void
    
    func jsonTaskFrom(path: String, completionHandler completion: @escaping JSONTaskCompletionHandler) {
        
        if let content = NSData.init(contentsOfFile: path) {
            do {
                if let json = try JSONSerialization.jsonObject(with: content as Data, options: []) as? [[String: String]] {
                    completion(.Success(json))
                }
            } catch {
                completion(.Error(.invalidJSON))
            }
        }
    }
}

enum Result <T>{
    case Success(T)
    case Error(PathError)
}

enum PathError: Error {
    case invalidPath
    case invalidJSON
}

