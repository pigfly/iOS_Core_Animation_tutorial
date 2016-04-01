//
//  ViewController.swift
//  Animation_Helper_API_Explained
//
//  Created by Alex Jiang on 29/03/2016.
//  Copyright © 2016 Pigfly. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollisionBehaviorDelegate {

    var square: UIView!
    var barrier: UIView!
    
    var dynamicAnimator = UIDynamicAnimator?()
    
    var gravityBehavior = UIGravityBehavior!()
    var collisionBehavior = UICollisionBehavior!()
    
    var itemBehavior = UIDynamicItemBehavior!()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // square init
        square = UIView.init(frame: CGRectMake(50, 50, 50, 50))
        square?.backgroundColor = UIColor.greenColor()
        view.addSubview(square)
        
        // barrier init
        barrier = UIView.init(frame: CGRectMake(0, 300, 70, 20))
        barrier.backgroundColor = UIColor.grayColor()
        view.addSubview(barrier)
        
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        
        gravityBehavior = UIGravityBehavior.init(items: [square])
        collisionBehavior = UICollisionBehavior.init(items: [square])
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        collisionBehavior.collisionDelegate = self
        
        // itemBehavior for setting physical properties
        itemBehavior = UIDynamicItemBehavior.init(items: [square])
        itemBehavior.elasticity = 0.6
        
        // dynamics only affect views that have been associated with behaviors.
        dynamicAnimator?.addBehavior(gravityBehavior)
        dynamicAnimator?.addBehavior(collisionBehavior)
        dynamicAnimator?.addBehavior(itemBehavior)
        
        // setup boundary for barrier
        setUpBoundaryForView(barrier)
    }
    
    
    /**
     adds an invisible boundary that coincides with the top edge of the barrier view.
     
     - parameter view: view to add boundary
     */
    func setUpBoundaryForView(view: UIView) {
        let rightEdge = CGPointMake(view.frame.origin.x + view.frame.size.width, view.frame.origin.y)
        
        collisionBehavior.addBoundaryWithIdentifier("barrier", fromPoint: barrier.frame.origin, toPoint: rightEdge)
    }
    
    
    // MARK: - Delegate
    func collisionBehavior(behavior: UICollisionBehavior, endedContactForItem item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?) {
        let itemView = item as! UIView
        
        let cloneViewX = itemView.frame.origin.x
        let cloneViewY = itemView.frame.origin.y - 60
        let cloneView = UIView.init(frame: CGRectMake(cloneViewX, cloneViewY, 50, 50))
        cloneView.backgroundColor = randomColor()
        view.addSubview(cloneView)
        
        let gBehavior = UIGravityBehavior.init(items: [cloneView])
        let cBehavior = UICollisionBehavior.init(items: [cloneView])
        let iBehavior = UIDynamicItemBehavior.init(items: [cloneView])
        
        cBehavior.translatesReferenceBoundsIntoBoundary = true
        iBehavior.elasticity = 0.8
        iBehavior.density = 0.2
        
        dynamicAnimator?.addBehavior(gBehavior)
        dynamicAnimator?.addBehavior(cBehavior)
        dynamicAnimator?.addBehavior(iBehavior)
    }
    
    
    // MARK: Helper
    func randomColor() -> UIColor{
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

