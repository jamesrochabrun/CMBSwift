//
//  TeamMemberDetailVC.swift
//  CMBSwift
//
//  Created by James Rochabrun on 3/29/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import Foundation
import UIKit

class TeamMemberDetailVC: UITableViewController {
    
    private var teamMemberDataSource: TeamMemberDataSource?
    
    var teamMember: TeamMember? {
        didSet {
            if let teamMember = self.teamMember, let avatar = teamMember.avatar {
                self.backGroundIMageView.loadImageUsingCacheWithURLString(avatar, placeHolder: nil)
                self.teamMemberDataSource = TeamMemberDataSource(teamMember: teamMember)
                self.tableView.backgroundView = self.backGroundIMageView
            }
        }
    }
    
    let backGroundIMageView: UIImageView = {
        let miv = UIImageView()
        miv.blur(with: .light)
        miv.opaque(with: Constants.Colors.backGroundColor, alpha: 0.3)
        return miv
    }()
    
    lazy var headerView: BaseView = {
        let tv = BaseView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        tv.backgroundColor = UIColor.hexStringToUIColor(Constants.Colors.blueColor)
        return tv
    }()
    
    lazy var footerView: FooterView = {
        let f = FooterView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100))
        f.delegate = self
        return f
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = teamMemberDataSource
        tableView?.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.backgroundColor = UIColor.hexStringToUIColor(Constants.Colors.textWhiteColor)
        tableView.register(MainCell.self)
        tableView.register(BioCell.self)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        NotificationCenter.default.addObserver(self, selector: #selector(dismissView), name: NSNotification.Name.dismissViewNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func dismissView() {
        self.dismiss(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.UI.statusBarHeight
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? view.frame.size.width : self.tableView.rowHeight
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return footerView
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
}














