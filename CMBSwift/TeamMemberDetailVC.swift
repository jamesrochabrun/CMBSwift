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

extension TeamMemberDetailVC: FooterViewDelegate {
    
    func showAnimation() {
        (0...50).forEach { (_) in
            generateAnimatedViews({ (imageView) in
                UIView.animate(withDuration: 1.5) {
                    imageView.alpha = 0
                }
            })
        }
    }
    
    func generateAnimatedViews(_ completion:(_ imageView: UIImageView) -> Void) {
        
        let images = [#imageLiteral(resourceName: "star")]
        let index = Int(arc4random_uniform(UInt32(images.count)))
        print(index)
        let image = images[index]
        let imageView = UIImageView(image: image)
        let dimension = 20 + drand48() * 10
        imageView.frame = CGRect(x: 0, y: 0, width: dimension, height: dimension)
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = customPathFromButton().cgPath
        animation.duration = drand48() + 0.7
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        imageView.layer.add(animation , forKey: nil)
        view.addSubview(imageView)
        completion(imageView)
    }
    
    func generate(function: (_ bool: Bool) -> Void) {
        let images = [#imageLiteral(resourceName: "star")]
        let index = Int(arc4random_uniform(UInt32(images.count)))
        print(index)
        let image = images[index]
        let imageView = UIImageView(image: image)
        let dimension = 20 + drand48() * 10
        imageView.frame = CGRect(x: 0, y: 0, width: dimension, height: dimension)
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = customPathFromButton().cgPath
        animation.duration = drand48() + 0.8
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        imageView.layer.add(animation , forKey: nil)
        view.addSubview(imageView)
        
        UIView.animate(withDuration: animation.duration) {
            imageView.alpha = 0
        }
        
    }
    
    func customPath() -> UIBezierPath {
        let path = UIBezierPath()
        
        let randomX: CGFloat = CGFloat(drand48()) * self.view.frame.width
        path.move(to: CGPoint(x: randomX, y: self.view.frame.maxY))
        let endPoint = CGPoint(x: randomX, y: self.view.frame.minY)
        
        let cp1RandomX: CGFloat = CGFloat(drand48()) * self.view.frame.width
        let cpiRandomY: CGFloat = CGFloat(drand48()) * self.view.frame.height
        let cp2RandomX: CGFloat = CGFloat(drand48()) * self.view.frame.width
        let cp2RandomY: CGFloat = CGFloat(drand48()) * self.view.frame.height
        
        let cp1 = CGPoint(x: cp1RandomX, y: cpiRandomY)
        let cp2 = CGPoint(x: cp2RandomX, y: cp2RandomY)
        
        path.addCurve(to: endPoint, controlPoint1: cp1, controlPoint2: cp2)
        return path
    }
    
    func customPathFromButton() -> UIBezierPath {
        let path = UIBezierPath()
        
        let randomButtonX: CGFloat = CGFloat(drand48()) * self.footerView.frame.size.width
        let buttonOriginX: CGFloat = self.footerView.frame.origin.x
        path.move(to: CGPoint(x: buttonOriginX + randomButtonX , y: self.footerView.frame.origin.y + 50))
        
        let randomEndPointX: CGFloat = CGFloat(drand48()) * self.view.frame.size.width
        let endPoint = CGPoint(x: randomEndPointX, y: self.view.frame.minY)
        
        let cp1RandomX: CGFloat = CGFloat(drand48()) * self.view.frame.width
        let cpiRandomY: CGFloat = CGFloat(drand48()) * self.footerView.frame.origin.y
        let cp2RandomX: CGFloat = CGFloat(drand48()) * self.view.frame.width
        let cp2RandomY: CGFloat = CGFloat(drand48()) * self.footerView.frame.origin.y
        
        let cp1 = CGPoint(x: cp1RandomX, y: cpiRandomY)
        let cp2 = CGPoint(x: cp2RandomX, y: cp2RandomY)
        
        path.addCurve(to: endPoint, controlPoint1: cp1, controlPoint2: cp2)
        
        return path
    }
}













