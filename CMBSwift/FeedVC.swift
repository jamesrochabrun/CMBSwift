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
    
    lazy var fetchedhResultController: NSFetchedResultsController<NSFetchRequestResult> = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: TeamMember.self))
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.sharedInstance.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
      //  frc.delegate = self
        return frc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .yellow
        collectionView?.register(TeamMembercell.self)
        getFeed(fromService: TeamService())
    }
    
    func getFeed<S: Gettable>(fromService service: S) where S.T == [[String : String]] {
        
        service.get { [weak self] (result) in
            switch result {
            case .Success(let json):
                self?.clearData()
                self?.saveInCoreDataWith(array: json)
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








