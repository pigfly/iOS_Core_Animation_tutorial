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


class MenuComponent: NSObject {
    private var isMenuShown: Bool
    private var menuDirection: MenuDirectionOptions
    private let menuOptions: NSArray
    private let menuOptionImages: NSArray
    
    private var menuFrame: CGRect
    private let menuInitFrame: CGRect
    
    //  will be animated in and out. The table view will be a subview of this view.
    private var menuView: UIView?
    //  a semi-transparent view that will prevent the user from tapping anything but the menu view
    private var bgView: UIView?
    //  superview to which the menu and background views will be added
    private var targetView: UIView?
    //  table view that will list the menu options
    private var optionsTableView: UITableView?
    
    private var animator: UIDynamicAnimator?
    
    //  public property
    var optionCellHeight: CGFloat?
    //  magnitude of the push behavior
    var acceleration: CGFloat?
    
    var menuBgColor: UIColor?
    var tableSettings: NSMutableDictionary?

    
     init(frame: CGRect, targetView: UIView,
        direction: MenuDirectionOptions, options: NSArray, optionImgs: NSArray) {
        self.isMenuShown      = false
        self.menuDirection    = direction
        self.menuOptions      = options
        self.menuOptionImages = optionImgs

        self.menuFrame        = frame
        self.targetView       = targetView
        self.menuInitFrame    = CGRectZero
    }
    
    
    // MARK: Init Helper
    func setupMenuView() {
        
    }
}