//
//  TeamService.swift
//  CMBSwift
//
//  Created by James Rochabrun on 3/28/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import Foundation
import UIKit

struct TeamService: Gettable {
    
    let downloader = JSONDownloader()
    
    typealias TeamMembersCompletionHandler = (Result<[[String: String]]>) -> Void
    
    func get(completion: @escaping TeamMembersCompletionHandler) {
        
        guard let filePath = Bundle.main.path(forResource: "team", ofType: "json") else {
            completion(.Error(.invalidPath))
            return
        }
        downloader.jsonTaskFrom(path: filePath) { (result) in
            switch result {
            case .Success(let json):
                completion(.Success(json))
            case .Error(let error):
                print(error)
                completion(.Error(error))
            }
        }
    }
}



