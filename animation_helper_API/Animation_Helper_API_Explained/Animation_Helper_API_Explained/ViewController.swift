//
//  ViewController.swift
//  Animation_Helper_API_Explained
//
//  Created by Alex Jiang on 29/03/2016.
//  Copyright © 2016 Pigfly. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var menuCompoment: MenuComponent!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let showMenuGesture = UISwipeGestureRecognizer.init(target: self, action: "showMenu:")
        showMenuGesture.direction = .Left
        
        view.addGestureRecognizer(showMenuGesture)
        
        let desiredMenuFrame = CGRectMake(0.0, 20.0, 150.0, self.view.frame.height)
        menuCompoment = MenuComponent.init(frame: desiredMenuFrame, targetView: view, direction: MenuDirectionOptions.menuDirectionRightToLeft, options: [], optionImgs: [])
    }

    func showMenu(g: UIGestureRecognizer) {
        menuCompoment.showMenu()
    }
}

