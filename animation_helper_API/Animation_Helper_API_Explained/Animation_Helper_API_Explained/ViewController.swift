//
//  ViewController.swift
//  Animation_Helper_API_Explained
//
//  Created by Alex Jiang on 29/03/2016.
//  Copyright © 2016 Pigfly. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var square: UIView!
    var barrier: UIView!
    
    var dynamicAnimator = UIDynamicAnimator?()
    
    var gravityBehavior = UIGravityBehavior!()
    var collisionBehavior = UICollisionBehavior!()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // square init
        square = UIView.init(frame: CGRectMake(100, 100, 100, 100))
        square?.backgroundColor = UIColor.greenColor()
        view.addSubview(square)
        
        // barrier init
        barrier = UIView.init(frame: CGRectMake(0, 300, 130, 20))
        barrier.backgroundColor = UIColor.grayColor()
        view.addSubview(barrier)
        
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        
        gravityBehavior = UIGravityBehavior.init(items: [square])
        collisionBehavior = UICollisionBehavior.init(items: [square])
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        
        // dynamics only affect views that have been associated with behaviors.
        dynamicAnimator?.addBehavior(gravityBehavior)
        dynamicAnimator?.addBehavior(collisionBehavior)
        
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
    
    
    
}

