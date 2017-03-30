//
//  TeamMemberDetailVCAnimation.swift
//  CMBSwift
//
//  Created by James Rochabrun on 3/29/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import Foundation
import UIKit

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
