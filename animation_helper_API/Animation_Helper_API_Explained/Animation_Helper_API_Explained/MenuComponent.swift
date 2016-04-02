//
//  MenuComponent.swift
//  Animation_Helper_API_Explained
//
//  Created by Alex Jiang on 2/04/2016.
//  Copyright © 2016 Pigfly. All rights reserved.
//

import Foundation
import UIKit

enum MenuDirectionOptions {
    case menuDirectionLeftToRight
    case menuDirectionRightToLeft
}


class MenuComponent: NSObject, UITableViewDelegate {
    private var isMenuShown: Bool
    private var menuDirection: MenuDirectionOptions
    private let menuOptions: NSArray
    private let menuOptionImages: NSArray
    
    private var menuFrame: CGRect
    private var menuInitFrame: CGRect?
    
    //  will be animated in and out. The table view will be a subview of this view.
    private var menuView: UIView?
    //  a semi-transparent view that will prevent the user from tapping anything but the menu view
    private var bgView: UIView?
    //  superview to which the menu and background views will be added
    private var targetView: UIView
    //  table view that will list the menu options
    private var optionsTableView: UITableView?
    
    private var animator: UIDynamicAnimator?
    
    //  public property
    var optionCellHeight: CGFloat?
    //  magnitude of the push behavior
    var acceleration: CGFloat?
    
