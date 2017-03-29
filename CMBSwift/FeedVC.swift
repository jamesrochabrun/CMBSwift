//
//  ViewController.swift
//  CMBSwift
//
//  Created by James Rochabrun on 3/28/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import UIKit
import  CoreData

class FeedVC: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .yellow
        collectionView?.register(TeamMembercell.self)
        
        let service = TeamService()
        service.get { (result) in
            dump(result)
            switch result {
            case .Success(let json):
                self.clearData()
               // self.saveInCoreDataWith(array: json)
            case .Error(let error):
                print(error)
            }

        }
    }
    
    private func saveInCoreDataWith(array: [[String: String]]) {
        _ = array.map{TeamMember.createTeamMemberFrom($0)}
        do {
            try CoreDataStack.sharedInstance.persistentContainer.viewContext.save()
        } catch let error {
            print(error)
        }
    }
    
    private func clearData() {
        do {
            
            let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: TeamMember.self))
            do {
                let objects  = try context.fetch(fetchRequest) as? [NSManagedObject]
                _ = objects.map{$0.map{context.delete($0)}}
                CoreDataStack.sharedInstance.saveContext()
            } catch let error {
                print("ERROR BY DELETING: \(error)")
            }
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as TeamMembercell
        cell.backgroundColor = .red
        return cell
        
    }
}



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



protocol Gettable {
    associatedtype T
    func get(completion: @escaping (Result<T>) -> Void)
}








