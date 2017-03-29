//
//  ViewController.swift
//  CMBSwift
//
//  Created by James Rochabrun on 3/28/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.//

import UIKit
import  CoreData

class FeedVC: UITableViewController {
    
    lazy var fetchedhResultController: NSFetchedResultsController<NSFetchRequestResult> = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: TeamMember.self))
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "lastName", ascending: true)]
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.sharedInstance.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        return frc
    }()
    
    lazy var topView: BaseView = {
        let tv = BaseView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        tv.backgroundColor = UIColor.hexStringToUIColor(Constants.Colors.blueColor)
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.backgroundColor = UIColor.hexStringToUIColor(Constants.Colors.backGroundColor)
        tableView?.register(TeamMemberCell.self)
        tableView.separatorStyle = .none
        updateTableContent()
    }
    
    func setUpViews() {
        view.addSubview(topView)
        topView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: Constants.UI.statusBarHeight).isActive = true
        topView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
    
    func updateTableContent() {
        
        do {
            try self.fetchedhResultController.performFetch()
            print("COUNT FETCHED FIRST: \(self.fetchedhResultController.sections?[0].numberOfObjects)")
        } catch let error  {
            print("ERROR: \(error)")
        }
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = fetchedhResultController.sections?.first?.numberOfObjects {
            return count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as TeamMemberCell
        if let teamMate = fetchedhResultController.object(at: indexPath) as? TeamMember {      
            let teamModel = TeamViewModel(teamMember: teamMate)
            cell.setCellWith(model: teamModel)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.width
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       return topView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.UI.statusBarHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = TeamMemberDetailVC()
        if let teamMember = self.fetchedhResultController.object(at: indexPath) as? TeamMember {
            detailVC.teamMember = teamMember
            self.present(detailVC, animated: true)
        }
    }
}

extension FeedVC: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            self.tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .delete:
            self.tableView.deleteRows(at: [indexPath!], with: .automatic)
        default:
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates()
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
}