    var menuBgColor: UIColor?
    var tableSettings: Dictionary<String, AnyObject>?

    
     init(frame: CGRect, targetView: UIView,
        direction: MenuDirectionOptions, options: NSArray, optionImgs: NSArray) {
        self.isMenuShown      = false
        self.menuDirection    = direction
        self.menuOptions      = options
        self.menuOptionImages = optionImgs

        self.menuFrame        = frame
        self.targetView       = targetView
        
        super.init()
            
        self.setupBackgroundView()
            
        self.setupMenuView()
            
//        self.setupOptionsTableView()
            
        self.setupTableViewSettings()
            
        self.setupSwipeGR()
            
        self.setupAnimator()
    }
    
    
    // MARK: Init Helper
    private func setupMenuView() {
        switch menuDirection {
        case .menuDirectionLeftToRight:
            // make menu initially to be out of screen's left edge
            menuInitFrame = CGRectMake(-menuFrame.width, menuFrame.minY,
                                        menuFrame.width, menuFrame.height)
        case .menuDirectionRightToLeft:
            // make menu initially to be out of screen's right edge
            menuInitFrame = CGRectMake(targetView.frame.width, menuFrame.minY,
                                        menuFrame.width, menuFrame.height)
        }
        
        menuView = UIView.init(frame: menuInitFrame!)
        menuView!.backgroundColor = UIColor.init(red: 0.0, green: 0.4, blue: 0.39, alpha: 1.0)
        targetView.addSubview(menuView!)
    }
    
    
    private func setupBackgroundView() {
        bgView = UIView.init(frame: targetView.frame)
        bgView?.backgroundColor = UIColor.init(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.0)
        targetView.addSubview(bgView!)
    }
    
    
    private func setupOptionsTableView() {
        optionsTableView = UITableView.init(frame: CGRectMake(0, 0,
                                                            menuView!.frame.width,
                                                            menuView!.frame.height))
        
        optionsTableView?.backgroundColor = UIColor.clearColor()
        optionsTableView?.scrollEnabled   = false
        optionsTableView?.separatorStyle  = .None
        menuView?.addSubview(optionsTableView!)

//        optionsTableView?.delegate        = self
//        optionsTableView?.dataSource      = self
    }
    
    
    private func setupTableViewSettings() {
        tableSettings = ["font": UIFont.init(name: "American Typewriter", size: 15.0)!,
                         "textAlignment": NSTextAlignment.Left.rawValue,
                         "textColor": UIColor.whiteColor(),
                         "selectionStyle": UITableViewCellSelectionStyle.Gray.rawValue]
    }
    
    
    private func setupSwipeGR() {
        let hideMenuGR = UISwipeGestureRecognizer.init(target: self, action: "hideMenuWithGesture:")
        
        switch menuDirection {
        case .menuDirectionLeftToRight:
            hideMenuGR.direction = .Left
        
        case .menuDirectionRightToLeft:
            hideMenuGR.direction = .Right
        }
        
        menuView?.addGestureRecognizer(hideMenuGR)
    }
    
    
    func hideMenuWithGesture(g: UISwipeGestureRecognizer) {
        toggleMenu()
        
        isMenuShown = false
    }
    
    
    private func setupAnimator() {
        animator         = UIDynamicAnimator.init(referenceView: targetView)

        acceleration     = 50.0

        isMenuShown      = false
        optionCellHeight = 50.0
        
    }
    
    
    // MARK: Menu
    func toggleMenu() {
        animator?.removeAllBehaviors()
        
        // This variable indicates the gravity direction.
        var gravityDirectionX: CGFloat
        
        // These two points specify an invisible boundary where the menu view should collide.
        var collisionPointFrom: CGPoint, collisionPointTo: CGPoint
        
        var pushMagnitude = acceleration
        
        // if menu hides
        if !isMenuShown {
            switch menuDirection {
            case .menuDirectionLeftToRight:
                gravityDirectionX = 1.0
                
                collisionPointFrom = CGPointMake(menuFrame.width, menuFrame.minY)
                collisionPointTo = CGPointMake(menuFrame.width, menuFrame.height)
                
            case .menuDirectionRightToLeft:
                gravityDirectionX = -1.0
                
                collisionPointFrom = CGPointMake(targetView.frame.width - menuFrame.width,
                                                 menuFrame.minY)
                collisionPointTo   = CGPointMake(targetView.frame.width - menuFrame.width,
                                                menuFrame.height)
                pushMagnitude = -pushMagnitude!
            }
            bgView?.alpha = 0.25
        }
        // if menu shows
        else {
            switch menuDirection {
            case .menuDirectionLeftToRight:
                gravityDirectionX = -1.0
                
                collisionPointFrom = CGPointMake(-menuFrame.width, menuFrame.minY)
                collisionPointTo = CGPointMake(-menuFrame.width, menuFrame.height)
                
                pushMagnitude = -pushMagnitude!
                
            case .menuDirectionRightToLeft:
                gravityDirectionX = 1.0
                
                collisionPointFrom = CGPointMake(targetView.frame.width + menuFrame.width,
                    menuFrame.minY)
                collisionPointTo   = CGPointMake(targetView.frame.width + menuFrame.width,
                    menuFrame.height)
            }
            bgView?.alpha = 0.0
        }
        
        let gravityBehavior = UIGravityBehavior.init(items: [menuView!])
        gravityBehavior.gravityDirection = CGVectorMake(gravityDirectionX, 0.0)
        animator?.addBehavior(gravityBehavior)
        
        let collisionBehavior = UICollisionBehavior.init(items: [menuView!])
        collisionBehavior.addBoundaryWithIdentifier("boundary", fromPoint: collisionPointFrom, toPoint: collisionPointTo)
        animator?.addBehavior(collisionBehavior)
        
        let itemBehavior = UIDynamicItemBehavior.init(items: [menuView!])
        itemBehavior.elasticity = 0.2
        itemBehavior.resistance = 0.3
        itemBehavior.angularResistance = 0.3
        animator?.addBehavior(itemBehavior)
        
        let pushBehavior = UIPushBehavior.init(items: [menuView!], mode: .Instantaneous)
        pushBehavior.magnitude = pushMagnitude!
        animator?.addBehavior(pushBehavior)
    }
    
    
    func showMenu() {
        if !isMenuShown {
            toggleMenu()
            
            isMenuShown = true
        }
    }
}